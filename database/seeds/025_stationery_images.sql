-- ============================================================
-- STUDENT MARKETPLACE
-- STATIONERY PRODUCT IMAGES
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

    -- ASSIGNMENT PAGES
    ('STAT-ASSIGN-001',
     'https://placehold.co/800x600/png?text=A4+Assignment+Sheets',
     'A4 Assignment Sheets'),

    ('STAT-ASSIGN-002',
     'https://placehold.co/800x600/png?text=Assignment+Paper+Pack',
     'Assignment Paper Pack 100 Sheets'),

    ('STAT-ASSIGN-003',
     'https://placehold.co/800x600/png?text=College+Assignment+File+Sheets',
     'College Assignment File Sheets'),

    -- BINDER CLIPS
    ('STAT-BINDER-002',
     'https://placehold.co/800x600/png?text=Kangaro+Binder+Clips+Medium',
     'Kangaro Binder Clips Medium'),

    ('STAT-BINDER-001',
     'https://placehold.co/800x600/png?text=Kangaro+Binder+Clips+Small',
     'Kangaro Binder Clips Small'),

    -- CHART PAPER
    ('STAT-CHART-002',
     'https://placehold.co/800x600/png?text=Colored+Chart+Paper+Pack',
     'Colored Chart Paper Pack'),

    ('STAT-CHART-003',
     'https://placehold.co/800x600/png?text=Project+Chart+Paper+Set',
     'Project Chart Paper Set'),

    ('STAT-CHART-001',
     'https://placehold.co/800x600/png?text=White+Chart+Paper+Pack',
     'White Chart Paper Pack'),

    -- COLORED PAPER
    ('STAT-PAPER-002',
     'https://placehold.co/800x600/png?text=A4+Colored+Paper+Pack',
     'A4 Colored Paper Pack'),

    ('STAT-PAPER-001',
     'https://placehold.co/800x600/png?text=Colored+Craft+Paper+Pack',
     'Colored Craft Paper Pack'),

    ('STAT-PAPER-003',
     'https://placehold.co/800x600/png?text=Origami+Colored+Paper',
     'Origami Colored Paper'),

    -- COLORED PENCILS
    ('STAT-COLORPENCIL-002',
     'https://placehold.co/800x600/png?text=Camlin+Colour+Pencils',
     'Camlin Colour Pencils'),

    ('STAT-COLORPENCIL-003',
     'https://placehold.co/800x600/png?text=Classmate+Colour+Pencils',
     'Classmate Colour Pencils'),

    ('STAT-COLORPENCIL-001',
     'https://placehold.co/800x600/png?text=Faber-Castell+Colour+Pencils',
     'Faber-Castell Colour Pencils'),

    -- CORRECTION PEN
    ('STAT-CORRECT-001',
     'https://placehold.co/800x600/png?text=Camlin+Correction+Pen',
     'Camlin Correction Pen'),

    ('STAT-CORRECT-002',
     'https://placehold.co/800x600/png?text=Faber-Castell+Correction+Pen',
     'Faber-Castell Correction Pen'),

    -- DOUBLE SIDED TAPE
    ('STAT-DSTAPE-002',
     'https://placehold.co/800x600/png?text=Cello+Double+Sided+Tape',
     'Cello Double Sided Tape'),

    ('STAT-DSTAPE-001',
     'https://placehold.co/800x600/png?text=Scotch+Double+Sided+Tape',
     'Scotch Double Sided Tape'),

    -- FILES / FOLDERS
    ('STAT-FILE-001',
     'https://placehold.co/800x600/png?text=Classmate+Document+Folder',
     'Classmate Document Folder'),

    ('STAT-FILE-002',
     'https://placehold.co/800x600/png?text=Kangaro+Plastic+File',
     'Kangaro Plastic File'),

    ('STAT-FILE-003',
     'https://placehold.co/800x600/png?text=Solo+Display+File',
     'Solo Display File'),

    -- GLUE / GUM
    ('STAT-GLUE-003',
     'https://placehold.co/800x600/png?text=Camlin+Glue+Stick',
     'Camlin Glue Stick'),

    ('STAT-GLUE-001',
     'https://placehold.co/800x600/png?text=Fevicol+MR+Glue',
     'Fevicol MR Glue'),

    ('STAT-GLUE-002',
     'https://placehold.co/800x600/png?text=Fevistik+Glue+Stick',
     'Fevistik Glue Stick'),

    -- PAINTING COLORS
    ('STAT-COLOR-004',
     'https://placehold.co/800x600/png?text=Camel+Acrylic+Colours+Set',
     'Camel Acrylic Colours Set'),

    ('STAT-COLOR-002',
     'https://placehold.co/800x600/png?text=Camel+Water+Colour+Cakes',
     'Camel Water Colour Cakes'),

    ('STAT-COLOR-001',
     'https://placehold.co/800x600/png?text=Camlin+Poster+Colours+Set',
     'Camlin Poster Colours Set'),

    ('STAT-COLOR-003',
     'https://placehold.co/800x600/png?text=Faber-Castell+Water+Colours',
     'Faber-Castell Water Colours'),

    -- PAPER CLIPS
    ('STAT-CLIP-001',
     'https://placehold.co/800x600/png?text=Kangaro+Paper+Clips',
     'Kangaro Paper Clips'),

    ('STAT-CLIP-002',
     'https://placehold.co/800x600/png?text=Paper+Clip+Assorted+Pack',
     'Paper Clip Assorted Pack'),

    -- PAPER CUTTER
    ('STAT-CUTTER-002',
     'https://placehold.co/800x600/png?text=Kangaro+Paper+Cutter',
     'Kangaro Paper Cutter'),

    ('STAT-CUTTER-001',
     'https://placehold.co/800x600/png?text=Maped+Paper+Cutter',
     'Maped Paper Cutter'),

    -- PRACTICAL FILE
    ('STAT-PFILE-001',
     'https://placehold.co/800x600/png?text=Classmate+Practical+File',
     'Classmate Practical File'),

    ('STAT-PFILE-002',
     'https://placehold.co/800x600/png?text=Kangaro+Practical+File',
     'Kangaro Practical File'),

    ('STAT-PFILE-003',
     'https://placehold.co/800x600/png?text=Project+and+Practical+File',
     'Project and Practical File'),

    -- PRACTICAL PAGES
    ('STAT-PRACTICAL-003',
     'https://placehold.co/800x600/png?text=Biology+Practical+Pages',
     'Biology Practical Pages'),

    ('STAT-PRACTICAL-002',
     'https://placehold.co/800x600/png?text=Chemistry+Practical+Pages',
     'Chemistry Practical Pages'),

    ('STAT-PRACTICAL-001',
     'https://placehold.co/800x600/png?text=Physics+Practical+Pages',
     'Physics Practical Pages'),

    -- SCISSORS
    ('STAT-SCISSOR-001',
     'https://placehold.co/800x600/png?text=Camlin+Student+Scissors',
     'Camlin Student Scissors'),

    ('STAT-SCISSOR-002',
     'https://placehold.co/800x600/png?text=Faber-Castell+Student+Scissors',
     'Faber-Castell Student Scissors'),

    -- SELLOTAPE
    ('STAT-TAPE-001',
     'https://placehold.co/800x600/png?text=Cello+Transparent+Tape',
     'Cello Transparent Tape'),

    ('STAT-TAPE-002',
     'https://placehold.co/800x600/png?text=Scotch+Transparent+Tape',
     'Scotch Transparent Tape'),

    -- SKETCH PENS
    ('STAT-SKETCH-001',
     'https://placehold.co/800x600/png?text=Camlin+Sketch+Pens',
     'Camlin Sketch Pens Set'),

    ('STAT-SKETCH-003',
     'https://placehold.co/800x600/png?text=Classmate+Sketch+Pens',
     'Classmate Sketch Pens'),

    ('STAT-SKETCH-002',
     'https://placehold.co/800x600/png?text=Faber-Castell+Sketch+Pens',
     'Faber-Castell Sketch Pens'),

    -- STAPLER
    ('STAT-STAPLER-002',
     'https://placehold.co/800x600/png?text=Kangaro+HD-10+Stapler',
     'Kangaro HD-10 Stapler'),

    ('STAT-STAPLER-001',
     'https://placehold.co/800x600/png?text=Kangaro+Mini+Stapler',
     'Kangaro Mini Stapler'),

    -- STAPLES
    ('STAT-STAPLES-002',
     'https://placehold.co/800x600/png?text=Kangaro+24+6+Staples',
     'Kangaro 24/6 Staples'),

    ('STAT-STAPLES-001',
     'https://placehold.co/800x600/png?text=Kangaro+Staples+No+10',
     'Kangaro Staples No. 10'),

    -- STICKY NOTES
    ('STAT-STICKY-002',
     'https://placehold.co/800x600/png?text=Classmate+Sticky+Notes',
     'Classmate Sticky Notes'),

    ('STAT-STICKY-001',
     'https://placehold.co/800x600/png?text=Post-it+Notes+3x3',
     'Post-it Notes 3 x 3')

) AS v(sku, image_url, alt_text)
ON p.sku = v.sku
WHERE NOT EXISTS (
    SELECT 1
    FROM product_images pi
    WHERE pi.product_id = p.id
);

COMMIT;