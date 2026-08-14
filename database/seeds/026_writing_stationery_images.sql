-- ============================================================
-- STUDENT MARKETPLACE
-- WRITING STATIONERY PRODUCT IMAGES
-- Ball Pens + Gel Pens + Fountain Pens + Highlighters + Markers
-- ============================================================

BEGIN;

INSERT INTO product_images
    (product_id, image_url, alt_text, sort_order, is_primary)
SELECT
    p.id,
    v.image_url,
    v.alt_text,
    0,
    TRUE
FROM products p
JOIN (
    VALUES

    -- ========================================================
    -- BALL PENS
    -- ========================================================

    ('PEN-BALL-002',
     'https://placehold.co/800x600/png?text=Cello+Butterflow+Simply',
     'Cello Butterflow Simply Ball Pen'),

    ('PEN-BALL-003',
     'https://placehold.co/800x600/png?text=Classmate+Octane+Ball+Pen',
     'Classmate Octane Ball Pen'),

    ('PEN-BALL-004',
     'https://placehold.co/800x600/png?text=Flair+Writo-meter+Ball+Pen',
     'Flair Writo-meter Ball Pen'),

    ('PEN-BALL-001',
     'https://placehold.co/800x600/png?text=Reynolds+Trimax+Ball+Pen',
     'Reynolds Trimax Ball Pen'),

    -- ========================================================
    -- FOUNTAIN PENS
    -- ========================================================

    ('PEN-FOUNTAIN-001',
     'https://placehold.co/800x600/png?text=Camlin+Trinity+Fountain+Pen',
     'Camlin Trinity Fountain Pen'),

    ('PEN-FOUNTAIN-002',
     'https://placehold.co/800x600/png?text=Parker+Vector+Fountain+Pen',
     'Parker Vector Fountain Pen'),

    -- ========================================================
    -- GEL PENS
    -- ========================================================

    ('PEN-GEL-003',
     'https://placehold.co/800x600/png?text=Classmate+Octane+Gel+Pen',
     'Classmate Octane Gel Pen'),

    ('PEN-GEL-002',
     'https://placehold.co/800x600/png?text=Hauser+XO+Gel+Pen',
     'Hauser XO Gel Pen'),

    ('PEN-GEL-001',
     'https://placehold.co/800x600/png?text=Pentonic+Gel+Pen',
     'Pentonic Gel Pen'),

    -- ========================================================
    -- HIGHLIGHTERS
    -- ========================================================

    ('PEN-HIGH-002',
     'https://placehold.co/800x600/png?text=Camlin+Markline+Highlighter',
     'Camlin Markline Highlighter'),

    ('PEN-HIGH-003',
     'https://placehold.co/800x600/png?text=Classmate+Highlighter',
     'Classmate Highlighter'),

    ('PEN-HIGH-001',
     'https://placehold.co/800x600/png?text=Faber-Castell+Textliner',
     'Faber-Castell Textliner Highlighter'),

    -- ========================================================
    -- MARKER PENS
    -- ========================================================

    ('PEN-MARKER-001',
     'https://placehold.co/800x600/png?text=Camlin+Permanent+Marker',
     'Camlin Permanent Marker'),

    ('PEN-MARKER-003',
     'https://placehold.co/800x600/png?text=Camlin+Whiteboard+Marker',
     'Camlin Whiteboard Marker'),

    ('PEN-MARKER-002',
     'https://placehold.co/800x600/png?text=Luxor+Permanent+Marker',
     'Luxor Permanent Marker')

) AS v(sku, image_url, alt_text)
ON p.sku = v.sku
WHERE NOT EXISTS (
    SELECT 1
    FROM product_images pi
    WHERE pi.product_id = p.id
);

COMMIT;