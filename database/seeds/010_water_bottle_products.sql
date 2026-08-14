-- ============================================================
-- STUDENT MARKETPLACE
-- WATER BOTTLE PRODUCTS
-- ============================================================

BEGIN;

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
        'BOTTLE-001',
        'Milton Thermosteel Flask',
        'milton-thermosteel-flask',
        'Insulated stainless-steel bottle suitable for college, travel and daily use.',
        'Milton',
        699.00, 629.00, TRUE
    ),
    (
        'BOTTLE-002',
        'Milton Kool Rider Water Bottle',
        'milton-kool-rider-water-bottle',
        'Reusable water bottle suitable for students and everyday outdoor use.',
        'Milton',
        399.00, 359.00, TRUE
    ),
    (
        'BOTTLE-003',
        'Borosil Hydra Stainless Steel Bottle',
        'borosil-hydra-stainless-steel-bottle',
        'Durable stainless-steel bottle designed for everyday hydration.',
        'Borosil',
        599.00, 539.00, TRUE
    ),
    (
        'BOTTLE-004',
        'Cello H2O Unbreakable Bottle',
        'cello-h2o-unbreakable-bottle',
        'Lightweight reusable bottle suitable for school and college students.',
        'Cello',
        249.00, 219.00, TRUE
    ),
    (
        'BOTTLE-005',
        'Tupperware Eco Bottle',
        'tupperware-eco-bottle',
        'Reusable lightweight bottle for everyday student use.',
        'Tupperware',
        499.00, 449.00, TRUE
    ),
    (
        'BOTTLE-006',
        'Signoraware Stainless Steel Bottle',
        'signoraware-stainless-steel-bottle',
        'Reusable stainless-steel bottle for college and travel.',
        'Signoraware',
        449.00, 399.00, FALSE
    ),
    (
        'BOTTLE-007',
        'Nayasa BPA Free Water Bottle',
        'nayasa-bpa-free-water-bottle',
        'Lightweight BPA-free reusable bottle for daily student use.',
        'Nayasa',
        199.00, 179.00, TRUE
    ),
    (
        'BOTTLE-008',
        'Pigeon Stainless Steel Water Bottle',
        'pigeon-stainless-steel-water-bottle',
        'Stainless-steel reusable bottle suitable for everyday use.',
        'Pigeon',
        499.00, 449.00, FALSE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'water-bottle'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- INVENTORY
-- ============================================================

INSERT INTO inventory (product_id, quantity)
SELECT
    p.id,
    25
FROM products p
WHERE p.sku LIKE 'BOTTLE-%'
AND NOT EXISTS (
    SELECT 1
    FROM inventory i
    WHERE i.product_id = p.id
);

COMMIT;