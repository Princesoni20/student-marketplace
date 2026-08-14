-- ============================================================
-- STUDENT MARKETPLACE
-- Book Category Hierarchy
-- ============================================================

BEGIN;

-- ============================================================
-- ACADEMIC / ENGINEERING
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'Academic / Engineering Books',
    'academic-engineering-books',
    'Academic and engineering textbooks for university students.',
    1
FROM categories
WHERE slug = 'books'
ON CONFLICT (slug) DO NOTHING;

-- ============================================================
-- COMPETITIVE EXAMS
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'Competitive Exam Books',
    'competitive-exam-books',
    'Preparation books for competitive and government examinations.',
    2
FROM categories
WHERE slug = 'books'
ON CONFLICT (slug) DO NOTHING;

-- ============================================================
-- UPSC
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'UPSC Preparation Books',
    'upsc-preparation-books',
    'Books and study material for UPSC Civil Services preparation.',
    3
FROM categories
WHERE slug = 'books'
ON CONFLICT (slug) DO NOTHING;

-- ============================================================
-- IIT JEE
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'IIT JEE Preparation',
    'iit-jee-preparation',
    'Preparation books and study material for JEE Main and JEE Advanced.',
    4
FROM categories
WHERE slug = 'books'
ON CONFLICT (slug) DO NOTHING;

-- ============================================================
-- NEET
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'NEET Preparation',
    'neet-preparation',
    'Preparation books and study material for NEET medical entrance examination.',
    5
FROM categories
WHERE slug = 'books'
ON CONFLICT (slug) DO NOTHING;

-- ============================================================
-- PLACEMENT
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'Placement Preparation',
    'placement-preparation',
    'Books for aptitude, coding, technical interviews and campus placements.',
    6
FROM categories
WHERE slug = 'books'
ON CONFLICT (slug) DO NOTHING;

-- ============================================================
-- PROGRAMMING & TECHNOLOGY
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'Programming & Technology',
    'programming-technology',
    'Programming, software development, AI, cloud and technology books.',
    7
FROM categories
WHERE slug = 'books'
ON CONFLICT (slug) DO NOTHING;

-- ============================================================
-- STARTUP & ENTREPRENEURSHIP
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'Startup & Entrepreneurship',
    'startup-entrepreneurship',
    'Books about startups, entrepreneurship, business and innovation.',
    8
FROM categories
WHERE slug = 'books'
ON CONFLICT (slug) DO NOTHING;

-- ============================================================
-- SKILLS DEVELOPMENT
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'Skills Development',
    'skills-development',
    'Books for communication, leadership, productivity and personal development.',
    9
FROM categories
WHERE slug = 'books'
ON CONFLICT (slug) DO NOTHING;

-- ============================================================
-- GENERAL STUDY
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'General Study Books',
    'general-study-books',
    'General educational and study books for students.',
    10
FROM categories
WHERE slug = 'books'
ON CONFLICT (slug) DO NOTHING;

-- ============================================================
-- COMPETITIVE EXAM SUBCATEGORIES
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'SSC', 'ssc', 1
FROM categories
WHERE slug = 'competitive-exam-books'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'Banking', 'banking-exams', 2
FROM categories
WHERE slug = 'competitive-exam-books'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'Railway', 'railway-exams', 3
FROM categories
WHERE slug = 'competitive-exam-books'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'CAT', 'cat-exam', 4
FROM categories
WHERE slug = 'competitive-exam-books'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'Other Government Exams', 'other-government-exams', 5
FROM categories
WHERE slug = 'competitive-exam-books'
ON CONFLICT (slug) DO NOTHING;

-- ============================================================
-- UPSC SUBCATEGORIES
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'NCERT', 'upsc-ncert', 1
FROM categories
WHERE slug = 'upsc-preparation-books'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'Indian Polity', 'upsc-indian-polity', 2
FROM categories
WHERE slug = 'upsc-preparation-books'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'Indian History', 'upsc-indian-history', 3
FROM categories
WHERE slug = 'upsc-preparation-books'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'Geography', 'upsc-geography', 4
FROM categories
WHERE slug = 'upsc-preparation-books'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'Indian Economy', 'upsc-indian-economy', 5
FROM categories
WHERE slug = 'upsc-preparation-books'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'Environment & Ecology', 'upsc-environment-ecology', 6
FROM categories
WHERE slug = 'upsc-preparation-books'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'Science & Technology', 'upsc-science-technology', 7
FROM categories
WHERE slug = 'upsc-preparation-books'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'Art & Culture', 'upsc-art-culture', 8
FROM categories
WHERE slug = 'upsc-preparation-books'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'Ethics', 'upsc-ethics', 9
FROM categories
WHERE slug = 'upsc-preparation-books'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'Current Affairs', 'upsc-current-affairs', 10
FROM categories
WHERE slug = 'upsc-preparation-books'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'CSAT', 'upsc-csat', 11
FROM categories
WHERE slug = 'upsc-preparation-books'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'Previous Year Papers', 'upsc-previous-year-papers', 12
FROM categories
WHERE slug = 'upsc-preparation-books'
ON CONFLICT (slug) DO NOTHING;

-- ============================================================
-- IIT JEE SUBCATEGORIES
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'Physics', 'jee-physics', 1
FROM categories
WHERE slug = 'iit-jee-preparation'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'Chemistry', 'jee-chemistry', 2
FROM categories
WHERE slug = 'iit-jee-preparation'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'Mathematics', 'jee-mathematics', 3
FROM categories
WHERE slug = 'iit-jee-preparation'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'JEE Main', 'jee-main', 4
FROM categories
WHERE slug = 'iit-jee-preparation'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'JEE Advanced', 'jee-advanced', 5
FROM categories
WHERE slug = 'iit-jee-preparation'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'Previous Year Papers', 'jee-previous-year-papers', 6
FROM categories
WHERE slug = 'iit-jee-preparation'
ON CONFLICT (slug) DO NOTHING;

-- ============================================================
-- NEET SUBCATEGORIES
-- ============================================================

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'Physics', 'neet-physics', 1
FROM categories
WHERE slug = 'neet-preparation'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'Chemistry', 'neet-chemistry', 2
FROM categories
WHERE slug = 'neet-preparation'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'Biology', 'neet-biology', 3
FROM categories
WHERE slug = 'neet-preparation'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'NEET Preparation', 'neet-complete-preparation', 4
FROM categories
WHERE slug = 'neet-preparation'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories
    (parent_id, name, slug, sort_order)
SELECT id, 'Previous Year Papers', 'neet-previous-year-papers', 5
FROM categories
WHERE slug = 'neet-preparation'
ON CONFLICT (slug) DO NOTHING;

-- ============================================================
-- COMMIT
-- ============================================================

COMMIT;