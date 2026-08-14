-- ============================================================
-- STUDENT MARKETPLACE
-- NCERT SCHOOL BOOKS - CLASSES 9 TO 12
-- Important books only
-- ============================================================

BEGIN;

-- ============================================================
-- CLASS 9 NCERT - CURRENT 2026-27 TITLES
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT
    c.id,
    v.sku,
    v.name,
    v.slug,
    v.description,
    'NCERT',
    v.price,
    v.discount_price,
    TRUE,
    v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    (
        'NCERT9-ENG-001',
        'Kaveri - Textbook of English for Grade 9',
        'kaveri-textbook-english-grade-9',
        'NCERT English textbook for Grade 9, current 2026-27 edition.',
        145.00, 140.00, TRUE
    ),
    (
        'NCERT9-HIN-001',
        'Ganga - Textbook of Hindi for Grade 9',
        'ganga-textbook-hindi-grade-9',
        'NCERT Hindi textbook for Grade 9, current 2026-27 edition.',
        115.00, 110.00, TRUE
    ),
    (
        'NCERT9-MAT-001',
        'Ganita Manjari - Textbook of Mathematics for Grade 9 Part I',
        'ganita-manjari-mathematics-grade-9-part-1',
        'NCERT Mathematics textbook for Grade 9, current 2026 edition.',
        115.00, 110.00, TRUE
    ),
    (
        'NCERT9-SCI-001',
        'Exploration - Textbook of Science for Grade 9',
        'exploration-science-grade-9',
        'NCERT integrated Science textbook for Grade 9, current 2026-27 curriculum.',
        150.00, 145.00, TRUE
    ),
    (
        'NCERT9-SST-001',
        'Exploring Society: India and Beyond - Grade 9',
        'exploring-society-india-and-beyond-grade-9',
        'NCERT Social Science textbook for Grade 9 based on the new curriculum.',
        180.00, 175.00, TRUE
    ),
    (
        'NCERT9-SAN-001',
        'Sharada - Textbook of Sanskrit for Grade 9',
        'sharada-sanskrit-grade-9',
        'NCERT Sanskrit textbook for Grade 9, current curriculum.',
        120.00, 115.00, FALSE
    )
) AS v(sku, name, slug, description, price, discount_price, is_featured)
WHERE c.slug = 'class-9-ncert'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- CLASS 10 NCERT
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT
    c.id,
    v.sku,
    v.name,
    v.slug,
    v.description,
    'NCERT',
    v.price,
    v.discount_price,
    TRUE,
    v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    (
        'NCERT10-MAT-001',
        'Mathematics - Textbook for Class X',
        'mathematics-textbook-class-10-ncert',
        'NCERT Mathematics textbook for Class 10.',
        150.00, 145.00, TRUE
    ),
    (
        'NCERT10-SCI-001',
        'Science - Textbook for Class X',
        'science-textbook-class-10-ncert',
        'NCERT Science textbook for Class 10.',
        150.00, 145.00, TRUE
    ),
    (
        'NCERT10-ENG-001',
        'First Flight - English Textbook for Class X',
        'first-flight-english-class-10-ncert',
        'NCERT English main textbook for Class 10.',
        120.00, 115.00, TRUE
    ),
    (
        'NCERT10-ENG-002',
        'Footprints Without Feet - Supplementary Reader for Class X',
        'footprints-without-feet-class-10-ncert',
        'NCERT supplementary English reader for Class 10.',
        90.00, 85.00, TRUE
    ),
    (
        'NCERT10-SST-001',
        'India and the Contemporary World II - History',
        'india-contemporary-world-ii-class-10-history',
        'NCERT History textbook for Class 10.',
        90.00, 85.00, TRUE
    ),
    (
        'NCERT10-SST-002',
        'Contemporary India II - Geography',
        'contemporary-india-ii-class-10-geography',
        'NCERT Geography textbook for Class 10.',
        85.00, 80.00, TRUE
    ),
    (
        'NCERT10-SST-003',
        'Democratic Politics II - Political Science',
        'democratic-politics-ii-class-10',
        'NCERT Political Science textbook for Class 10.',
        80.00, 75.00, TRUE
    ),
    (
        'NCERT10-SST-004',
        'Understanding Economic Development - Economics',
        'understanding-economic-development-class-10',
        'NCERT Economics textbook for Class 10.',
        70.00, 65.00, TRUE
    )
) AS v(sku, name, slug, description, price, discount_price, is_featured)
WHERE c.slug = 'class-10-ncert'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- CLASS 11 NCERT - IMPORTANT CORE BOOKS
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT
    c.id,
    v.sku,
    v.name,
    v.slug,
    v.description,
    'NCERT',
    v.price,
    v.discount_price,
    TRUE,
    v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    (
        'NCERT11-MAT-001',
        'Mathematics - Textbook for Class XI',
        'mathematics-class-11-ncert',
        'NCERT Mathematics textbook for Class 11.',
        170.00, 165.00, TRUE
    ),
    (
        'NCERT11-PHY-001',
        'Physics Part I - Class XI',
        'physics-part-1-class-11-ncert',
        'NCERT Physics Part I textbook for Class 11.',
        120.00, 115.00, TRUE
    ),
    (
        'NCERT11-PHY-002',
        'Physics Part II - Class XI',
        'physics-part-2-class-11-ncert',
        'NCERT Physics Part II textbook for Class 11.',
        145.00, 140.00, TRUE
    ),
    (
        'NCERT11-CHE-001',
        'Chemistry Part I - Class XI',
        'chemistry-part-1-class-11-ncert',
        'NCERT Chemistry Part I textbook for Class 11.',
        180.00, 175.00, TRUE
    ),
    (
        'NCERT11-CHE-002',
        'Chemistry Part II - Class XI',
        'chemistry-part-2-class-11-ncert',
        'NCERT Chemistry Part II textbook for Class 11.',
        80.00, 75.00, TRUE
    ),
    (
        'NCERT11-BIO-001',
        'Biology - Textbook for Class XI',
        'biology-class-11-ncert',
        'NCERT Biology textbook for Class 11.',
        185.00, 180.00, TRUE
    ),
    (
        'NCERT11-ACC-001',
        'Accountancy Part I - Class XI',
        'accountancy-part-1-class-11-ncert',
        'NCERT Accountancy textbook for Class 11.',
        150.00, 145.00, TRUE
    ),
    (
        'NCERT11-ECO-001',
        'Indian Economic Development - Class XI',
        'indian-economic-development-class-11-ncert',
        'NCERT Economics textbook for Class 11.',
        140.00, 135.00, TRUE
    ),
    (
        'NCERT11-POL-001',
        'Indian Constitution at Work - Class XI',
        'indian-constitution-at-work-class-11-ncert',
        'NCERT Political Science textbook for Class 11.',
        120.00, 115.00, TRUE
    ),
    (
        'NCERT11-HIS-001',
        'Themes in World History - Class XI',
        'themes-in-world-history-class-11-ncert',
        'NCERT History textbook for Class 11.',
        130.00, 125.00, FALSE
    )
) AS v(sku, name, slug, description, price, discount_price, is_featured)
WHERE c.slug = 'class-11-ncert'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- CLASS 12 NCERT - IMPORTANT CORE BOOKS
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT
    c.id,
    v.sku,
    v.name,
    v.slug,
    v.description,
    'NCERT',
    v.price,
    v.discount_price,
    TRUE,
    v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    (
        'NCERT12-MAT-001',
        'Mathematics Part I - Class XII',
        'mathematics-part-1-class-12-ncert',
        'NCERT Mathematics Part I textbook for Class 12.',
        100.00, 95.00, TRUE
    ),
    (
        'NCERT12-MAT-002',
        'Mathematics Part II - Class XII',
        'mathematics-part-2-class-12-ncert',
        'NCERT Mathematics Part II textbook for Class 12.',
        100.00, 95.00, TRUE
    ),
    (
        'NCERT12-PHY-001',
        'Physics Part I - Class XII',
        'physics-part-1-class-12-ncert',
        'NCERT Physics Part I textbook for Class 12.',
        150.00, 145.00, TRUE
    ),
    (
        'NCERT12-PHY-002',
        'Physics Part II - Class XII',
        'physics-part-2-class-12-ncert',
        'NCERT Physics Part II textbook for Class 12.',
        145.00, 140.00, TRUE
    ),
    (
        'NCERT12-CHE-001',
        'Chemistry Part I - Class XII',
        'chemistry-part-1-class-12-ncert',
        'NCERT Chemistry Part I textbook for Class 12.',
        130.00, 125.00, TRUE
    ),
    (
        'NCERT12-CHE-002',
        'Chemistry Part II - Class XII',
        'chemistry-part-2-class-12-ncert',
        'NCERT Chemistry Part II textbook for Class 12.',
        120.00, 115.00, TRUE
    ),
    (
        'NCERT12-BIO-001',
        'Biology - Textbook for Class XII',
        'biology-class-12-ncert',
        'NCERT Biology textbook for Class 12.',
        170.00, 165.00, TRUE
    ),
    (
        'NCERT12-ACC-001',
        'Accountancy Part I - Class XII',
        'accountancy-part-1-class-12-ncert',
        'NCERT Accountancy textbook for Class 12.',
        150.00, 145.00, TRUE
    ),
    (
        'NCERT12-ECO-001',
        'Introductory Macroeconomics - Class XII',
        'introductory-macroeconomics-class-12-ncert',
        'NCERT Economics textbook for Class 12.',
        140.00, 135.00, TRUE
    ),
    (
        'NCERT12-POL-001',
        'Politics in India Since Independence - Class XII',
        'politics-in-india-since-independence-class-12-ncert',
        'NCERT Political Science textbook for Class 12.',
        120.00, 115.00, TRUE
    )
) AS v(sku, name, slug, description, price, discount_price, is_featured)
WHERE c.slug = 'class-12-ncert'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- INVENTORY
-- Every newly added NCERT product starts with 25 units.
-- Existing inventory records are not touched.
-- ============================================================

INSERT INTO inventory (product_id, quantity)
SELECT
    p.id,
    25
FROM products p
WHERE p.sku LIKE 'NCERT9-%'
   OR p.sku LIKE 'NCERT10-%'
   OR p.sku LIKE 'NCERT11-%'
   OR p.sku LIKE 'NCERT12-%'
AND NOT EXISTS (
    SELECT 1
    FROM inventory i
    WHERE i.product_id = p.id
);

COMMIT;