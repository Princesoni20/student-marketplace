const pool = require("../config/db");
const {
  connectRedis,
  getRedis,
} = require("../config/redis");

const PRODUCT_CACHE_TTL = 60;

const buildProductsCacheKey = ({
  page,
  limit,
  search,
  category,
}) => {
  return [
    "products",
    `page=${page}`,
    `limit=${limit}`,
    `search=${encodeURIComponent(search || "")}`,
    `category=${encodeURIComponent(category || "")}`,
  ].join(":");
};

const buildProductCacheKey = (id) => {
  return `product:${id}`;
};

const getRedisClient = async () => {
  try {
    await connectRedis();

    const redis = getRedis();

    if (!redis || !redis.isReady) {
      return null;
    }

    return redis;
  } catch (error) {
    console.error("Redis connection error:", error.message);
    return null;
  }
};

const getCachedValue = async (key) => {
  const redis = await getRedisClient();

  if (!redis) {
    return null;
  }

  try {
    return await redis.get(key);
  } catch (error) {
    console.error(
      `Redis GET error for ${key}:`,
      error.message
    );

    return null;
  }
};

const setCachedValue = async (
  key,
  value,
  ttl = PRODUCT_CACHE_TTL
) => {
  const redis = await getRedisClient();

  if (!redis) {
    return false;
  }

  try {
    await redis.set(key, value, {
      EX: ttl,
    });

    return true;
  } catch (error) {
    console.error(
      `Redis SET error for ${key}:`,
      error.message
    );

    return false;
  }
};

const deleteCachedValue = async (key) => {
  const redis = await getRedisClient();

  if (!redis) {
    return false;
  }

  try {
    await redis.del(key);
    return true;
  } catch (error) {
    console.error(
      `Redis DELETE error for ${key}:`,
      error.message
    );

    return false;
  }
};

const getAllProducts = async (options = {}) => {
  const {
    page = 1,
    limit = 20,
    search = "",
    category = "",
  } = options;

  const safePage = Math.max(
    parseInt(page, 10) || 1,
    1
  );

  const safeLimit = Math.min(
    Math.max(parseInt(limit, 10) || 20, 1),
    100
  );

  const safeSearch = String(search || "").trim();
  const safeCategory = String(
    category || ""
  ).trim();

  const cacheKey = buildProductsCacheKey({
    page: safePage,
    limit: safeLimit,
    search: safeSearch,
    category: safeCategory,
  });

  // =====================================================
  // REDIS CACHE LOOKUP
  // =====================================================

  const cachedData = await getCachedValue(cacheKey);

  if (cachedData) {
    try {
      return JSON.parse(cachedData);
    } catch (error) {
      console.error(
        "Invalid product cache data:",
        error.message
      );

      await deleteCachedValue(cacheKey);
    }
  }

  // =====================================================
  // POSTGRESQL
  // =====================================================

  const offset =
    (safePage - 1) * safeLimit;

  const values = [];
  const conditions = [];

  if (safeSearch) {
    values.push(`%${safeSearch}%`);

    conditions.push(`
      (
        p.name ILIKE $${values.length}
        OR p.sku ILIKE $${values.length}
        OR p.brand ILIKE $${values.length}
        OR p.description ILIKE $${values.length}
      )
    `);
  }

  if (safeCategory) {
    values.push(safeCategory);

    conditions.push(`
      (
        c.slug = $${values.length}
        OR c.name ILIKE $${values.length}
      )
    `);
  }

  const whereClause =
    conditions.length > 0
      ? `WHERE ${conditions.join(" AND ")}`
      : "";

  const countResult = await pool.query(
    `
      SELECT COUNT(*) AS total
      FROM products p
      LEFT JOIN categories c
        ON c.id = p.category_id
      ${whereClause}
    `,
    values
  );

  const total = Number(
    countResult.rows[0].total
  );

  const dataValues = [
    ...values,
    safeLimit,
    offset,
  ];

  const result = await pool.query(
    `
      SELECT
        p.id,
        p.category_id,
        p.sku,
        p.name,
        p.slug,
        p.description,
        p.brand,
        p.price,
        p.discount_price,

        (
          SELECT COALESCE(
            json_agg(
              json_build_object(
                'id', pi.id,
                'image_url', pi.image_url,
                'alt_text', pi.alt_text,
                'sort_order', pi.sort_order,
                'is_primary', pi.is_primary
              )
              ORDER BY pi.sort_order ASC
            ),
            '[]'::json
          )
          FROM product_images pi
          WHERE pi.product_id = p.id
        ) AS images,

        c.name AS category_name,
        c.slug AS category_slug

      FROM products p

      LEFT JOIN categories c
        ON c.id = p.category_id

      ${whereClause}

      ORDER BY p.name ASC

      LIMIT $${dataValues.length - 1}
      OFFSET $${dataValues.length}
    `,
    dataValues
  );

  const totalPages =
    Math.ceil(total / safeLimit);

  const response = {
    products: result.rows,

    pagination: {
      page: safePage,
      limit: safeLimit,
      total,
      totalPages,
      hasNextPage:
        safePage < totalPages,
      hasPreviousPage:
        safePage > 1,
    },
  };

  // =====================================================
  // SAVE TO REDIS
  // =====================================================

  await setCachedValue(
    cacheKey,
    JSON.stringify(response),
    PRODUCT_CACHE_TTL
  );

  return response;
};

const getProductById = async (id) => {
  const cacheKey = buildProductCacheKey(id);

  // =====================================================
  // REDIS CACHE LOOKUP
  // =====================================================

  const cachedProduct =
    await getCachedValue(cacheKey);

  if (cachedProduct) {
    try {
      return JSON.parse(cachedProduct);
    } catch (error) {
      console.error(
        "Invalid product cache data:",
        error.message
      );

      await deleteCachedValue(cacheKey);
    }
  }

  // =====================================================
  // POSTGRESQL
  // =====================================================

  const result = await pool.query(
    `
      SELECT
        p.id,
        p.category_id,
        p.sku,
        p.name,
        p.slug,
        p.description,
        p.brand,
        p.price,
        p.discount_price,

        (
          SELECT COALESCE(
            json_agg(
              json_build_object(
                'id', pi.id,
                'image_url', pi.image_url,
                'alt_text', pi.alt_text,
                'sort_order', pi.sort_order,
                'is_primary', pi.is_primary
              )
              ORDER BY pi.sort_order ASC
            ),
            '[]'::json
          )
          FROM product_images pi
          WHERE pi.product_id = p.id
        ) AS images,

        c.name AS category_name,
        c.slug AS category_slug

      FROM products p

      LEFT JOIN categories c
        ON c.id = p.category_id

      WHERE p.id = $1
    `,
    [id]
  );

  const product =
    result.rows[0] || null;

  // =====================================================
  // SAVE PRODUCT TO REDIS
  // =====================================================

  if (product) {
    await setCachedValue(
      cacheKey,
      JSON.stringify(product),
      PRODUCT_CACHE_TTL
    );
  }

  return product;
};

module.exports = {
  getAllProducts,
  getProductById,
};