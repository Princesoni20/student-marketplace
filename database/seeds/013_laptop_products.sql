-- ============================================================
-- STUDENT MARKETPLACE
-- LAPTOP PRODUCTS
-- ============================================================

BEGIN;

-- ============================================================
-- WINDOWS LAPTOPS
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
        'LAP-HP-001',
        'HP 15s Intel Core i5 Laptop',
        'hp-15s-intel-core-i5-laptop',
        'Everyday student laptop suitable for programming, study, office work and development.',
        'HP',
        59999.00, 54999.00, TRUE
    ),
    (
        'LAP-HP-002',
        'HP Pavilion 14 Intel Core i5',
        'hp-pavilion-14-intel-core-i5',
        'Compact performance laptop suitable for students, coding and productivity.',
        'HP',
        69999.00, 64999.00, TRUE
    ),
    (
        'LAP-DELL-001',
        'Dell Inspiron 15 Intel Core i5',
        'dell-inspiron-15-intel-core-i5',
        'Student-friendly laptop for programming, academics and everyday productivity.',
        'Dell',
        64999.00, 59999.00, TRUE
    ),
    (
        'LAP-DELL-002',
        'Dell Inspiron 14 Intel Core i5',
        'dell-inspiron-14-intel-core-i5',
        'Portable laptop designed for students, coding and office productivity.',
        'Dell',
        67999.00, 62999.00, FALSE
    ),
    (
        'LAP-LENOVO-001',
        'Lenovo IdeaPad Slim 3',
        'lenovo-ideapad-slim-3',
        'Slim student laptop for programming, study, browsing and productivity.',
        'Lenovo',
        57999.00, 52999.00, TRUE
    ),
    (
        'LAP-LENOVO-002',
        'Lenovo ThinkBook 15',
        'lenovo-thinkbook-15',
        'Business-class laptop suitable for students, development and professional work.',
        'Lenovo',
        69999.00, 64999.00, FALSE
    ),
    (
        'LAP-ASUS-001',
        'ASUS Vivobook 15',
        'asus-vivobook-15',
        'Versatile laptop for students, coding, multimedia and daily productivity.',
        'ASUS',
        59999.00, 54999.00, TRUE
    ),
    (
        'LAP-ASUS-002',
        'ASUS Vivobook S 14',
        'asus-vivobook-s-14',
        'Portable performance laptop suitable for programming and college work.',
        'ASUS',
        74999.00, 69999.00, TRUE
    ),
    (
        'LAP-ACER-001',
        'Acer Aspire 5',
        'acer-aspire-5',
        'Performance-oriented laptop for students, programming and everyday use.',
        'Acer',
        57999.00, 52999.00, TRUE
    ),
    (
        'LAP-ACER-002',
        'Acer Aspire Lite',
        'acer-aspire-lite',
        'Affordable laptop suitable for academic work, browsing and coding.',
        'Acer',
        49999.00, 45999.00, FALSE
    ),
    (
        'LAP-MSI-001',
        'MSI Modern 14',
        'msi-modern-14',
        'Performance laptop suitable for programming, development and creative student work.',
        'MSI',
        64999.00, 59999.00, TRUE
    ),
    (
        'LAP-MSI-002',
        'MSI Thin Gaming Laptop',
        'msi-thin-gaming-laptop',
        'High-performance laptop suitable for development, engineering software and gaming.',
        'MSI',
        79999.00, 74999.00, FALSE
    ),
    (
        'LAP-SURFACE-001',
        'Microsoft Surface Laptop',
        'microsoft-surface-laptop',
        'Premium Windows laptop with a portable design for students and professionals.',
        'Microsoft',
        99999.00, 94999.00, TRUE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'windows-laptops'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- MACBOOK AIR
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
        'MAC-AIR-001',
        'MacBook Air 13-inch',
        'macbook-air-13-inch',
        'Lightweight Apple laptop suitable for students, programming and everyday productivity.',
        'Apple',
        99999.00, 94999.00, TRUE
    ),
    (
        'MAC-AIR-002',
        'MacBook Air 15-inch',
        'macbook-air-15-inch',
        'Large-screen MacBook Air suitable for coding, study and professional productivity.',
        'Apple',
        119999.00, 114999.00, TRUE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'macbook-air'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- MACBOOK PRO
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
        'MAC-PRO-001',
        'MacBook Pro 14-inch',
        'macbook-pro-14-inch',
        'Professional Apple laptop for software development, engineering and demanding workloads.',
        'Apple',
        169999.00, 162999.00, TRUE
    ),
    (
        'MAC-PRO-002',
        'MacBook Pro 16-inch',
        'macbook-pro-16-inch',
        'High-performance professional laptop for development, engineering and creative workloads.',
        'Apple',
        229999.00, 219999.00, TRUE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'macbook-pro'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- INVENTORY
-- ============================================================

INSERT INTO inventory (product_id, quantity)
SELECT
    p.id,
    10
FROM products p
WHERE (
    p.sku LIKE 'LAP-%'
    OR p.sku LIKE 'MAC-%'
)
AND NOT EXISTS (
    SELECT 1
    FROM inventory i
    WHERE i.product_id = p.id
);
COMMIT;