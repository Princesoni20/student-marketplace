-- ============================================================
-- STUDENT MARKETPLACE
-- LAPTOP BAG PRODUCTS
-- ============================================================

BEGIN;

-- ============================================================
-- LAPTOP BACKPACK
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
        'LBAG-BP-001',
        'American Tourister Laptop Backpack',
        'american-tourister-laptop-backpack',
        'Durable laptop backpack with dedicated laptop compartment for college and daily travel.',
        'American Tourister',
        1499.00, 1299.00, TRUE
    ),
    (
        'LBAG-BP-002',
        'Skybags Casual Laptop Backpack',
        'skybags-casual-laptop-backpack',
        'Student-friendly backpack with laptop compartment and multiple storage sections.',
        'Skybags',
        1299.00, 1149.00, TRUE
    ),
    (
        'LBAG-BP-003',
        'Wildcraft Laptop Backpack',
        'wildcraft-laptop-backpack',
        'Comfortable laptop backpack suitable for college, commuting and travel.',
        'Wildcraft',
        1799.00, 1599.00, TRUE
    ),
    (
        'LBAG-BP-004',
        'Aristocrat Laptop Backpack',
        'aristocrat-laptop-backpack',
        'Affordable backpack with dedicated laptop and accessory compartments.',
        'Aristocrat',
        999.00, 899.00, FALSE
    ),
    (
        'LBAG-BP-005',
        'Lenovo Laptop Backpack',
        'lenovo-laptop-backpack',
        'Laptop backpack designed for carrying laptops, chargers and student accessories.',
        'Lenovo',
        1599.00, 1399.00, TRUE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'laptop-backpack'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- LAPTOP SLEEVE
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
        'LBAG-SLEEVE-001',
        'AmazonBasics Laptop Sleeve',
        'amazonbasics-laptop-sleeve',
        'Protective laptop sleeve for everyday college and travel use.',
        'AmazonBasics',
        699.00, 599.00, TRUE
    ),
    (
        'LBAG-SLEEVE-002',
        'HP Laptop Sleeve',
        'hp-laptop-sleeve',
        'Slim protective sleeve suitable for HP and compatible laptops.',
        'HP',
        899.00, 799.00, TRUE
    ),
    (
        'LBAG-SLEEVE-003',
        'Dell Laptop Sleeve',
        'dell-laptop-sleeve',
        'Protective sleeve designed for laptops and everyday commuting.',
        'Dell',
        899.00, 799.00, FALSE
    ),
    (
        'LBAG-SLEEVE-004',
        'Targus Laptop Sleeve',
        'targus-laptop-sleeve',
        'Premium protective sleeve for students and professionals.',
        'Targus',
        1299.00, 1149.00, TRUE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'laptop-sleeve'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- LAPTOP MESSENGER BAG
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
        'LBAG-MSG-001',
        'American Tourister Laptop Messenger Bag',
        'american-tourister-laptop-messenger-bag',
        'Professional messenger bag with laptop compartment for college and office use.',
        'American Tourister',
        1399.00, 1249.00, TRUE
    ),
    (
        'LBAG-MSG-002',
        'Aristocrat Laptop Messenger Bag',
        'aristocrat-laptop-messenger-bag',
        'Affordable laptop messenger bag for students and daily commuting.',
        'Aristocrat',
        999.00, 899.00, TRUE
    ),
    (
        'LBAG-MSG-003',
        'Targus Laptop Messenger Bag',
        'targus-laptop-messenger-bag',
        'Premium messenger bag with organized compartments for laptop and accessories.',
        'Targus',
        1799.00, 1599.00, FALSE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'laptop-messenger-bag'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- INVENTORY
-- ============================================================

INSERT INTO inventory (product_id, quantity)
SELECT
    p.id,
    20
FROM products p
WHERE p.sku LIKE 'LBAG-%'
AND NOT EXISTS (
    SELECT 1
    FROM inventory i
    WHERE i.product_id = p.id
);

COMMIT;