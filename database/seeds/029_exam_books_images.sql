-- ============================================================
-- STUDENT MARKETPLACE
-- EXAM PREPARATION BOOK PRODUCT IMAGES
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
        'BOOK-JEE-ADV-001',
        'https://placehold.co/800x600/png?text=JEE+Advanced+Previous+Years+Papers',
        'JEE Advanced Previous Years Papers'
    ),
    (
        'BOOK-JEE-MAIN-001',
        'https://placehold.co/800x600/png?text=JEE+Main+Previous+Years+Questions',
        'JEE Main Chapterwise Previous Years Questions'
    ),
    (
        'BOOK-NEET-PYQ-001',
        'https://placehold.co/800x600/png?text=NEET+Previous+Years+Questions',
        'NEET Chapterwise Previous Years Questions'
    ),
    (
        'BOOK-UPSC-CSAT-001',
        'https://placehold.co/800x600/png?text=UPSC+CSAT+Manual',
        'CSAT Paper II Manual'
    ),
    (
        'BOOK-UPSC-CUR-001',
        'https://placehold.co/800x600/png?text=UPSC+Current+Affairs',
        'UPSC Current Affairs and General Studies'
    ),
    (
        'BOOK-UPSC-ENV-001',
        'https://placehold.co/800x600/png?text=UPSC+Environment',
        'Environment for UPSC'
    ),
    (
        'BOOK-UPSC-SCI-001',
        'https://placehold.co/800x600/png?text=UPSC+Science+Technology',
        'Science and Technology for UPSC'
    )

) AS v(sku, image_url, alt_text)
ON p.sku = v.sku
WHERE NOT EXISTS (
    SELECT 1
    FROM product_images pi
    WHERE pi.product_id = p.id
);

COMMIT;