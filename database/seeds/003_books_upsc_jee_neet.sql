-- ============================================================
-- STUDENT MARKETPLACE
-- Batch 1: UPSC + IIT JEE + NEET Books
-- ============================================================

BEGIN;

-- ============================================================
-- UPSC BOOKS
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price, discount_price)
SELECT
    c.id,
    v.sku,
    v.name,
    v.slug,
    v.description,
    v.brand,
    v.price,
    v.discount_price
FROM (
    VALUES
    (
        'BOOK-UPSC-POL-001',
        'Indian Polity by M. Laxmikanth',
        'indian-polity-m-laxmikanth',
        'Comprehensive Indian Polity preparation book for UPSC Civil Services aspirants.',
        'McGraw Hill',
        850.00,
        699.00,
        'upsc-indian-polity'
    ),
    (
        'BOOK-UPSC-HIS-001',
        'A Brief History of Modern India',
        'a-brief-history-of-modern-india',
        'Modern Indian history preparation book useful for UPSC Prelims and Mains.',
        'Spectrum',
        450.00,
        379.00,
        'upsc-indian-history'
    ),
    (
        'BOOK-UPSC-GEO-001',
        'Certificate Physical and Human Geography',
        'certificate-physical-human-geography',
        'Geography reference book covering physical and human geography concepts.',
        'G.C. Leong',
        320.00,
        279.00,
        'upsc-geography'
    ),
    (
        'BOOK-UPSC-ECO-001',
        'Indian Economy',
        'indian-economy-ramesh-singh',
        'Comprehensive Indian Economy preparation resource for competitive examinations.',
        'Ramesh Singh',
        850.00,
        699.00,
        'upsc-indian-economy'
    ),
    (
        'BOOK-UPSC-ENV-001',
        'Environment',
        'environment-shankar-ias',
        'Environment and ecology preparation material for UPSC.',
        'Shankar IAS Academy',
        550.00,
        469.00,
        'upsc-environment-ecology'
    ),
    (
        'BOOK-UPSC-ART-001',
        'Indian Art and Culture',
        'indian-art-and-culture-nitin-singhania',
        'Indian art, culture and heritage preparation resource for UPSC.',
        'Nitin Singhania',
        900.00,
        749.00,
        'upsc-art-culture'
    ),
    (
        'BOOK-UPSC-ETH-001',
        'Lexicon for Ethics, Integrity and Aptitude',
        'lexicon-ethics-integrity-aptitude',
        'Ethics and integrity preparation book for UPSC Civil Services.',
        'Chronicle',
        450.00,
        379.00,
        'upsc-ethics'
    ),
    (
        'BOOK-UPSC-CSAT-001',
        'CSAT Paper II Manual',
        'csat-paper-two-manual',
        'Quantitative aptitude, reasoning and comprehension practice for UPSC CSAT.',
        'McGraw Hill',
        550.00,
        449.00,
        'upsc-csat'
    ),
    (
        'BOOK-UPSC-SCI-001',
        'Science and Technology for UPSC',
        'science-and-technology-upsc',
        'Science and technology concepts and current applications for UPSC preparation.',
        'McGraw Hill',
        500.00,
        419.00,
        'upsc-science-technology'
    ),
    (
        'BOOK-UPSC-CUR-001',
        'UPSC Current Affairs & General Studies',
        'upsc-current-affairs-general-studies',
        'Current affairs and general studies revision resource for UPSC aspirants.',
        'Student Marketplace',
        299.00,
        249.00,
        'upsc-current-affairs'
    )
) AS v(sku, name, slug, description, brand, price, discount_price, category_slug)
JOIN categories c ON c.slug = v.category_slug
ON CONFLICT (sku) DO NOTHING;

-- ============================================================
-- IIT JEE BOOKS
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price, discount_price)
SELECT
    c.id,
    v.sku,
    v.name,
    v.slug,
    v.description,
    v.brand,
    v.price,
    v.discount_price
FROM (
    VALUES
    (
        'BOOK-JEE-PHY-001',
        'Concepts of Physics Volume 1',
        'concepts-of-physics-volume-1-hc-verma',
        'Concept-focused physics preparation book for JEE aspirants.',
        'H.C. Verma',
        450.00,
        379.00,
        'jee-physics'
    ),
    (
        'BOOK-JEE-PHY-002',
        'Concepts of Physics Volume 2',
        'concepts-of-physics-volume-2-hc-verma',
        'Advanced physics concepts and numerical problems for JEE preparation.',
        'H.C. Verma',
        450.00,
        379.00,
        'jee-physics'
    ),
    (
        'BOOK-JEE-PHY-003',
        'Understanding Physics Mechanics',
        'understanding-physics-mechanics-dc-pandey',
        'Topic-wise physics theory and problems for JEE preparation.',
        'D.C. Pandey',
        500.00,
        429.00,
        'jee-physics'
    ),
    (
        'BOOK-JEE-CHE-001',
        'NCERT Chemistry Class 11',
        'ncert-chemistry-class-11',
        'Foundation chemistry textbook for JEE preparation.',
        'NCERT',
        180.00,
        160.00,
        'jee-chemistry'
    ),
    (
        'BOOK-JEE-CHE-002',
        'NCERT Chemistry Class 12',
        'ncert-chemistry-class-12',
        'Class 12 chemistry textbook forming the foundation for JEE preparation.',
        'NCERT',
        190.00,
        170.00,
        'jee-chemistry'
    ),
    (
        'BOOK-JEE-CHE-003',
        'Physical Chemistry',
        'physical-chemistry-op-tandon',
        'Physical chemistry theory and numerical practice for JEE.',
        'O.P. Tandon',
        550.00,
        469.00,
        'jee-chemistry'
    ),
    (
        'BOOK-JEE-MAT-001',
        'Objective Mathematics',
        'objective-mathematics-rd-sharma',
        'Mathematics concepts and objective problems for competitive exams.',
        'R.D. Sharma',
        650.00,
        549.00,
        'jee-mathematics'
    ),
    (
        'BOOK-JEE-MAT-002',
        'Cengage Mathematics for JEE',
        'cengage-mathematics-jee',
        'Comprehensive mathematics preparation with theory and practice problems.',
        'Cengage',
        750.00,
        649.00,
        'jee-mathematics'
    ),
    (
        'BOOK-JEE-MAIN-001',
        'JEE Main Chapterwise Previous Years Questions',
        'jee-main-chapterwise-previous-years',
        'Chapter-wise JEE Main previous year questions for practice and revision.',
        'Arihant',
        400.00,
        339.00,
        'jee-main'
    ),
    (
        'BOOK-JEE-ADV-001',
        'JEE Advanced Previous Years Papers',
        'jee-advanced-previous-years-papers',
        'Previous year JEE Advanced papers with solutions.',
        'Arihant',
        450.00,
        379.00,
        'jee-advanced'
    )
) AS v(sku, name, slug, description, brand, price, discount_price, category_slug)
JOIN categories c ON c.slug = v.category_slug
ON CONFLICT (sku) DO NOTHING;

-- ============================================================
-- NEET BOOKS
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price, discount_price)
SELECT
    c.id,
    v.sku,
    v.name,
    v.slug,
    v.description,
    v.brand,
    v.price,
    v.discount_price
FROM (
    VALUES
    (
        'BOOK-NEET-PHY-001',
        'NCERT Physics Class 11',
        'ncert-physics-class-11',
        'Physics foundation textbook for NEET preparation.',
        'NCERT',
        180.00,
        160.00,
        'neet-physics'
    ),
    (
        'BOOK-NEET-PHY-002',
        'NCERT Physics Class 12',
        'ncert-physics-class-12',
        'Class 12 physics textbook for NEET preparation.',
        'NCERT',
        190.00,
        170.00,
        'neet-physics'
    ),
    (
        'BOOK-NEET-PHY-003',
        'Concepts of Physics',
        'concepts-of-physics-hc-verma-neet',
        'Physics concept building and numerical practice for medical entrance preparation.',
        'H.C. Verma',
        450.00,
        379.00,
        'neet-physics'
    ),
    (
        'BOOK-NEET-CHE-001',
        'NCERT Chemistry Class 11',
        'neet-ncert-chemistry-class-11',
        'Chemistry foundation textbook for NEET preparation.',
        'NCERT',
        180.00,
        160.00,
        'neet-chemistry'
    ),
    (
        'BOOK-NEET-CHE-002',
        'NCERT Chemistry Class 12',
        'neet-ncert-chemistry-class-12',
        'Class 12 chemistry textbook for NEET preparation.',
        'NCERT',
        190.00,
        170.00,
        'neet-chemistry'
    ),
    (
        'BOOK-NEET-CHE-003',
        'Organic Chemistry',
        'organic-chemistry-ms-chauhan',
        'Organic chemistry concepts and practice problems for NEET preparation.',
        'M.S. Chauhan',
        550.00,
        469.00,
        'neet-chemistry'
    ),
    (
        'BOOK-NEET-BIO-001',
        'NCERT Biology Class 11',
        'ncert-biology-class-11',
        'Core biology textbook for NEET preparation.',
        'NCERT',
        220.00,
        195.00,
        'neet-biology'
    ),
    (
        'BOOK-NEET-BIO-002',
        'NCERT Biology Class 12',
        'ncert-biology-class-12',
        'Class 12 biology textbook for NEET preparation.',
        'NCERT',
        230.00,
        205.00,
        'neet-biology'
    ),
    (
        'BOOK-NEET-BIO-003',
        'Trueman Biology Volume 1',
        'trueman-biology-volume-1',
        'Detailed biology reference and practice resource for NEET.',
        'Trueman',
        650.00,
        549.00,
        'neet-biology'
    ),
    (
        'BOOK-NEET-PYQ-001',
        'NEET Chapterwise Previous Years Questions',
        'neet-chapterwise-previous-years',
        'Chapter-wise NEET previous year questions for revision and practice.',
        'MTG',
        450.00,
        379.00,
        'neet-previous-year-papers'
    )
) AS v(sku, name, slug, description, brand, price, discount_price, category_slug)
JOIN categories c ON c.slug = v.category_slug
ON CONFLICT (sku) DO NOTHING;

-- ============================================================
-- INVENTORY
-- ============================================================

INSERT INTO inventory
    (product_id, quantity, reserved_quantity, low_stock_threshold)
SELECT
    p.id,
    25,
    0,
    5
FROM products p
WHERE p.sku LIKE 'BOOK-UPSC-%'
   OR p.sku LIKE 'BOOK-JEE-%'
   OR p.sku LIKE 'BOOK-NEET-%'
ON CONFLICT (product_id) DO NOTHING;

COMMIT;