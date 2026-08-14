-- ============================================================
-- STUDENT MARKETPLACE
-- NEET BIOLOGY BOOK PRODUCT IMAGES
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
        'BOOK-NEET-BIO-001',
        'https://placehold.co/800x600/png?text=NCERT+Biology+Class+11',
        'NCERT Biology Class 11'
    ),
    (
        'BOOK-NEET-BIO-002',
        'https://placehold.co/800x600/png?text=NCERT+Biology+Class+12',
        'NCERT Biology Class 12'
    )
) AS v(sku, image_url, alt_text)
ON p.sku = v.sku
WHERE NOT EXISTS (
    SELECT 1
    FROM product_images pi
    WHERE pi.product_id = p.id
);

COMMIT;