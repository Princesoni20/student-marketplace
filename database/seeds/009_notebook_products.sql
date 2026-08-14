-- ============================================================
-- STUDENT MARKETPLACE
-- NOTEBOOK PRODUCTS
-- ============================================================

BEGIN;

-- ============================================================
-- CLASS NOTEBOOK
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
        'NOTE-CLASS-001',
        'Classmate Pulse Single Line Notebook',
        'classmate-pulse-single-line-notebook',
        'Everyday single-line notebook for class notes and assignments.',
        'Classmate',
        55.00, 50.00, TRUE
    ),
    (
        'NOTE-CLASS-002',
        'Classmate Pulse Long Notebook',
        'classmate-pulse-long-notebook',
        'Long notebook suitable for regular school and college notes.',
        'Classmate',
        75.00, 70.00, TRUE
    ),
    (
        'NOTE-CLASS-003',
        'Navneet Youva Classmate Notebook',
        'navneet-youva-class-notebook',
        'Student notebook for daily classroom writing and assignments.',
        'Navneet',
        60.00, 55.00, TRUE
    ),
    (
        'NOTE-CLASS-004',
        'Paperkraft Class Notebook',
        'paperkraft-class-notebook',
        'Premium notebook suitable for classroom notes and study planning.',
        'Paperkraft',
        110.00, 99.00, FALSE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'class-notebook'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- SPIRAL NOTEBOOK
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
        'NOTE-SPIRAL-001',
        'Classmate Pulse Spiral Notebook',
        'classmate-pulse-spiral-notebook',
        'Spiral-bound notebook for college notes and everyday study.',
        'Classmate',
        95.00, 89.00, TRUE
    ),
    (
        'NOTE-SPIRAL-002',
        'Paperkraft Spiral Notebook',
        'paperkraft-spiral-notebook',
        'Premium spiral notebook for students and professionals.',
        'Paperkraft',
        160.00, 145.00, TRUE
    ),
    (
        'NOTE-SPIRAL-003',
        'Navneet Youva Spiral Notebook',
        'navneet-youva-spiral-notebook',
        'Spiral notebook designed for classroom notes and assignments.',
        'Navneet',
        90.00, 85.00, TRUE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'spiral-notebook'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- PRACTICAL NOTEBOOK
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
        'NOTE-PRACTICAL-001',
        'Classmate Practical Notebook',
        'classmate-practical-notebook',
        'Practical record notebook suitable for school and college laboratory work.',
        'Classmate',
        80.00, 75.00, TRUE
    ),
    (
        'NOTE-PRACTICAL-002',
        'Navneet Practical Record Book',
        'navneet-practical-record-book',
        'Record notebook for maintaining laboratory practical work.',
        'Navneet',
        75.00, 70.00, TRUE
    ),
    (
        'NOTE-PRACTICAL-003',
        'Lab Record Notebook',
        'student-lab-record-notebook',
        'Practical record book for science and engineering students.',
        'Student Marketplace',
        70.00, 65.00, FALSE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'practical-notebook'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- ROUGH NOTEBOOK
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
        'NOTE-ROUGH-001',
        'Classmate Rough Notebook',
        'classmate-rough-notebook',
        'Rough notebook for calculations, practice and everyday work.',
        'Classmate',
        45.00, 40.00, TRUE
    ),
    (
        'NOTE-ROUGH-002',
        'Navneet Youva Rough Notebook',
        'navneet-youva-rough-notebook',
        'Affordable rough notebook for student practice and calculations.',
        'Navneet',
        40.00, 36.00, TRUE
    ),
    (
        'NOTE-ROUGH-003',
        'Paperkraft Rough Notebook',
        'paperkraft-rough-notebook',
        'Quality rough notebook for study and everyday writing.',
        'Paperkraft',
        70.00, 65.00, FALSE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'rough-notebook'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- LONG NOTEBOOK
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
        'NOTE-LONG-001',
        'Classmate Long Notebook',
        'classmate-long-notebook',
        'Long-format notebook for detailed class notes and assignments.',
        'Classmate',
        70.00, 65.00, TRUE
    ),
    (
        'NOTE-LONG-002',
        'Navneet Youva Long Notebook',
        'navneet-youva-long-notebook',
        'Long notebook suitable for school and college students.',
        'Navneet',
        65.00, 60.00, TRUE
    ),
    (
        'NOTE-LONG-003',
        'Paperkraft Long Notebook',
        'paperkraft-long-notebook',
        'Premium long notebook for extensive notes and study.',
        'Paperkraft',
        120.00, 109.00, FALSE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'long-notebook'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- INVENTORY
-- ============================================================

INSERT INTO inventory (product_id, quantity)
SELECT
    p.id,
    25
FROM products p
WHERE p.sku LIKE 'NOTE-%'
AND NOT EXISTS (
    SELECT 1
    FROM inventory i
    WHERE i.product_id = p.id
);

COMMIT;