BEGIN;

INSERT INTO categories
    (name, slug, description, sort_order)
VALUES
    (
        'Books',
        'books',
        'Academic, educational and general books for students.',
        1
    ),
    (
        'Famous Autobiography Books',
        'famous-autobiography-books',
        'Autobiographies and life stories of famous personalities.',
        2
    ),
    (
        'Indian Pride Books',
        'indian-pride-books',
        'Books celebrating Indian history, culture, personalities and achievements.',
        3
    ),
    (
        'Pen',
        'pen',
        'Pens and writing instruments for students.',
        4
    ),
    (
        'Notebook',
        'notebook',
        'Notebooks, writing pads and student notebooks.',
        5
    ),
    (
        'Water Bottle',
        'water-bottle',
        'Reusable water bottles for students and daily campus use.',
        6
    ),
    (
        'Geometry Box',
        'geometry-box',
        'Geometry and mathematical instrument boxes for students.',
        7
    ),
    (
        'Laptop',
        'laptop',
        'Laptops and computing devices for student use.',
        8
    ),
    (
        'Stationery',
        'stationery',
        'General stationery and academic supplies.',
        9
    ),
    (
        'Lab Equipments',
        'lab-equipments',
        'Laboratory equipment and educational laboratory supplies.',
        10
    )
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'Physics Lab',
    'physics-lab',
    'Equipment and instruments for physics laboratory work.',
    1
FROM categories
WHERE slug = 'lab-equipments'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'Biology Lab',
    'biology-lab',
    'Equipment and instruments for biology laboratory work.',
    2
FROM categories
WHERE slug = 'lab-equipments'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT
    id,
    'Chemistry Lab',
    'chemistry-lab',
    'Equipment and instruments for chemistry laboratory work.',
    3
FROM categories
WHERE slug = 'lab-equipments'
ON CONFLICT (slug) DO NOTHING;

COMMIT;