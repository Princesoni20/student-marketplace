-- ============================================================
-- STUDENT MARKETPLACE
-- STATIONERY PRODUCTS
-- ============================================================

BEGIN;

-- ============================================================
-- GLUE / GUM
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('STAT-GLUE-001', 'Fevicol MR Glue', 'fevicol-mr-glue',
     'Multi-purpose adhesive for school, college and project work.',
     'Fevicol', 45.00, 40.00, TRUE),
    ('STAT-GLUE-002', 'Fevistik Glue Stick', 'fevistik-glue-stick',
     'Clean glue stick for assignments, projects and paper work.',
     'Fevistik', 30.00, 27.00, TRUE),
    ('STAT-GLUE-003', 'Camlin Glue Stick', 'camlin-glue-stick',
     'Glue stick suitable for everyday stationery use.',
     'Camlin', 25.00, 22.00, FALSE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'glue-gum'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- CHART PAPER
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('STAT-CHART-001', 'White Chart Paper Pack',
     'white-chart-paper-pack',
     'Chart paper for school projects, presentations and assignments.',
     'Classmate', 80.00, 72.00, TRUE),
    ('STAT-CHART-002', 'Colored Chart Paper Pack',
     'colored-chart-paper-pack',
     'Assorted colored chart papers for student projects.',
     'Camlin', 100.00, 90.00, TRUE),
    ('STAT-CHART-003', 'Project Chart Paper Set',
     'project-chart-paper-set',
     'Multi-color chart paper set for presentations and projects.',
     'Navneet', 120.00, 108.00, FALSE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'chart-paper'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- COLORED PAPER
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('STAT-PAPER-001', 'Colored Craft Paper Pack',
     'colored-craft-paper-pack',
     'Assorted colored paper for crafts, assignments and projects.',
     'Camlin', 75.00, 68.00, TRUE),
    ('STAT-PAPER-002', 'A4 Colored Paper Pack',
     'a4-colored-paper-pack',
     'A4 colored sheets for printing, projects and presentations.',
     'JK Paper', 110.00, 99.00, TRUE),
    ('STAT-PAPER-003', 'Origami Colored Paper',
     'origami-colored-paper',
     'Colored paper sheets for creative student projects.',
     'Navneet', 60.00, 54.00, FALSE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'colored-paper'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- SELLOTAPE
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('STAT-TAPE-001', 'Cello Transparent Tape',
     'cello-transparent-tape',
     'Transparent adhesive tape for everyday stationery work.',
     'Cello', 25.00, 22.00, TRUE),
    ('STAT-TAPE-002', 'Scotch Transparent Tape',
     'scotch-transparent-tape',
     'Reliable transparent tape for projects and office work.',
     'Scotch', 55.00, 49.00, TRUE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'sellotape'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- DOUBLE-SIDED TAPE
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('STAT-DSTAPE-001', 'Scotch Double Sided Tape',
     'scotch-double-sided-tape',
     'Double-sided adhesive tape for projects and mounting work.',
     'Scotch', 75.00, 68.00, TRUE),
    ('STAT-DSTAPE-002', 'Cello Double Sided Tape',
     'cello-double-sided-tape',
     'Double-sided tape for student projects and craft work.',
     'Cello', 45.00, 40.00, TRUE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'double-sided-tape'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- SCISSORS
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('STAT-SCISSOR-001', 'Camlin Student Scissors',
     'camlin-student-scissors',
     'Student scissors for paper cutting and project work.',
     'Camlin', 55.00, 49.00, TRUE),
    ('STAT-SCISSOR-002', 'Faber-Castell Student Scissors',
     'faber-castell-student-scissors',
     'Comfortable scissors for school, college and craft work.',
     'Faber-Castell', 85.00, 76.00, TRUE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'scissors'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- STAPLER
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('STAT-STAPLER-001', 'Kangaro Mini Stapler',
     'kangaro-mini-stapler',
     'Compact stapler for assignments, notes and office work.',
     'Kangaro', 75.00, 68.00, TRUE),
    ('STAT-STAPLER-002', 'Kangaro HD-10 Stapler',
     'kangaro-hd10-stapler',
     'Durable stapler suitable for student and office use.',
     'Kangaro', 160.00, 145.00, TRUE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'stapler'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- STAPLES
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('STAT-STAPLES-001', 'Kangaro Staples No. 10',
     'kangaro-staples-no10',
     'Staples compatible with standard mini staplers.',
     'Kangaro', 20.00, 18.00, TRUE),
    ('STAT-STAPLES-002', 'Kangaro 24/6 Staples',
     'kangaro-246-staples',
     'Standard staples for office and student staplers.',
     'Kangaro', 30.00, 27.00, TRUE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'staples'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- PAPER CLIPS
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('STAT-CLIP-001', 'Kangaro Paper Clips',
     'kangaro-paper-clips',
     'Metal paper clips for organizing assignments and documents.',
     'Kangaro', 30.00, 27.00, TRUE),
    ('STAT-CLIP-002', 'Paper Clip Assorted Pack',
     'assorted-paper-clip-pack',
     'Assorted paper clips for organizing student documents.',
     'Solo', 40.00, 36.00, FALSE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'paper-clips'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- BINDER CLIPS
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('STAT-BINDER-001', 'Kangaro Binder Clips Small',
     'kangaro-binder-clips-small',
     'Small binder clips for organizing notes and documents.',
     'Kangaro', 35.00, 32.00, TRUE),
    ('STAT-BINDER-002', 'Kangaro Binder Clips Medium',
     'kangaro-binder-clips-medium',
     'Medium binder clips for assignments and document organization.',
     'Kangaro', 55.00, 49.00, TRUE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'binder-clips'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- FILES / FOLDERS
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('STAT-FILE-001', 'Classmate Document Folder',
     'classmate-document-folder',
     'Document folder for organizing assignments and study material.',
     'Classmate', 45.00, 40.00, TRUE),
    ('STAT-FILE-002', 'Kangaro Plastic File',
     'kangaro-plastic-file',
     'Plastic file for storing college documents and assignments.',
     'Kangaro', 35.00, 32.00, TRUE),
    ('STAT-FILE-003', 'Solo Display File',
     'solo-display-file',
     'Display file for organizing projects, notes and presentations.',
     'Solo', 95.00, 85.00, TRUE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'files-folders'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- STICKY NOTES
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('STAT-STICKY-001', 'Post-it Notes 3 x 3',
     'post-it-notes-3x3',
     'Self-adhesive notes for reminders, revision and study planning.',
     'Post-it', 120.00, 108.00, TRUE),
    ('STAT-STICKY-002', 'Classmate Sticky Notes',
     'classmate-sticky-notes',
     'Colorful sticky notes for study reminders and organization.',
     'Classmate', 60.00, 54.00, TRUE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'sticky-notes'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- SKETCH PENS
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('STAT-SKETCH-001', 'Camlin Sketch Pens Set',
     'camlin-sketch-pens-set',
     'Colorful sketch pens for school projects and creative work.',
     'Camlin', 60.00, 54.00, TRUE),
    ('STAT-SKETCH-002', 'Faber-Castell Sketch Pens',
     'faber-castell-sketch-pens',
     'Quality sketch pens for drawing and student projects.',
     'Faber-Castell', 90.00, 81.00, TRUE),
    ('STAT-SKETCH-003', 'Classmate Sketch Pens',
     'classmate-sketch-pens',
     'Student-friendly sketch pen set for creative projects.',
     'Classmate', 55.00, 49.00, FALSE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'sketch-pens'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- COLORED PENCILS
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('STAT-COLORPENCIL-001', 'Faber-Castell Colour Pencils',
     'faber-castell-colour-pencils',
     'Colored pencils for drawing, projects and creative assignments.',
     'Faber-Castell', 120.00, 108.00, TRUE),
    ('STAT-COLORPENCIL-002', 'Camlin Colour Pencils',
     'camlin-colour-pencils',
     'Student color pencils for artwork and project work.',
     'Camlin', 80.00, 72.00, TRUE),
    ('STAT-COLORPENCIL-003', 'Classmate Colour Pencils',
     'classmate-colour-pencils',
     'Affordable colored pencils for school and college projects.',
     'Classmate', 65.00, 58.00, FALSE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'colored-pencils'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- CORRECTION PEN
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('STAT-CORRECT-001', 'Camlin Correction Pen',
     'camlin-correction-pen',
     'Correction pen for covering writing errors on paper.',
     'Camlin', 30.00, 27.00, TRUE),
    ('STAT-CORRECT-002', 'Faber-Castell Correction Pen',
     'faber-castell-correction-pen',
     'Quick-drying correction pen for assignments and notes.',
     'Faber-Castell', 45.00, 40.00, TRUE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'correction-pen'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- ASSIGNMENT PAGES
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('STAT-ASSIGN-001', 'A4 Assignment Sheets',
     'a4-assignment-sheets',
     'Ruled A4 sheets suitable for college assignments and submissions.',
     'Navneet', 70.00, 63.00, TRUE),
    ('STAT-ASSIGN-002', 'Assignment Paper Pack 100 Sheets',
     'assignment-paper-pack-100',
     'Pack of assignment sheets for regular academic submissions.',
     'JK Paper', 120.00, 108.00, TRUE),
    ('STAT-ASSIGN-003', 'College Assignment File Sheets',
     'college-assignment-file-sheets',
     'Assignment sheets designed for college project and record work.',
     'Classmate', 90.00, 81.00, FALSE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'assignment-pages'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- PRACTICAL PAGES
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('STAT-PRACTICAL-001', 'Physics Practical Pages',
     'physics-practical-pages',
     'Practical record sheets for physics laboratory work.',
     'Navneet', 75.00, 68.00, TRUE),
    ('STAT-PRACTICAL-002', 'Chemistry Practical Pages',
     'chemistry-practical-pages',
     'Practical record sheets for chemistry laboratory work.',
     'Navneet', 75.00, 68.00, TRUE),
    ('STAT-PRACTICAL-003', 'Biology Practical Pages',
     'biology-practical-pages',
     'Practical record sheets for biology laboratory work.',
     'Navneet', 75.00, 68.00, TRUE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'practical-pages'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- PRACTICAL FILE
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('STAT-PFILE-001', 'Classmate Practical File',
     'classmate-practical-file',
     'Practical file for maintaining laboratory records and submissions.',
     'Classmate', 75.00, 68.00, TRUE),
    ('STAT-PFILE-002', 'Kangaro Practical File',
     'kangaro-practical-file',
     'Durable practical file for school and college laboratory records.',
     'Kangaro', 65.00, 59.00, TRUE),
    ('STAT-PFILE-003', 'Project and Practical File',
     'project-and-practical-file',
     'File suitable for project reports and practical records.',
     'Solo', 85.00, 76.00, FALSE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'practical-file'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- PAPER CUTTER
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('STAT-CUTTER-001', 'Maped Paper Cutter',
     'maped-paper-cutter',
     'Paper cutting tool for stationery, craft and project work.',
     'Maped', 85.00, 76.00, TRUE),
    ('STAT-CUTTER-002', 'Kangaro Paper Cutter',
     'kangaro-paper-cutter',
     'Compact paper cutter for stationery and project work.',
     'Kangaro', 70.00, 63.00, TRUE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'paper-cutter'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- PAINTING COLORS
-- ============================================================

INSERT INTO products
    (category_id, sku, name, slug, description, brand, price,
     discount_price, is_active, is_featured)
SELECT c.id, v.sku, v.name, v.slug, v.description, v.brand,
       v.price, v.discount_price, TRUE, v.is_featured
FROM categories c
CROSS JOIN (
    VALUES
    ('STAT-COLOR-001', 'Camlin Poster Colours Set',
     'camlin-poster-colours-set',
     'Poster colors for school projects, charts and artwork.',
     'Camlin', 120.00, 108.00, TRUE),
    ('STAT-COLOR-002', 'Camel Water Colour Cakes',
     'camel-water-colour-cakes',
     'Water colors for student artwork and creative projects.',
     'Camel', 95.00, 85.00, TRUE),
    ('STAT-COLOR-003', 'Faber-Castell Water Colours',
     'faber-castell-water-colours',
     'Water color set suitable for school and college art work.',
     'Faber-Castell', 140.00, 126.00, TRUE),
    ('STAT-COLOR-004', 'Camel Acrylic Colours Set',
     'camel-acrylic-colours-set',
     'Acrylic colors for art projects and creative work.',
     'Camel', 220.00, 198.00, FALSE)
) AS v(sku,name,slug,description,brand,price,discount_price,is_featured)
WHERE c.slug = 'painting-colors'
ON CONFLICT (sku) DO NOTHING;


-- ============================================================
-- INVENTORY
-- ============================================================

INSERT INTO inventory (product_id, quantity)
SELECT
    p.id,
    25
FROM products p
WHERE p.sku LIKE 'STAT-%'
AND NOT EXISTS (
    SELECT 1
    FROM inventory i
    WHERE i.product_id = p.id
);

COMMIT;