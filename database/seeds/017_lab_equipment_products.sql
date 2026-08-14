-- ============================================================
-- STUDENT MARKETPLACE
-- LAB EQUIPMENT PRODUCTS
-- Physics + Biology + Chemistry
-- ============================================================

BEGIN;

-- ============================================================
-- PHYSICS LAB
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT
    c.id, v.sku, v.name, v.slug, v.description, v.brand,
    v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    (
        'LAB-PHY-001',
        'Physics Laboratory Measuring Scale',
        'physics-laboratory-measuring-scale',
        'Measuring scale for school and college physics laboratory experiments.',
        'Student Marketplace',
        120.00, 99.00, TRUE
    ),
    (
        'LAB-PHY-002',
        'Physics Laboratory Vernier Caliper',
        'physics-laboratory-vernier-caliper',
        'Vernier caliper for measuring length, diameter and dimensions in physics experiments.',
        'Student Marketplace',
        450.00, 399.00, TRUE
    ),
    (
        'LAB-PHY-003',
        'Physics Laboratory Screw Gauge',
        'physics-laboratory-screw-gauge',
        'Precision screw gauge for physics laboratory measurements.',
        'Student Marketplace',
        500.00, 449.00, TRUE
    ),
    (
        'LAB-PHY-004',
        'Physics Laboratory Ammeter',
        'physics-laboratory-ammeter',
        'Analog ammeter for basic electrical and physics laboratory experiments.',
        'HTC',
        350.00, 299.00, TRUE
    ),
    (
        'LAB-PHY-005',
        'Physics Laboratory Voltmeter',
        'physics-laboratory-voltmeter',
        'Analog voltmeter for basic electrical measurement experiments.',
        'HTC',
        350.00, 299.00, TRUE
    ),
    (
        'LAB-PHY-006',
        'Physics Laboratory Multimeter',
        'physics-laboratory-multimeter',
        'Digital multimeter for basic electrical measurements and student experiments.',
        'Meco',
        699.00, 599.00, TRUE
    ),
    (
        'LAB-PHY-007',
        'Physics Laboratory Convex Lens Set',
        'physics-laboratory-convex-lens-set',
        'Convex lens set for optics experiments and practical demonstrations.',
        'Student Marketplace',
        300.00, 249.00, FALSE
    ),
    (
        'LAB-PHY-008',
        'Physics Laboratory Magnet Set',
        'physics-laboratory-magnet-set',
        'Magnet set for basic magnetism experiments.',
        'Student Marketplace',
        250.00, 199.00, FALSE
    )
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'physics-lab'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- BIOLOGY LAB
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT
    c.id, v.sku, v.name, v.slug, v.description, v.brand,
    v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    (
        'LAB-BIO-001',
        'Biology Laboratory Microscope',
        'biology-laboratory-microscope',
        'Student microscope for observing biological specimens and slides.',
        'Labcare',
        4500.00, 3999.00, TRUE
    ),
    (
        'LAB-BIO-002',
        'Biology Prepared Microscope Slides Set',
        'biology-prepared-microscope-slides-set',
        'Prepared slides for school and college biology practical observations.',
        'Student Marketplace',
        699.00, 599.00, TRUE
    ),
    (
        'LAB-BIO-003',
        'Biology Laboratory Petri Dish Set',
        'biology-laboratory-petri-dish-set',
        'Petri dishes for educational biology laboratory activities.',
        'Student Marketplace',
        350.00, 299.00, TRUE
    ),
    (
        'LAB-BIO-004',
        'Biology Laboratory Test Tube Set',
        'biology-laboratory-test-tube-set',
        'Test tube set for school and college biology practical work.',
        'Borosil',
        450.00, 399.00, TRUE
    ),
    (
        'LAB-BIO-005',
        'Biology Laboratory Dropper Set',
        'biology-laboratory-dropper-set',
        'Droppers for handling small quantities of liquids during educational experiments.',
        'Borosil',
        180.00, 149.00, FALSE
    ),
    (
        'LAB-BIO-006',
        'Biology Laboratory Forceps',
        'biology-laboratory-forceps',
        'Laboratory forceps for handling specimens and educational practical work.',
        'Student Marketplace',
        180.00, 149.00, FALSE
    ),
    (
        'LAB-BIO-007',
        'Biology Dissection Tray',
        'biology-dissection-tray',
        'Educational dissection tray for supervised biology practical sessions.',
        'Student Marketplace',
        350.00, 299.00, TRUE
    ),
    (
        'LAB-BIO-008',
        'Biology Laboratory Specimen Jars',
        'biology-laboratory-specimen-jars',
        'Specimen jars for educational laboratory storage and observation.',
        'Student Marketplace',
        400.00, 349.00, FALSE
    )
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'biology-lab'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- CHEMISTRY LAB
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT
    c.id, v.sku, v.name, v.slug, v.description, v.brand,
    v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    (
        'LAB-CHEM-001',
        'Chemistry Laboratory Beaker Set',
        'chemistry-laboratory-beaker-set',
        'Laboratory beaker set for supervised chemistry practical experiments.',
        'Borosil',
        699.00, 599.00, TRUE
    ),
    (
        'LAB-CHEM-002',
        'Chemistry Laboratory Test Tube Set',
        'chemistry-laboratory-test-tube-set',
        'Test tubes for school and college chemistry laboratory experiments.',
        'Borosil',
        450.00, 399.00, TRUE
    ),
    (
        'LAB-CHEM-003',
        'Chemistry Laboratory Measuring Cylinder',
        'chemistry-laboratory-measuring-cylinder',
        'Graduated measuring cylinder for measuring liquid volumes.',
        'Borosil',
        350.00, 299.00, TRUE
    ),
    (
        'LAB-CHEM-004',
        'Chemistry Laboratory Conical Flask',
        'chemistry-laboratory-conical-flask',
        'Conical flask for supervised chemistry laboratory experiments.',
        'Borosil',
        300.00, 249.00, TRUE
    ),
    (
        'LAB-CHEM-005',
        'Chemistry Laboratory Funnel Set',
        'chemistry-laboratory-funnel-set',
        'Laboratory funnel set for educational chemistry practical work.',
        'Borosil',
        250.00, 199.00, FALSE
    ),
    (
        'LAB-CHEM-006',
        'Chemistry Laboratory Tripod Stand',
        'chemistry-laboratory-tripod-stand',
        'Tripod stand for supporting laboratory vessels during supervised experiments.',
        'Student Marketplace',
        450.00, 399.00, TRUE
    ),
    (
        'LAB-CHEM-007',
        'Chemistry Laboratory Glass Rod Set',
        'chemistry-laboratory-glass-rod-set',
        'Glass rods for mixing and transferring liquids during educational experiments.',
        'Borosil',
        180.00, 149.00, FALSE
    ),
    (
        'LAB-CHEM-008',
        'Chemistry Laboratory Test Tube Holder',
        'chemistry-laboratory-test-tube-holder',
        'Holder for safely handling test tubes during supervised practical experiments.',
        'Student Marketplace',
        150.00, 129.00, FALSE
    )
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'chemistry-lab'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- INVENTORY
-- ============================================================

INSERT INTO inventory (product_id, quantity)
SELECT
    p.id,
    15
FROM products p
WHERE p.sku LIKE 'LAB-%'
AND NOT EXISTS (
    SELECT 1
    FROM inventory i
    WHERE i.product_id = p.id
);

COMMIT;