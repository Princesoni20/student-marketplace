-- ============================================================
-- STUDENT MARKETPLACE
-- LAB EQUIPMENT PRODUCT IMAGES
-- Biology + Chemistry + Physics
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
    ('LAB-BIO-007',
     'https://placehold.co/800x600/png?text=Biology+Dissection+Tray',
     'Biology Dissection Tray'),

    ('LAB-BIO-005',
     'https://placehold.co/800x600/png?text=Biology+Dropper+Set',
     'Biology Laboratory Dropper Set'),

    ('LAB-BIO-006',
     'https://placehold.co/800x600/png?text=Biology+Forceps',
     'Biology Laboratory Forceps'),

    ('LAB-BIO-001',
     'https://placehold.co/800x600/png?text=Biology+Microscope',
     'Biology Laboratory Microscope'),

    ('LAB-BIO-003',
     'https://placehold.co/800x600/png?text=Biology+Petri+Dish+Set',
     'Biology Laboratory Petri Dish Set'),

    ('LAB-BIO-008',
     'https://placehold.co/800x600/png?text=Biology+Specimen+Jars',
     'Biology Laboratory Specimen Jars'),

    ('LAB-BIO-004',
     'https://placehold.co/800x600/png?text=Biology+Test+Tube+Set',
     'Biology Laboratory Test Tube Set'),

    ('LAB-BIO-002',
     'https://placehold.co/800x600/png?text=Biology+Microscope+Slides',
     'Biology Prepared Microscope Slides Set'),

    ('LAB-CHEM-001',
     'https://placehold.co/800x600/png?text=Chemistry+Beaker+Set',
     'Chemistry Laboratory Beaker Set'),

    ('LAB-CHEM-004',
     'https://placehold.co/800x600/png?text=Chemistry+Conical+Flask',
     'Chemistry Laboratory Conical Flask'),

    ('LAB-CHEM-005',
     'https://placehold.co/800x600/png?text=Chemistry+Funnel+Set',
     'Chemistry Laboratory Funnel Set'),

    ('LAB-CHEM-007',
     'https://placehold.co/800x600/png?text=Chemistry+Glass+Rod+Set',
     'Chemistry Laboratory Glass Rod Set'),

    ('LAB-CHEM-003',
     'https://placehold.co/800x600/png?text=Chemistry+Measuring+Cylinder',
     'Chemistry Laboratory Measuring Cylinder'),

    ('LAB-CHEM-008',
     'https://placehold.co/800x600/png?text=Test+Tube+Holder',
     'Chemistry Laboratory Test Tube Holder'),

    ('LAB-CHEM-002',
     'https://placehold.co/800x600/png?text=Chemistry+Test+Tube+Set',
     'Chemistry Laboratory Test Tube Set'),

    ('LAB-CHEM-006',
     'https://placehold.co/800x600/png?text=Chemistry+Tripod+Stand',
     'Chemistry Laboratory Tripod Stand'),

    ('LAB-PHY-004',
     'https://placehold.co/800x600/png?text=Physics+Ammeter',
     'Physics Laboratory Ammeter'),

    ('LAB-PHY-007',
     'https://placehold.co/800x600/png?text=Physics+Convex+Lens+Set',
     'Physics Laboratory Convex Lens Set'),

    ('LAB-PHY-008',
     'https://placehold.co/800x600/png?text=Physics+Magnet+Set',
     'Physics Laboratory Magnet Set'),

    ('LAB-PHY-001',
     'https://placehold.co/800x600/png?text=Physics+Measuring+Scale',
     'Physics Laboratory Measuring Scale'),

    ('LAB-PHY-006',
     'https://placehold.co/800x600/png?text=Physics+Multimeter',
     'Physics Laboratory Multimeter'),

    ('LAB-PHY-003',
     'https://placehold.co/800x600/png?text=Physics+Screw+Gauge',
     'Physics Laboratory Screw Gauge'),

    ('LAB-PHY-002',
     'https://placehold.co/800x600/png?text=Physics+Vernier+Caliper',
     'Physics Laboratory Vernier Caliper'),

    ('LAB-PHY-005',
     'https://placehold.co/800x600/png?text=Physics+Voltmeter',
     'Physics Laboratory Voltmeter')

) AS v(sku, image_url, alt_text)
ON p.sku = v.sku
WHERE NOT EXISTS (
    SELECT 1
    FROM product_images pi
    WHERE pi.product_id = p.id
);

COMMIT;