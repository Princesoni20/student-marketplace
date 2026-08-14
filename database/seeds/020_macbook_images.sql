-- ============================================================
-- STUDENT MARKETPLACE
-- MACBOOK PRODUCT IMAGES
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
        'MAC-AIR-001',
        'https://placehold.co/800x600/png?text=MacBook+Air+13-inch',
        'Apple MacBook Air 13-inch'
    ),
    (
        'MAC-AIR-002',
        'https://placehold.co/800x600/png?text=MacBook+Air+15-inch',
        'Apple MacBook Air 15-inch'
    ),
    (
        'MAC-PRO-001',
        'https://placehold.co/800x600/png?text=MacBook+Pro+14-inch',
        'Apple MacBook Pro 14-inch'
    ),
    (
        'MAC-PRO-002',
        'https://placehold.co/800x600/png?text=MacBook+Pro+16-inch',
        'Apple MacBook Pro 16-inch'
    )
) AS v(sku, image_url, alt_text)
ON p.sku = v.sku
WHERE NOT EXISTS (
    SELECT 1
    FROM product_images pi
    WHERE pi.product_id = p.id
);

COMMIT;