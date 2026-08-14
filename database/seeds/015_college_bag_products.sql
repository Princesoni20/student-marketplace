-- ============================================================
-- STUDENT MARKETPLACE
-- COLLEGE BAG PRODUCTS
-- ============================================================

BEGIN;

-- ============================================================
-- COLLEGE BACKPACK
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT
    c.id,
    v.sku,
    v.name,
    v.slug,
    v.description,
    v.brand,
    v.price,
    v.discount_price,
    TRUE,
    v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    (
        'CBAG-BP-001',
        'American Tourister College Backpack',
        'american-tourister-college-backpack',
        'Spacious college backpack suitable for books, notebooks and daily student essentials.',
        'American Tourister',
        1499.00, 1299.00, TRUE
    ),
    (
        'CBAG-BP-002',
        'Skybags College Backpack',
        'skybags-college-backpack',
        'Stylish and durable backpack designed for college students.',
        'Skybags',
        1299.00, 1149.00, TRUE
    ),
    (
        'CBAG-BP-003',
        'Wildcraft College Backpack',
        'wildcraft-college-backpack',
        'Comfortable multi-compartment backpack for college, commuting and daily use.',
        'Wildcraft',
        1699.00, 1499.00, TRUE
    ),
    (
        'CBAG-BP-004',
        'Aristocrat College Backpack',
        'aristocrat-college-backpack',
        'Affordable everyday backpack for students with multiple storage compartments.',
        'Aristocrat',
        999.00, 899.00, TRUE
    ),
    (
        'CBAG-BP-005',
        'American Tourister Casual Backpack',
        'american-tourister-casual-backpack',
        'Casual backpack for books, stationery and everyday college requirements.',
        'American Tourister',
        1299.00, 1149.00, FALSE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'college-backpack'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- CASUAL BACKPACK
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT
    c.id,
    v.sku,
    v.name,
    v.slug,
    v.description,
    v.brand,
    v.price,
    v.discount_price,
    TRUE,
    v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    (
        'CBAG-CASUAL-001',
        'Skybags Casual Backpack',
        'skybags-casual-backpack',
        'Lightweight casual backpack suitable for college, outings and daily travel.',
        'Skybags',
        1099.00, 999.00, TRUE
    ),
    (
        'CBAG-CASUAL-002',
        'Wildcraft Casual Backpack',
        'wildcraft-casual-backpack',
        'Durable casual backpack for students and everyday travel.',
        'Wildcraft',
        1299.00, 1149.00, TRUE
    ),
    (
        'CBAG-CASUAL-003',
        'Aristocrat Casual Backpack',
        'aristocrat-casual-backpack',
        'Affordable casual backpack for daily student use.',
        'Aristocrat',
        799.00, 699.00, TRUE
    ),
    (
        'CBAG-CASUAL-004',
        'F Gear Casual Backpack',
        'f-gear-casual-backpack',
        'Stylish everyday backpack suitable for college students.',
        'F Gear',
        1199.00, 1049.00, FALSE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'casual-backpack'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- TRAVEL / COLLEGE BACKPACK
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT
    c.id,
    v.sku,
    v.name,
    v.slug,
    v.description,
    v.brand,
    v.price,
    v.discount_price,
    TRUE,
    v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    (
        'CBAG-TRAVEL-001',
        'Wildcraft Travel College Backpack',
        'wildcraft-travel-college-backpack',
        'Large-capacity backpack suitable for college, travel and weekend trips.',
        'Wildcraft',
        1999.00, 1799.00, TRUE
    ),
    (
        'CBAG-TRAVEL-002',
        'American Tourister Travel Backpack',
        'american-tourister-travel-backpack',
        'Spacious travel backpack suitable for college students and short trips.',
        'American Tourister',
        1899.00, 1699.00, TRUE
    ),
    (
        'CBAG-TRAVEL-003',
        'Skybags Travel Backpack',
        'skybags-travel-backpack',
        'Multi-compartment backpack for college, travel and daily commuting.',
        'Skybags',
        1799.00, 1599.00, TRUE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'travel-college-backpack'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- INVENTORY
-- ============================================================

INSERT INTO inventory (product_id, quantity)
SELECT
    p.id,
    20
FROM products p
WHERE p.sku LIKE 'CBAG-%'
AND NOT EXISTS (
    SELECT 1
    FROM inventory i
    WHERE i.product_id = p.id
);

COMMIT;