-- ============================================================
-- STUDENT MARKETPLACE
-- GEOMETRY BOX PRODUCTS
-- ============================================================

BEGIN;

-- ============================================================
-- PENCIL
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
        'GEO-PENCIL-001',
        'Apsara Platinum Extra Dark Pencil',
        'apsara-platinum-extra-dark-pencil',
        'Smooth graphite pencil suitable for writing, drawing and geometry work.',
        'Apsara',
        10.00, 9.00, TRUE
    ),
    (
        'GEO-PENCIL-002',
        'Nataraj HB Pencil',
        'nataraj-hb-pencil',
        'Reliable HB pencil for everyday school and college use.',
        'Nataraj',
        8.00, 7.00, TRUE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'geometry-pencil'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- ERASER
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
        'GEO-ERASER-001',
        'Apsara Non Dust Eraser',
        'apsara-non-dust-eraser',
        'Clean-writing eraser suitable for students and drawing work.',
        'Apsara',
        10.00, 9.00, TRUE
    ),
    (
        'GEO-ERASER-002',
        'Nataraj Eraser',
        'nataraj-eraser',
        'Everyday eraser for school, college and geometry work.',
        'Nataraj',
        8.00, 7.00, TRUE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'geometry-eraser'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- SHARPENER
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
        'GEO-SHARP-001',
        'Apsara Long Point Sharpener',
        'apsara-long-point-sharpener',
        'Compact pencil sharpener suitable for school and geometry work.',
        'Apsara',
        15.00, 13.00, TRUE
    ),
    (
        'GEO-SHARP-002',
        'Nataraj Pencil Sharpener',
        'nataraj-pencil-sharpener',
        'Simple and durable sharpener for everyday student use.',
        'Nataraj',
        10.00, 9.00, TRUE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'geometry-sharpener'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- SCALE / RULER
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
        'GEO-SCALE-001',
        'Camlin Plastic Ruler 15 cm',
        'camlin-plastic-ruler-15cm',
        '15 cm ruler for geometry, drawing and everyday measurement.',
        'Camlin',
        15.00, 13.00, TRUE
    ),
    (
        'GEO-SCALE-002',
        'Classmate Scale 30 cm',
        'classmate-scale-30cm',
        '30 cm ruler suitable for students and technical drawing.',
        'Classmate',
        25.00, 22.00, TRUE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'geometry-scale-ruler'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- COMPASS
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
        'GEO-COMPASS-001',
        'Camlin Exam Compass',
        'camlin-exam-compass',
        'Precision compass for geometry and mathematical drawing.',
        'Camlin',
        35.00, 32.00, TRUE
    ),
    (
        'GEO-COMPASS-002',
        'Faber-Castell Compass',
        'faber-castell-compass',
        'Durable compass suitable for school and technical drawing.',
        'Faber-Castell',
        85.00, 75.00, TRUE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'geometry-compass'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- DIVIDER
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
        'GEO-DIVIDER-001',
        'Camlin Mathematical Divider',
        'camlin-mathematical-divider',
        'Divider for measurement and geometry drawing.',
        'Camlin',
        45.00, 40.00, TRUE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'geometry-divider'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- PROTRACTOR
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
        'GEO-PROTRACTOR-001',
        'Camlin 180 Degree Protractor',
        'camlin-180-degree-protractor',
        'Transparent protractor for measuring angles in geometry.',
        'Camlin',
        15.00, 13.00, TRUE
    ),
    (
        'GEO-PROTRACTOR-002',
        'Classmate Geometry Protractor',
        'classmate-geometry-protractor',
        'Student-friendly protractor for mathematics and geometry.',
        'Classmate',
        15.00, 13.00, FALSE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'geometry-protractor'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- SET SQUARES
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
        'GEO-SQUARE-001',
        'Camlin Set Squares 45 Degree and 60 Degree',
        'camlin-set-squares-45-60-degree',
        'Set square pair for geometry, drawing and technical work.',
        'Camlin',
        35.00, 32.00, TRUE
    ),
    (
        'GEO-SQUARE-002',
        'Faber-Castell Set Square',
        'faber-castell-set-square',
        'Durable set square for students and technical drawing.',
        'Faber-Castell',
        55.00, 49.00, FALSE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'geometry-set-squares'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- MECHANICAL PENCIL
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
        'GEO-MECHANICAL-001',
        'Pentonic Mechanical Pencil 0.5 mm',
        'pentonic-mechanical-pencil-05mm',
        '0.5 mm mechanical pencil for precise writing and drawing.',
        'Pentonic',
        35.00, 32.00, TRUE
    ),
    (
        'GEO-MECHANICAL-002',
        'Faber-Castell Mechanical Pencil',
        'faber-castell-mechanical-pencil',
        'Mechanical pencil suitable for technical drawing and academic work.',
        'Faber-Castell',
        75.00, 69.00, TRUE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'mechanical-pencil'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- COMPLETE GEOMETRY BOX
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
        'GEO-BOX-001',
        'Camlin Scholar Geometry Box',
        'camlin-scholar-geometry-box',
        'Complete student geometry set containing essential mathematical instruments.',
        'Camlin',
        125.00, 110.00, TRUE
    ),
    (
        'GEO-BOX-002',
        'Classmate Geometry Box',
        'classmate-geometry-box',
        'Complete geometry set for school and college mathematics.',
        'Classmate',
        110.00, 99.00, TRUE
    ),
    (
        'GEO-BOX-003',
        'Faber-Castell Geometry Box',
        'faber-castell-geometry-box',
        'Premium geometry instrument set for students and technical drawing.',
        'Faber-Castell',
        199.00, 179.00, TRUE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'complete-geometry-box'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- INVENTORY
-- ============================================================

INSERT INTO inventory (product_id, quantity)
SELECT
    p.id,
    25
FROM products p
WHERE p.sku LIKE 'GEO-%'
AND NOT EXISTS (
    SELECT 1
    FROM inventory i
    WHERE i.product_id = p.id
);

COMMIT;