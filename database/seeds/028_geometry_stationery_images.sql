-- ============================================================
-- STUDENT MARKETPLACE
-- GEOMETRY & STATIONERY PRODUCT IMAGES
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
    -- COMPASS
    -- ========================================================

    (
        'GEO-COMPASS-001',
        'https://placehold.co/800x600/png?text=Camlin+Exam+Compass',
        'Camlin Exam Compass'
    ),
    (
        'GEO-COMPASS-002',
        'https://placehold.co/800x600/png?text=Faber-Castell+Compass',
        'Faber-Castell Compass'
    ),

    -- ========================================================
    -- COMPLETE GEOMETRY BOX
    -- ========================================================

    (
        'GEO-BOX-001',
        'https://placehold.co/800x600/png?text=Camlin+Scholar+Geometry+Box',
        'Camlin Scholar Geometry Box'
    ),
    (
        'GEO-BOX-002',
        'https://placehold.co/800x600/png?text=Classmate+Geometry+Box',
        'Classmate Geometry Box'
    ),
    (
        'GEO-BOX-003',
        'https://placehold.co/800x600/png?text=Faber-Castell+Geometry+Box',
        'Faber-Castell Geometry Box'
    ),

    -- ========================================================
    -- DIVIDER
    -- ========================================================

    (
        'GEO-DIVIDER-001',
        'https://placehold.co/800x600/png?text=Camlin+Mathematical+Divider',
        'Camlin Mathematical Divider'
    ),

    -- ========================================================
    -- ERASER
    -- ========================================================

    (
        'GEO-ERASER-001',
        'https://placehold.co/800x600/png?text=Apsara+Non+Dust+Eraser',
        'Apsara Non Dust Eraser'
    ),
    (
        'GEO-ERASER-002',
        'https://placehold.co/800x600/png?text=Nataraj+Eraser',
        'Nataraj Eraser'
    ),

    -- ========================================================
    -- MECHANICAL PENCIL
    -- ========================================================

    (
        'GEO-MECHANICAL-001',
        'https://placehold.co/800x600/png?text=Pentonic+Mechanical+Pencil',
        'Pentonic Mechanical Pencil 0.5 mm'
    ),
    (
        'GEO-MECHANICAL-002',
        'https://placehold.co/800x600/png?text=Faber-Castell+Mechanical+Pencil',
        'Faber-Castell Mechanical Pencil'
    ),

    -- ========================================================
    -- PENCIL
    -- ========================================================

    (
        'GEO-PENCIL-001',
        'https://placehold.co/800x600/png?text=Apsara+Platinum+Pencil',
        'Apsara Platinum Extra Dark Pencil'
    ),
    (
        'GEO-PENCIL-002',
        'https://placehold.co/800x600/png?text=Nataraj+HB+Pencil',
        'Nataraj HB Pencil'
    ),

    -- ========================================================
    -- PROTRACTOR
    -- ========================================================

    (
        'GEO-PROTRACTOR-001',
        'https://placehold.co/800x600/png?text=Camlin+Protractor',
        'Camlin 180 Degree Protractor'
    ),
    (
        'GEO-PROTRACTOR-002',
        'https://placehold.co/800x600/png?text=Classmate+Protractor',
        'Classmate Geometry Protractor'
    ),

    -- ========================================================
    -- SCALE / RULER
    -- ========================================================

    (
        'GEO-SCALE-001',
        'https://placehold.co/800x600/png?text=Camlin+Plastic+Ruler',
        'Camlin Plastic Ruler 15 cm'
    ),
    (
        'GEO-SCALE-002',
        'https://placehold.co/800x600/png?text=Classmate+Scale',
        'Classmate Scale 30 cm'
    ),

    -- ========================================================
    -- SET SQUARES
    -- ========================================================

    (
        'GEO-SQUARE-001',
        'https://placehold.co/800x600/png?text=Camlin+Set+Squares',
        'Camlin Set Squares 45 Degree and 60 Degree'
    ),
    (
        'GEO-SQUARE-002',
        'https://placehold.co/800x600/png?text=Faber-Castell+Set+Square',
        'Faber-Castell Set Square'
    ),

    -- ========================================================
    -- SHARPENER
    -- ========================================================

    (
        'GEO-SHARP-001',
        'https://placehold.co/800x600/png?text=Apsara+Sharpener',
        'Apsara Long Point Sharpener'
    ),
    (
        'GEO-SHARP-002',
        'https://placehold.co/800x600/png?text=Nataraj+Sharpener',
        'Nataraj Pencil Sharpener'
    )

) AS v(sku, image_url, alt_text)
ON p.sku = v.sku
WHERE NOT EXISTS (
    SELECT 1
    FROM product_images pi
    WHERE pi.product_id = p.id
);

COMMIT;