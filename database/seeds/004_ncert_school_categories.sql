-- ============================================================
-- STUDENT MARKETPLACE
-- NCERT SCHOOL BOOK CATEGORIES
-- Classes 9 to 12
-- ============================================================

BEGIN;

-- ============================================================
-- SCHOOL / NCERT BOOKS
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'School / NCERT Books',
    'school-ncert-books',
    'NCERT and important school textbooks for Classes 9 to 12.',
    11
FROM categories
WHERE slug = 'books'
ON CONFLICT (slug) DO NOTHING;

-- ============================================================
-- CLASS 9
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'Class 9 NCERT',
    'class-9-ncert',
    'Important NCERT textbooks and study books for Class 9.',
    1
FROM categories
WHERE slug = 'school-ncert-books'
ON CONFLICT (slug) DO NOTHING;

-- ============================================================
-- CLASS 10
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'Class 10 NCERT',
    'class-10-ncert',
    'Important NCERT textbooks and study books for Class 10.',
    2
FROM categories
WHERE slug = 'school-ncert-books'
ON CONFLICT (slug) DO NOTHING;

-- ============================================================
-- CLASS 11
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'Class 11 NCERT',
    'class-11-ncert',
    'Important NCERT textbooks and study books for Class 11.',
    3
FROM categories
WHERE slug = 'school-ncert-books'
ON CONFLICT (slug) DO NOTHING;

-- ============================================================
-- CLASS 12
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'Class 12 NCERT',
    'class-12-ncert',
    'Important NCERT textbooks and study books for Class 12.',
    4
FROM categories
WHERE slug = 'school-ncert-books'
ON CONFLICT (slug) DO NOTHING;

COMMIT;