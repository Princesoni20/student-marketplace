-- ============================================================
-- WINDOWS LAPTOP PRODUCT IMAGES
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
        'LAP-ACER-001',
        'https://placehold.co/800x600/png?text=Acer+Aspire+5',
        'Acer Aspire 5 laptop'
    ),
    (
        'LAP-ACER-002',
        'https://placehold.co/800x600/png?text=Acer+Aspire+Lite',
        'Acer Aspire Lite laptop'
    ),
    (
        'LAP-ASUS-001',
        'https://placehold.co/800x600/png?text=ASUS+Vivobook+15',
        'ASUS Vivobook 15 laptop'
    ),
    (
        'LAP-ASUS-002',
        'https://placehold.co/800x600/png?text=ASUS+Vivobook+S+14',
        'ASUS Vivobook S 14 laptop'
    ),
    (
        'LAP-DELL-002',
        'https://placehold.co/800x600/png?text=Dell+Inspiron+14',
        'Dell Inspiron 14 laptop'
    ),
    (
        'LAP-DELL-001',
        'https://placehold.co/800x600/png?text=Dell+Inspiron+15',
        'Dell Inspiron 15 laptop'
    ),
    (
        'LAP-HP-001',
        'https://placehold.co/800x600/png?text=HP+15s',
        'HP 15s laptop'
    ),
    (
        'LAP-HP-002',
        'https://placehold.co/800x600/png?text=HP+Pavilion+14',
        'HP Pavilion 14 laptop'
    ),
    (
        'LAP-LENOVO-001',
        'https://placehold.co/800x600/png?text=Lenovo+IdeaPad+Slim+3',
        'Lenovo IdeaPad Slim 3 laptop'
    ),
    (
        'LAP-LENOVO-002',
        'https://placehold.co/800x600/png?text=Lenovo+ThinkBook+15',
        'Lenovo ThinkBook 15 laptop'
    ),
    (
        'LAP-SURFACE-001',
        'https://placehold.co/800x600/png?text=Microsoft+Surface+Laptop',
        'Microsoft Surface Laptop'
    ),
    (
        'LAP-MSI-001',
        'https://placehold.co/800x600/png?text=MSI+Modern+14',
        'MSI Modern 14 laptop'
    ),
    (
        'LAP-MSI-002',
        'https://placehold.co/800x600/png?text=MSI+Thin+Gaming+Laptop',
        'MSI Thin Gaming Laptop'
    )
) AS v(sku, image_url, alt_text)
ON p.sku = v.sku
WHERE NOT EXISTS (
    SELECT 1
    FROM product_images pi
    WHERE pi.product_id = p.id
);

COMMIT;