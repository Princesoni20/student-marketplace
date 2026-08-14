-- ============================================================
-- STUDENT MARKETPLACE
-- BAG PRODUCT IMAGES
-- College + Laptop + Casual + Sleeve + Messenger + Travel
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

    -- ========================================================
    -- CASUAL BACKPACK
    -- ========================================================

    ('CBAG-CASUAL-003',
     'https://placehold.co/800x600/png?text=Aristocrat+Casual+Backpack',
     'Aristocrat Casual Backpack'),

    ('CBAG-CASUAL-004',
     'https://placehold.co/800x600/png?text=F+Gear+Casual+Backpack',
     'F Gear Casual Backpack'),

    ('CBAG-CASUAL-001',
     'https://placehold.co/800x600/png?text=Skybags+Casual+Backpack',
     'Skybags Casual Backpack'),

    ('CBAG-CASUAL-002',
     'https://placehold.co/800x600/png?text=Wildcraft+Casual+Backpack',
     'Wildcraft Casual Backpack'),

    -- ========================================================
    -- COLLEGE BACKPACK
    -- ========================================================

    ('CBAG-BP-005',
     'https://placehold.co/800x600/png?text=American+Tourister+Casual+Backpack',
     'American Tourister Casual Backpack'),

    ('CBAG-BP-001',
     'https://placehold.co/800x600/png?text=American+Tourister+College+Backpack',
     'American Tourister College Backpack'),

    ('CBAG-BP-004',
     'https://placehold.co/800x600/png?text=Aristocrat+College+Backpack',
     'Aristocrat College Backpack'),

    ('CBAG-BP-002',
     'https://placehold.co/800x600/png?text=Skybags+College+Backpack',
     'Skybags College Backpack'),

    ('CBAG-BP-003',
     'https://placehold.co/800x600/png?text=Wildcraft+College+Backpack',
     'Wildcraft College Backpack'),

    -- ========================================================
    -- LAPTOP BACKPACK
    -- ========================================================

    ('LBAG-BP-001',
     'https://placehold.co/800x600/png?text=American+Tourister+Laptop+Backpack',
     'American Tourister Laptop Backpack'),

    ('LBAG-BP-004',
     'https://placehold.co/800x600/png?text=Aristocrat+Laptop+Backpack',
     'Aristocrat Laptop Backpack'),

    ('LBAG-BP-005',
     'https://placehold.co/800x600/png?text=Lenovo+Laptop+Backpack',
     'Lenovo Laptop Backpack'),

    ('LBAG-BP-002',
     'https://placehold.co/800x600/png?text=Skybags+Laptop+Backpack',
     'Skybags Casual Laptop Backpack'),

    ('LBAG-BP-003',
     'https://placehold.co/800x600/png?text=Wildcraft+Laptop+Backpack',
     'Wildcraft Laptop Backpack'),

    -- ========================================================
    -- LAPTOP MESSENGER BAG
    -- ========================================================

    ('LBAG-MSG-001',
     'https://placehold.co/800x600/png?text=American+Tourister+Messenger+Bag',
     'American Tourister Laptop Messenger Bag'),

    ('LBAG-MSG-002',
     'https://placehold.co/800x600/png?text=Aristocrat+Messenger+Bag',
     'Aristocrat Laptop Messenger Bag'),

    ('LBAG-MSG-003',
     'https://placehold.co/800x600/png?text=Targus+Messenger+Bag',
     'Targus Laptop Messenger Bag'),

    -- ========================================================
    -- LAPTOP SLEEVE
    -- ========================================================

    ('LBAG-SLEEVE-001',
     'https://placehold.co/800x600/png?text=AmazonBasics+Laptop+Sleeve',
     'AmazonBasics Laptop Sleeve'),

    ('LBAG-SLEEVE-003',
     'https://placehold.co/800x600/png?text=Dell+Laptop+Sleeve',
     'Dell Laptop Sleeve'),

    ('LBAG-SLEEVE-002',
     'https://placehold.co/800x600/png?text=HP+Laptop+Sleeve',
     'HP Laptop Sleeve'),

    ('LBAG-SLEEVE-004',
     'https://placehold.co/800x600/png?text=Targus+Laptop+Sleeve',
     'Targus Laptop Sleeve'),

    -- ========================================================
    -- TRAVEL / COLLEGE BACKPACK
    -- ========================================================

    ('CBAG-TRAVEL-002',
     'https://placehold.co/800x600/png?text=American+Tourister+Travel+Backpack',
     'American Tourister Travel Backpack'),

    ('CBAG-TRAVEL-003',
     'https://placehold.co/800x600/png?text=Skybags+Travel+Backpack',
     'Skybags Travel Backpack'),

    ('CBAG-TRAVEL-001',
     'https://placehold.co/800x600/png?text=Wildcraft+Travel+College+Backpack',
     'Wildcraft Travel College Backpack')

) AS v(sku, image_url, alt_text)
ON p.sku = v.sku
WHERE NOT EXISTS (
    SELECT 1
    FROM product_images pi
    WHERE pi.product_id = p.id
);

COMMIT;