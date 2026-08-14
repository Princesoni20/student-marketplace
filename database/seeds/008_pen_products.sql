-- ============================================================
-- STUDENT MARKETPLACE
-- PEN PRODUCTS
-- ============================================================

BEGIN;

-- ============================================================
-- BALL PENS
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
        'PEN-BALL-001',
        'Reynolds Trimax Ball Pen',
        'reynolds-trimax-ball-pen',
        'Smooth-writing ball pen suitable for daily college and school notes.',
        'Reynolds',
        50.00, 45.00, TRUE
    ),
    (
        'PEN-BALL-002',
        'Cello Butterflow Simply Ball Pen',
        'cello-butterflow-simply-ball-pen',
        'Smooth ball pen designed for comfortable everyday writing.',
        'Cello',
        30.00, 27.00, TRUE
    ),
    (
        'PEN-BALL-003',
        'Classmate Octane Ball Pen',
        'classmate-octane-ball-pen',
        'Everyday ball pen suitable for students and note taking.',
        'Classmate',
        20.00, 18.00, TRUE
    ),
    (
        'PEN-BALL-004',
        'Flair Writo-meter Ball Pen',
        'flair-writo-meter-ball-pen',
        'Smooth everyday writing pen for school and college use.',
        'Flair',
        25.00, 22.00, FALSE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'ball-pens'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- GEL PENS
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
        'PEN-GEL-001',
        'Pentonic Gel Pen',
        'pentonic-gel-pen',
        'Smooth gel pen suitable for notes, assignments and exams.',
        'Pentonic',
        30.00, 27.00, TRUE
    ),
    (
        'PEN-GEL-002',
        'Hauser XO Gel Pen',
        'hauser-xo-gel-pen',
        'Comfortable gel pen for smooth everyday writing.',
        'Hauser',
        25.00, 22.00, TRUE
    ),
    (
        'PEN-GEL-003',
        'Classmate Octane Gel Pen',
        'classmate-octane-gel-pen',
        'Smooth gel writing pen for students.',
        'Classmate',
        25.00, 22.00, TRUE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'gel-pens'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- FOUNTAIN PENS
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
        'PEN-FOUNTAIN-001',
        'Camlin Trinity Fountain Pen',
        'camlin-trinity-fountain-pen',
        'Fountain pen suitable for handwriting practice and everyday writing.',
        'Camlin',
        65.00, 60.00, TRUE
    ),
    (
        'PEN-FOUNTAIN-002',
        'Parker Vector Fountain Pen',
        'parker-vector-fountain-pen',
        'Classic fountain pen suitable for students and professional writing.',
        'Parker',
        450.00, 425.00, TRUE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'fountain-pens'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- MARKER PENS
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
        'PEN-MARKER-001',
        'Camlin Permanent Marker',
        'camlin-permanent-marker',
        'Permanent marker for projects, labels and general student use.',
        'Camlin',
        30.00, 27.00, TRUE
    ),
    (
        'PEN-MARKER-002',
        'Luxor Permanent Marker',
        'luxor-permanent-marker',
        'Permanent marker suitable for projects and labelling.',
        'Luxor',
        35.00, 32.00, TRUE
    ),
    (
        'PEN-MARKER-003',
        'Camlin Whiteboard Marker',
        'camlin-whiteboard-marker',
        'Whiteboard marker for classroom presentations and study boards.',
        'Camlin',
        25.00, 22.00, FALSE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'marker-pens'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- HIGHLIGHTERS
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
        'PEN-HIGH-001',
        'Faber-Castell Textliner Highlighter',
        'faber-castell-textliner-highlighter',
        'Bright highlighter for study notes, revision and textbooks.',
        'Faber-Castell',
        45.00, 40.00, TRUE
    ),
    (
        'PEN-HIGH-002',
        'Camlin Markline Highlighter',
        'camlin-markline-highlighter',
        'Highlighter for marking important study material.',
        'Camlin',
        35.00, 32.00, TRUE
    ),
    (
        'PEN-HIGH-003',
        'Classmate Highlighter',
        'classmate-highlighter',
        'Student-friendly highlighter for notes and revision.',
        'Classmate',
        30.00, 27.00, FALSE
    )
) AS v(sku, name, slug, description, brand, price, discount_price, is_featured)
WHERE c.slug = 'highlighters'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- INVENTORY
-- ============================================================

INSERT INTO inventory (product_id, quantity)
SELECT
    p.id,
    25
FROM products p
WHERE p.sku LIKE 'PEN-%'
AND NOT EXISTS (
    SELECT 1
    FROM inventory i
    WHERE i.product_id = p.id
);


COMMIT;