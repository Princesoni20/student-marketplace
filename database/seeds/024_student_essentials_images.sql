-- ============================================================
-- STUDENT MARKETPLACE
-- STUDENT ESSENTIALS PRODUCT IMAGES
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
    -- CALCULATORS
    -- ========================================================

    ('ESS-CALC-001',
     'https://placehold.co/800x600/png?text=Casio+fx-82MS',
     'Casio fx-82MS Scientific Calculator'),

    ('ESS-CALC-003',
     'https://placehold.co/800x600/png?text=Casio+fx-991CW',
     'Casio fx-991CW Calculator'),

    ('ESS-CALC-002',
     'https://placehold.co/800x600/png?text=Casio+fx-991ES+Plus',
     'Casio fx-991ES Plus Calculator'),

    -- ========================================================
    -- DESK ORGANIZERS
    -- ========================================================

    ('ESS-DESK-001',
     'https://placehold.co/800x600/png?text=Cello+Desk+Organizer',
     'Cello Desk Organizer'),

    ('ESS-DESK-003',
     'https://placehold.co/800x600/png?text=Desk+Organizer+Multi+Compartment',
     'Desk Organizer Multi Compartment'),

    ('ESS-DESK-002',
     'https://placehold.co/800x600/png?text=Kangaro+Desk+Organizer',
     'Kangaro Desk Organizer'),

    -- ========================================================
    -- EARPHONES
    -- ========================================================

    ('ESS-EAR-001',
     'https://placehold.co/800x600/png?text=boAt+Bassheads',
     'boAt Bassheads Wired Earphones'),

    ('ESS-EAR-002',
     'https://placehold.co/800x600/png?text=JBL+C100SI',
     'JBL C100SI Wired Earphones'),

    ('ESS-EAR-003',
     'https://placehold.co/800x600/png?text=Sony+Wired+Earphones',
     'Sony Wired Earphones'),

    -- ========================================================
    -- EXTERNAL STORAGE
    -- ========================================================

    ('ESS-STORE-003',
     'https://placehold.co/800x600/png?text=Samsung+Portable+SSD+1TB',
     'Samsung Portable SSD 1TB'),

    ('ESS-STORE-001',
     'https://placehold.co/800x600/png?text=Seagate+1TB+External+Hard+Drive',
     'Seagate 1TB External Hard Drive'),

    ('ESS-STORE-002',
     'https://placehold.co/800x600/png?text=WD+1TB+External+Hard+Drive',
     'WD 1TB External Hard Drive'),

    -- ========================================================
    -- HEADPHONES
    -- ========================================================

    ('ESS-HEAD-001',
     'https://placehold.co/800x600/png?text=boAt+Rockerz+Headphones',
     'boAt Rockerz Wireless Headphones'),

    ('ESS-HEAD-002',
     'https://placehold.co/800x600/png?text=JBL+Tune+Headphones',
     'JBL Tune Wireless Headphones'),

    ('ESS-HEAD-003',
     'https://placehold.co/800x600/png?text=Sony+Wireless+Headphones',
     'Sony Wireless Headphones'),

    -- ========================================================
    -- KEYBOARDS
    -- ========================================================

    ('ESS-KEY-002',
     'https://placehold.co/800x600/png?text=HP+Wired+Keyboard',
     'HP Wired Keyboard'),

    ('ESS-KEY-001',
     'https://placehold.co/800x600/png?text=Logitech+K120',
     'Logitech K120 Wired Keyboard'),

    ('ESS-KEY-003',
     'https://placehold.co/800x600/png?text=Logitech+Wireless+Keyboard',
     'Logitech Wireless Keyboard'),

    -- ========================================================
    -- LAPTOP STANDS
    -- ========================================================

    ('ESS-STAND-003',
     'https://placehold.co/800x600/png?text=AmazonBasics+Laptop+Stand',
     'AmazonBasics Laptop Stand'),

    ('ESS-STAND-001',
     'https://placehold.co/800x600/png?text=Portronics+My+Buddy',
     'Portronics My Buddy Laptop Stand'),

    ('ESS-STAND-002',
     'https://placehold.co/800x600/png?text=Tukzer+Adjustable+Laptop+Stand',
     'Tukzer Adjustable Laptop Stand'),

    -- ========================================================
    -- MOUSE
    -- ========================================================

    ('ESS-MOUSE-002',
     'https://placehold.co/800x600/png?text=HP+Wireless+Mouse',
     'HP Wireless Mouse'),

    ('ESS-MOUSE-003',
     'https://placehold.co/800x600/png?text=Logitech+M331',
     'Logitech M331 Wireless Mouse'),

    ('ESS-MOUSE-001',
     'https://placehold.co/800x600/png?text=Logitech+M90',
     'Logitech M90 Wired Mouse'),

    -- ========================================================
    -- STUDY LAMPS
    -- ========================================================

    ('ESS-LAMP-002',
     'https://placehold.co/800x600/png?text=Philips+LED+Study+Lamp',
     'Philips LED Study Lamp'),

    ('ESS-LAMP-003',
     'https://placehold.co/800x600/png?text=Portronics+LED+Study+Lamp',
     'Portronics LED Study Lamp'),

    ('ESS-LAMP-001',
     'https://placehold.co/800x600/png?text=Wipro+Garnet+LED+Study+Lamp',
     'Wipro Garnet LED Study Lamp'),

    -- ========================================================
    -- TWS EARBUDS
    -- ========================================================

    ('ESS-TWS-001',
     'https://placehold.co/800x600/png?text=boAt+Airdopes',
     'boAt Airdopes TWS Earbuds'),

    ('ESS-TWS-003',
     'https://placehold.co/800x600/png?text=JBL+Wave+TWS',
     'JBL Wave TWS Earbuds'),

    ('ESS-TWS-002',
     'https://placehold.co/800x600/png?text=Realme+Buds+TWS',
     'Realme Buds TWS Earbuds'),

    -- ========================================================
    -- USB DRIVES
    -- ========================================================

    ('ESS-USB-003',
     'https://placehold.co/800x600/png?text=Kingston+DataTraveler+64GB',
     'Kingston DataTraveler 64GB'),

    ('ESS-USB-001',
     'https://placehold.co/800x600/png?text=SanDisk+Cruzer+Blade+32GB',
     'SanDisk Cruzer Blade 32GB'),

    ('ESS-USB-002',
     'https://placehold.co/800x600/png?text=SanDisk+Ultra+Flair+64GB',
     'SanDisk Ultra Flair 64GB')

) AS v(sku, image_url, alt_text)
ON p.sku = v.sku
WHERE NOT EXISTS (
    SELECT 1
    FROM product_images pi
    WHERE pi.product_id = p.id
);

COMMIT;