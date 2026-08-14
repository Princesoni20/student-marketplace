-- ============================================================
-- STUDENT MARKETPLACE
-- VERIFIED BOOK COVER IMAGES
-- Existing + verified NCERT mappings only
-- ============================================================

BEGIN;

-- ============================================================
-- CLASS 10 NCERT — VERIFIED ISBNs
-- ============================================================

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
        'NCERT10-ENG-001',
        'https://covers.openlibrary.org/b/isbn/9788174506580-L.jpg?default=false',
        'NCERT Class 10 First Flight English'
    ),
    (
        'NCERT10-ENG-002',
        'https://covers.openlibrary.org/b/isbn/9788174507099-L.jpg?default=false',
        'NCERT Class 10 Footprints Without Feet'
    ),
    (
        'NCERT10-SST-001',
        'https://covers.openlibrary.org/b/isbn/8174507078-L.jpg?default=false',
        'NCERT Class 10 India and the Contemporary World II'
    ),
    (
        'NCERT10-SST-002',
        'https://covers.openlibrary.org/b/isbn/8174506446-L.jpg?default=false',
        'NCERT Class 10 Contemporary India II'
    ),
    (
        'NCERT10-SST-003',
        'https://covers.openlibrary.org/b/isbn/8174507116-L.jpg?default=false',
        'NCERT Class 10 Democratic Politics II'
    ),
    (
        'NCERT10-SST-004',
        'https://covers.openlibrary.org/b/isbn/8174506551-L.jpg?default=false',
        'NCERT Class 10 Understanding Economic Development'
    )
) AS v(sku, image_url, alt_text)
ON p.sku = v.sku
WHERE NOT EXISTS (
    SELECT 1
    FROM product_images pi
    WHERE pi.product_id = p.id
);


-- ============================================================
-- CLASS 12 NCERT — VERIFIED PHYSICS ISBNs
-- ============================================================

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
        'NCERT12-PHY-001',
        'https://covers.openlibrary.org/b/isbn/8174506314-L.jpg?default=false',
        'NCERT Class 12 Physics Part I'
    ),
    (
        'NCERT12-PHY-002',
        'https://covers.openlibrary.org/b/isbn/8174506713-L.jpg?default=false',
        'NCERT Class 12 Physics Part II'
    )
) AS v(sku, image_url, alt_text)
ON p.sku = v.sku
WHERE NOT EXISTS (
    SELECT 1
    FROM product_images pi
    WHERE pi.product_id = p.id
);

COMMIT;
-- ============================================================
-- REMAINING NCERT CLASS 9–12 PRODUCT IMAGES
-- Temporary readable covers for products without verified ISBN
-- Existing images are NOT modified
-- ============================================================

BEGIN;

INSERT INTO product_images
    (product_id, image_url, alt_text, sort_order, is_primary)
SELECT
    p.id,
    'https://placehold.co/600x900/png?text=' ||
    replace(replace(replace(p.name, ' ', '+'), '&', 'and'), '/', '-'),
    p.name,
    0,
    TRUE
FROM products p
JOIN categories c ON c.id = p.category_id
LEFT JOIN product_images pi ON pi.product_id = p.id
WHERE c.slug IN (
    'class-9-ncert',
    'class-10-ncert',
    'class-11-ncert',
    'class-12-ncert'
)
AND pi.id IS NULL;

COMMIT;