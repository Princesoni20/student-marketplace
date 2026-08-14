-- ============================================================
-- STUDENT MARKETPLACE
-- NEET BOOK PRODUCT IMAGES
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
    (
        'BOOK-NEET-CHE-001',
        'https://placehold.co/800x600/png?text=NCERT+Chemistry+Class+11',
        'NCERT Chemistry Class 11'
    ),
    (
        'BOOK-NEET-CHE-002',
        'https://placehold.co/800x600/png?text=NCERT+Chemistry+Class+12',
        'NCERT Chemistry Class 12'
    ),
    (
        'BOOK-NEET-CHE-003',
        'https://placehold.co/800x600/png?text=Organic+Chemistry',
        'Organic Chemistry'
    ),
    (
        'BOOK-NEET-PHY-001',
        'https://placehold.co/800x600/png?text=NCERT+Physics+Class+11',
        'NCERT Physics Class 11'
    ),
    (
        'BOOK-NEET-PHY-002',
        'https://placehold.co/800x600/png?text=NCERT+Physics+Class+12',
        'NCERT Physics Class 12'
    ),
    (
        'BOOK-NEET-PHY-003',
        'https://placehold.co/800x600/png?text=Concepts+of+Physics',
        'Concepts of Physics'
    )
) AS v(sku, image_url, alt_text)
ON p.sku = v.sku
WHERE NOT EXISTS (
    SELECT 1
    FROM product_images pi
    WHERE pi.product_id = p.id
);

COMMIT;