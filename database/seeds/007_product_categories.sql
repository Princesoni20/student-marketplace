-- ============================================================
-- STUDENT MARKETPLACE
-- PRODUCT CATEGORIES
-- Pens, Notebooks, Water Bottles, Geometry, Stationery,
-- Laptops, Bags, Student Essentials and Lab Equipment
-- ============================================================

BEGIN;

-- ============================================================
-- PEN
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'Pen',
    'pen',
    'Pens and writing instruments for students.',
    12
FROM categories
WHERE slug = 'books'
ON CONFLICT (slug) DO NOTHING;

-- Pen subcategories

INSERT INTO categories (parent_id, name, slug, description, sort_order)
SELECT id, 'Ball Pens', 'ball-pens',
       'Everyday ball pens for students and office use.', 1
FROM categories WHERE slug = 'pen'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, description, sort_order)
SELECT id, 'Gel Pens', 'gel-pens',
       'Smooth writing gel pens for students.', 2
FROM categories WHERE slug = 'pen'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, description, sort_order)
SELECT id, 'Fountain Pens', 'fountain-pens',
       'Fountain pens for writing and personal use.', 3
FROM categories WHERE slug = 'pen'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, description, sort_order)
SELECT id, 'Marker Pens', 'marker-pens',
       'Marker pens for notes, projects and presentations.', 4
FROM categories WHERE slug = 'pen'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, description, sort_order)
SELECT id, 'Highlighters', 'highlighters',
       'Highlighters for study and revision.', 5
FROM categories WHERE slug = 'pen'
ON CONFLICT (slug) DO NOTHING;


-- ============================================================
-- NOTEBOOK
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'Notebook',
    'notebook',
    'Notebooks and writing pads for students.',
    13
FROM categories
WHERE slug = 'books'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, description, sort_order)
SELECT id, 'Class Notebook', 'class-notebook',
       'Notebooks for daily classroom notes.', 1
FROM categories WHERE slug = 'notebook'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, description, sort_order)
SELECT id, 'Spiral Notebook', 'spiral-notebook',
       'Spiral-bound notebooks for study and notes.', 2
FROM categories WHERE slug = 'notebook'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, description, sort_order)
SELECT id, 'Practical Notebook', 'practical-notebook',
       'Notebooks for laboratory practical records.', 3
FROM categories WHERE slug = 'notebook'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, description, sort_order)
SELECT id, 'Rough Notebook', 'rough-notebook',
       'Rough notebooks for practice and calculations.', 4
FROM categories WHERE slug = 'notebook'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, description, sort_order)
SELECT id, 'Long Notebook', 'long-notebook',
       'Long-format notebooks for school and college use.', 5
FROM categories WHERE slug = 'notebook'
ON CONFLICT (slug) DO NOTHING;


-- ============================================================
-- WATER BOTTLE
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'Water Bottle',
    'water-bottle',
    'Reusable water bottles suitable for students and college use.',
    14
FROM categories
WHERE slug = 'books'
ON CONFLICT (slug) DO NOTHING;


-- ============================================================
-- GEOMETRY BOX
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'Geometry Box',
    'geometry-box',
    'Mathematical drawing and geometry tools for students.',
    15
FROM categories
WHERE slug = 'books'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, description, sort_order)
SELECT id, 'Pencil', 'geometry-pencil',
       'Pencils for drawing and mathematical work.', 1
FROM categories WHERE slug = 'geometry-box'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, description, sort_order)
SELECT id, 'Eraser', 'geometry-eraser',
       'Erasers for school and college use.', 2
FROM categories WHERE slug = 'geometry-box'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, description, sort_order)
SELECT id, 'Sharpener', 'geometry-sharpener',
       'Pencil sharpeners for students.', 3
FROM categories WHERE slug = 'geometry-box'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, description, sort_order)
SELECT id, 'Scale / Ruler', 'geometry-scale-ruler',
       'Rulers and scales for drawing and measurement.', 4
FROM categories WHERE slug = 'geometry-box'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, description, sort_order)
SELECT id, 'Compass', 'geometry-compass',
       'Mathematical compasses for geometry and drawing.', 5
FROM categories WHERE slug = 'geometry-box'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, description, sort_order)
SELECT id, 'Divider', 'geometry-divider',
       'Dividers for mathematical measurement and drawing.', 6
FROM categories WHERE slug = 'geometry-box'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, description, sort_order)
SELECT id, 'Protractor', 'geometry-protractor',
       'Protractors for measuring angles.', 7
FROM categories WHERE slug = 'geometry-box'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, description, sort_order)
SELECT id, 'Set Squares', 'geometry-set-squares',
       'Set squares for geometry and technical drawing.', 8
FROM categories WHERE slug = 'geometry-box'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, description, sort_order)
SELECT id, 'Mechanical Pencil', 'mechanical-pencil',
       'Mechanical pencils for technical and academic drawing.', 9
FROM categories WHERE slug = 'geometry-box'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, description, sort_order)
SELECT id, 'Complete Geometry Box', 'complete-geometry-box',
       'Complete geometry sets containing essential mathematical tools.', 10
FROM categories WHERE slug = 'geometry-box'
ON CONFLICT (slug) DO NOTHING;


-- ============================================================
-- STATIONERY
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'Stationery',
    'stationery',
    'Everyday stationery and school/college supplies.',
    16
FROM categories
WHERE slug = 'books'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Glue / Gum', 'glue-gum', 1
FROM categories WHERE slug = 'stationery'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Chart Paper', 'chart-paper', 2
FROM categories WHERE slug = 'stationery'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Colored Paper', 'colored-paper', 3
FROM categories WHERE slug = 'stationery'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Sellotape', 'sellotape', 4
FROM categories WHERE slug = 'stationery'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Double-Sided Tape', 'double-sided-tape', 5
FROM categories WHERE slug = 'stationery'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Scissors', 'scissors', 6
FROM categories WHERE slug = 'stationery'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Stapler', 'stapler', 7
FROM categories WHERE slug = 'stationery'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Staples', 'staples', 8
FROM categories WHERE slug = 'stationery'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Paper Clips', 'paper-clips', 9
FROM categories WHERE slug = 'stationery'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Binder Clips', 'binder-clips', 10
FROM categories WHERE slug = 'stationery'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Files / Folders', 'files-folders', 11
FROM categories WHERE slug = 'stationery'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Sticky Notes', 'sticky-notes', 12
FROM categories WHERE slug = 'stationery'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Sketch Pens', 'sketch-pens', 13
FROM categories WHERE slug = 'stationery'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Colored Pencils', 'colored-pencils', 14
FROM categories WHERE slug = 'stationery'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Correction Pen', 'correction-pen', 15
FROM categories WHERE slug = 'stationery'
ON CONFLICT (slug) DO NOTHING;


-- ============================================================
-- LAPTOP
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'Laptop',
    'laptop',
    'Laptops suitable for students, college work, programming and productivity.',
    17
FROM categories
WHERE slug = 'books'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, description, sort_order)
SELECT id, 'Windows Laptops', 'windows-laptops',
       'Windows laptops from major laptop manufacturers.', 1
FROM categories WHERE slug = 'laptop'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, description, sort_order)
SELECT id, 'MacBook', 'macbook',
       'Apple MacBook laptops for students and professionals.', 2
FROM categories WHERE slug = 'laptop'
ON CONFLICT (slug) DO NOTHING;

-- Windows brands

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'HP', 'hp-laptops', 1
FROM categories WHERE slug = 'windows-laptops'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Dell', 'dell-laptops', 2
FROM categories WHERE slug = 'windows-laptops'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Lenovo', 'lenovo-laptops', 3
FROM categories WHERE slug = 'windows-laptops'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'ASUS', 'asus-laptops', 4
FROM categories WHERE slug = 'windows-laptops'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Acer', 'acer-laptops', 5
FROM categories WHERE slug = 'windows-laptops'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'MSI', 'msi-laptops', 6
FROM categories WHERE slug = 'windows-laptops'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Microsoft Surface', 'microsoft-surface',
       7
FROM categories WHERE slug = 'windows-laptops'
ON CONFLICT (slug) DO NOTHING;


-- ============================================================
-- LAPTOP BAGS
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'Laptop Bags',
    'laptop-bags',
    'Laptop bags and protective carrying solutions for students.',
    18
FROM categories
WHERE slug = 'books'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Laptop Backpack', 'laptop-backpack', 1
FROM categories WHERE slug = 'laptop-bags'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Laptop Sleeve', 'laptop-sleeve', 2
FROM categories WHERE slug = 'laptop-bags'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Laptop Messenger Bag', 'laptop-messenger-bag', 3
FROM categories WHERE slug = 'laptop-bags'
ON CONFLICT (slug) DO NOTHING;


-- ============================================================
-- COLLEGE BAGS
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'College Bags',
    'college-bags',
    'Backpacks and bags designed for college students.',
    19
FROM categories
WHERE slug = 'books'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'College Backpack', 'college-backpack', 1
FROM categories WHERE slug = 'college-bags'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Casual Backpack', 'casual-backpack', 2
FROM categories WHERE slug = 'college-bags'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Travel / College Backpack', 'travel-college-backpack', 3
FROM categories WHERE slug = 'college-bags'
ON CONFLICT (slug) DO NOTHING;


-- ============================================================
-- STUDENT ESSENTIALS
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'Student Essentials',
    'student-essentials',
    'Useful technology and everyday accessories for students.',
    20
FROM categories
WHERE slug = 'books'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Headphones', 'headphones', 1
FROM categories WHERE slug = 'student-essentials'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Earphones', 'earphones', 2
FROM categories WHERE slug = 'student-essentials'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'TWS Earbuds', 'tws-earbuds', 3
FROM categories WHERE slug = 'student-essentials'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'USB Drive', 'usb-drive', 4
FROM categories WHERE slug = 'student-essentials'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'External Storage', 'external-storage', 5
FROM categories WHERE slug = 'student-essentials'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Laptop Stand', 'laptop-stand', 6
FROM categories WHERE slug = 'student-essentials'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Mouse', 'student-mouse', 7
FROM categories WHERE slug = 'student-essentials'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Keyboard', 'student-keyboard', 8
FROM categories WHERE slug = 'student-essentials'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Calculator', 'student-calculator', 9
FROM categories WHERE slug = 'student-essentials'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Desk Organizer', 'desk-organizer', 10
FROM categories WHERE slug = 'student-essentials'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, sort_order)
SELECT id, 'Study Lamp', 'study-lamp', 11
FROM categories WHERE slug = 'student-essentials'
ON CONFLICT (slug) DO NOTHING;


-- ============================================================
-- LAB EQUIPMENT
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'Lab Equipment',
    'lab-equipment',
    'Laboratory equipment and educational lab supplies for students.',
    21
FROM categories
WHERE slug = 'books'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, description, sort_order)
SELECT id, 'Physics Lab', 'physics-lab',
       'Equipment and instruments for physics laboratory work.', 1
FROM categories WHERE slug = 'lab-equipment'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, description, sort_order)
SELECT id, 'Chemistry Lab', 'chemistry-lab',
       'Educational equipment and supplies for chemistry laboratory work.', 2
FROM categories WHERE slug = 'lab-equipment'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories (parent_id, name, slug, description, sort_order)
SELECT id, 'Biology Lab', 'biology-lab',
       'Educational equipment and supplies for biology laboratory work.', 3
FROM categories WHERE slug = 'lab-equipment'
ON CONFLICT (slug) DO NOTHING;


COMMIT;