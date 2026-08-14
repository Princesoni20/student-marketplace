-- ============================================================
-- STUDENT MARKETPLACE
-- WATER BOTTLE PRODUCT IMAGES
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
        'BOTTLE-003',
        'https://placehold.co/800x600/png?text=Borosil+Hydra+Stainless+Steel+Bottle',
        'Borosil Hydra Stainless Steel Bottle'
    ),
    (
        'BOTTLE-004',
        'https://placehold.co/800x600/png?text=Cello+H2O+Unbreakable+Bottle',
        'Cello H2O Unbreakable Bottle'
    ),
    (
        'BOTTLE-002',
        'https://placehold.co/800x600/png?text=Milton+Kool+Rider+Water+Bottle',
        'Milton Kool Rider Water Bottle'
    ),
    (
        'BOTTLE-001',
        'https://placehold.co/800x600/png?text=Milton+Thermosteel+Flask',
        'Milton Thermosteel Flask'
    ),
    (
        'BOTTLE-007',
        'https://placehold.co/800x600/png?text=Nayasa+BPA+Free+Water+Bottle',
        'Nayasa BPA Free Water Bottle'
    ),
    (
        'BOTTLE-008',
        'https://placehold.co/800x600/png?text=Pigeon+Stainless+Steel+Water+Bottle',
        'Pigeon Stainless Steel Water Bottle'
    ),
    (
        'BOTTLE-006',
        'https://placehold.co/800x600/png?text=Signoraware+Stainless+Steel+Bottle',
        'Signoraware Stainless Steel Bottle'
    ),
    (
        'BOTTLE-005',
        'https://placehold.co/800x600/png?text=Tupperware+Eco+Bottle',
        'Tupperware Eco Bottle'
    )
) AS v(sku, image_url, alt_text)
ON p.sku = v.sku
WHERE NOT EXISTS (
    SELECT 1
    FROM product_images pi
    WHERE pi.product_id = p.id
);

COMMIT;