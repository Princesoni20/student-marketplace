-- ============================================================
-- STUDENT MARKETPLACE
-- NOTEBOOK PRODUCT IMAGES
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

    -- CLASS NOTEBOOKS

    ('NOTE-CLASS-002',
     'https://placehold.co/800x600/png?text=Classmate+Pulse+Long+Notebook',
     'Classmate Pulse Long Notebook'),

    ('NOTE-CLASS-001',
     'https://placehold.co/800x600/png?text=Classmate+Pulse+Single+Line',
     'Classmate Pulse Single Line Notebook'),

    ('NOTE-CLASS-003',
     'https://placehold.co/800x600/png?text=Navneet+Youva+Classmate+Notebook',
     'Navneet Youva Classmate Notebook'),

    ('NOTE-CLASS-004',
     'https://placehold.co/800x600/png?text=Paperkraft+Class+Notebook',
     'Paperkraft Class Notebook'),

    -- LONG NOTEBOOKS

    ('NOTE-LONG-001',
     'https://placehold.co/800x600/png?text=Classmate+Long+Notebook',
     'Classmate Long Notebook'),

    ('NOTE-LONG-002',
     'https://placehold.co/800x600/png?text=Navneet+Youva+Long+Notebook',
     'Navneet Youva Long Notebook'),

    ('NOTE-LONG-003',
     'https://placehold.co/800x600/png?text=Paperkraft+Long+Notebook',
     'Paperkraft Long Notebook'),

    -- PRACTICAL NOTEBOOKS

    ('NOTE-PRACTICAL-001',
     'https://placehold.co/800x600/png?text=Classmate+Practical+Notebook',
     'Classmate Practical Notebook'),

    ('NOTE-PRACTICAL-003',
     'https://placehold.co/800x600/png?text=Lab+Record+Notebook',
     'Lab Record Notebook'),

    ('NOTE-PRACTICAL-002',
     'https://placehold.co/800x600/png?text=Navneet+Practical+Record+Book',
     'Navneet Practical Record Book'),

    -- ROUGH NOTEBOOKS

    ('NOTE-ROUGH-001',
     'https://placehold.co/800x600/png?text=Classmate+Rough+Notebook',
     'Classmate Rough Notebook'),

    ('NOTE-ROUGH-002',
     'https://placehold.co/800x600/png?text=Navneet+Youva+Rough+Notebook',
     'Navneet Youva Rough Notebook'),

    ('NOTE-ROUGH-003',
     'https://placehold.co/800x600/png?text=Paperkraft+Rough+Notebook',
     'Paperkraft Rough Notebook'),

    -- SPIRAL NOTEBOOKS

    ('NOTE-SPIRAL-001',
     'https://placehold.co/800x600/png?text=Classmate+Pulse+Spiral+Notebook',
     'Classmate Pulse Spiral Notebook'),

    ('NOTE-SPIRAL-003',
     'https://placehold.co/800x600/png?text=Navneet+Youva+Spiral+Notebook',
     'Navneet Youva Spiral Notebook'),

    ('NOTE-SPIRAL-002',
     'https://placehold.co/800x600/png?text=Paperkraft+Spiral+Notebook',
     'Paperkraft Spiral Notebook')

) AS v(sku, image_url, alt_text)
ON p.sku = v.sku
WHERE NOT EXISTS (
    SELECT 1
    FROM product_images pi
    WHERE pi.product_id = p.id
);

COMMIT;