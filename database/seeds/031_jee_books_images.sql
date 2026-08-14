-- ============================================================
-- STUDENT MARKETPLACE
-- JEE BOOK PRODUCT IMAGES
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
        'BOOK-JEE-CHE-001',
        'https://placehold.co/800x600/png?text=NCERT+Chemistry+Class+11',
        'NCERT Chemistry Class 11'
    ),
    (
        'BOOK-JEE-CHE-002',
        'https://placehold.co/800x600/png?text=NCERT+Chemistry+Class+12',
        'NCERT Chemistry Class 12'
    ),
    (
        'BOOK-JEE-CHE-003',
        'https://placehold.co/800x600/png?text=Physical+Chemistry',
        'Physical Chemistry'
    ),
    (
        'BOOK-JEE-MAT-001',
        'https://placehold.co/800x600/png?text=Objective+Mathematics',
        'Objective Mathematics'
    ),
    (
        'BOOK-JEE-MAT-002',
        'https://placehold.co/800x600/png?text=Cengage+Mathematics+for+JEE',
        'Cengage Mathematics for JEE'
    ),
    (
        'BOOK-JEE-PHY-002',
        'https://placehold.co/800x600/png?text=Concepts+of+Physics+Volume+2',
        'Concepts of Physics Volume 2'
    ),
    (
        'BOOK-JEE-PHY-003',
        'https://placehold.co/800x600/png?text=Understanding+Physics+Mechanics',
        'Understanding Physics Mechanics'
    )

) AS v(sku, image_url, alt_text)
ON p.sku = v.sku
WHERE NOT EXISTS (
    SELECT 1
    FROM product_images pi
    WHERE pi.product_id = p.id
);

COMMIT;