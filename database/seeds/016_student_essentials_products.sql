-- ============================================================
-- STUDENT MARKETPLACE
-- STUDENT ESSENTIALS PRODUCTS
-- ============================================================

BEGIN;

-- ============================================================
-- HEADPHONES
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('ESS-HEAD-001', 'boAt Rockerz Wireless Headphones',
     'boat-rockerz-wireless-headphones',
     'Wireless headphones suitable for online classes, music and everyday student use.',
     'boAt', 1499.00, 1299.00, TRUE),
    ('ESS-HEAD-002', 'JBL Tune Wireless Headphones',
     'jbl-tune-wireless-headphones',
     'Wireless headphones for online learning, entertainment and daily college use.',
     'JBL', 2999.00, 2699.00, TRUE),
    ('ESS-HEAD-003', 'Sony Wireless Headphones',
     'sony-wireless-headphones',
     'Comfortable wireless headphones suitable for study and multimedia use.',
     'Sony', 4499.00, 4099.00, TRUE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'headphones'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- EARPHONES
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('ESS-EAR-001', 'boAt Bassheads Wired Earphones',
     'boat-bassheads-wired-earphones',
     'Affordable wired earphones for online classes, calls and everyday use.',
     'boAt', 499.00, 399.00, TRUE),
    ('ESS-EAR-002', 'JBL C100SI Wired Earphones',
     'jbl-c100si-wired-earphones',
     'Wired earphones suitable for study, calls and multimedia.',
     'JBL', 699.00, 599.00, TRUE),
    ('ESS-EAR-003', 'Sony Wired Earphones',
     'sony-wired-earphones',
     'Compact wired earphones for students and everyday listening.',
     'Sony', 899.00, 799.00, FALSE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'earphones'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- TWS EARBUDS
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('ESS-TWS-001', 'boAt Airdopes TWS Earbuds',
     'boat-airdopes-tws-earbuds',
     'True wireless earbuds for online classes, calls and entertainment.',
     'boAt', 1299.00, 1099.00, TRUE),
    ('ESS-TWS-002', 'Realme Buds TWS Earbuds',
     'realme-buds-tws-earbuds',
     'Compact wireless earbuds for students and everyday use.',
     'Realme', 1499.00, 1299.00, TRUE),
    ('ESS-TWS-003', 'JBL Wave TWS Earbuds',
     'jbl-wave-tws-earbuds',
     'Wireless earbuds suitable for study, calls and entertainment.',
     'JBL', 2999.00, 2699.00, TRUE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'tws-earbuds'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- USB DRIVE
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('ESS-USB-001', 'SanDisk Cruzer Blade 32GB',
     'sandisk-cruzer-blade-32gb',
     'Compact USB drive for storing assignments, projects and study files.',
     'SanDisk', 499.00, 429.00, TRUE),
    ('ESS-USB-002', 'SanDisk Ultra Flair 64GB',
     'sandisk-ultra-flair-64gb',
     'Fast USB storage for college projects, documents and media.',
     'SanDisk', 699.00, 599.00, TRUE),
    ('ESS-USB-003', 'Kingston DataTraveler 64GB',
     'kingston-datatraveler-64gb',
     'Portable USB storage for students and everyday file transfer.',
     'Kingston', 649.00, 549.00, FALSE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'usb-drive'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- EXTERNAL STORAGE
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('ESS-STORE-001', 'Seagate 1TB External Hard Drive',
     'seagate-1tb-external-hard-drive',
     'Portable external storage for backups, projects and study files.',
     'Seagate', 5499.00, 4999.00, TRUE),
    ('ESS-STORE-002', 'WD 1TB External Hard Drive',
     'wd-1tb-external-hard-drive',
     'Reliable portable storage for students and personal backups.',
     'WD', 5699.00, 5199.00, TRUE),
    ('ESS-STORE-003', 'Samsung Portable SSD 1TB',
     'samsung-portable-ssd-1tb',
     'Fast portable SSD for development projects, backups and large files.',
     'Samsung', 8999.00, 8199.00, TRUE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'external-storage'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- LAPTOP STAND
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('ESS-STAND-001', 'Portronics My Buddy Laptop Stand',
     'portronics-my-buddy-laptop-stand',
     'Adjustable laptop stand suitable for study, coding and desk work.',
     'Portronics', 999.00, 849.00, TRUE),
    ('ESS-STAND-002', 'Tukzer Adjustable Laptop Stand',
     'tukzer-adjustable-laptop-stand',
     'Portable adjustable stand for comfortable laptop use.',
     'Tukzer', 799.00, 699.00, TRUE),
    ('ESS-STAND-003', 'AmazonBasics Laptop Stand',
     'amazonbasics-laptop-stand',
     'Simple laptop stand for students and home study setups.',
     'AmazonBasics', 899.00, 799.00, FALSE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'laptop-stand'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- MOUSE
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('ESS-MOUSE-001', 'Logitech M90 Wired Mouse',
     'logitech-m90-wired-mouse',
     'Reliable wired mouse for laptops, desktops and student work.',
     'Logitech', 399.00, 349.00, TRUE),
    ('ESS-MOUSE-002', 'HP Wireless Mouse',
     'hp-wireless-mouse',
     'Wireless mouse suitable for laptops, coding and daily productivity.',
     'HP', 699.00, 599.00, TRUE),
    ('ESS-MOUSE-003', 'Logitech M331 Wireless Mouse',
     'logitech-m331-wireless-mouse',
     'Quiet wireless mouse suitable for study and office environments.',
     'Logitech', 1499.00, 1299.00, TRUE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'mouse'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- KEYBOARD
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('ESS-KEY-001', 'Logitech K120 Wired Keyboard',
     'logitech-k120-wired-keyboard',
     'Full-size wired keyboard for coding, assignments and everyday computer use.',
     'Logitech', 699.00, 599.00, TRUE),
    ('ESS-KEY-002', 'HP Wired Keyboard',
     'hp-wired-keyboard',
     'Comfortable keyboard for students and desktop productivity.',
     'HP', 799.00, 699.00, TRUE),
    ('ESS-KEY-003', 'Logitech Wireless Keyboard',
     'logitech-wireless-keyboard',
     'Wireless keyboard for clean and comfortable study desk setups.',
     'Logitech', 1299.00, 1149.00, TRUE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'keyboard'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- CALCULATOR
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('ESS-CALC-001', 'Casio fx-82MS Scientific Calculator',
     'casio-fx-82ms-scientific-calculator',
     'Scientific calculator suitable for engineering and academic calculations.',
     'Casio', 799.00, 699.00, TRUE),
    ('ESS-CALC-002', 'Casio fx-991ES Plus',
     'casio-fx-991es-plus',
     'Advanced scientific calculator for engineering and higher education.',
     'Casio', 1399.00, 1249.00, TRUE),
    ('ESS-CALC-003', 'Casio fx-991CW',
     'casio-fx-991cw',
     'Modern scientific calculator suitable for engineering students.',
     'Casio', 1799.00, 1599.00, TRUE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'calculator'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- DESK ORGANIZER
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('ESS-DESK-001', 'Cello Desk Organizer',
     'cello-desk-organizer',
     'Desk organizer for pens, stationery and study accessories.',
     'Cello', 299.00, 269.00, TRUE),
    ('ESS-DESK-002', 'Kangaro Desk Organizer',
     'kangaro-desk-organizer',
     'Compact organizer for maintaining a clean student study desk.',
     'Kangaro', 349.00, 319.00, TRUE),
    ('ESS-DESK-003', 'Desk Organizer Multi Compartment',
     'desk-organizer-multi-compartment',
     'Multi-compartment organizer for stationery and small study items.',
     'Solo', 399.00, 359.00, FALSE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'desk-organizer'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- STUDY LAMP
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('ESS-LAMP-001', 'Wipro Garnet LED Study Lamp',
     'wipro-garnet-led-study-lamp',
     'LED study lamp suitable for reading, revision and desk work.',
     'Wipro', 899.00, 799.00, TRUE),
    ('ESS-LAMP-002', 'Philips LED Study Lamp',
     'philips-led-study-lamp',
     'LED desk lamp designed for study and reading.',
     'Philips', 999.00, 899.00, TRUE),
    ('ESS-LAMP-003', 'Portronics LED Study Lamp',
     'portronics-led-study-lamp',
     'Compact LED lamp for student study desks and reading.',
     'Portronics', 799.00, 699.00, TRUE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'study-lamp'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- INVENTORY
-- ============================================================

INSERT INTO inventory (product_id, quantity)
SELECT
    p.id,
    20
FROM products p
WHERE p.sku LIKE 'ESS-%'
AND NOT EXISTS (
    SELECT 1
    FROM inventory i
    WHERE i.product_id = p.id
);

COMMIT;