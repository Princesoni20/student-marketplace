-- ============================================================
-- STUDENT MARKETPLACE
-- VERIFIED BOOK COVER IMAGES
-- Batch 1
-- ============================================================

BEGIN;

-- ------------------------------------------------------------
-- UPSC - Indian Polity
-- Verified ISBN: 9789382249276
-- ------------------------------------------------------------

INSERT INTO product_images
    (product_id, image_url, alt_text, sort_order, is_primary)
SELECT
    p.id,
    'https://covers.openlibrary.org/b/isbn/9789382249276-L.jpg?default=false',
    p.name || ' - Book Cover',
    0,
    TRUE
FROM products p
WHERE p.sku = 'BOOK-UPSC-POL-001'
  AND NOT EXISTS (
      SELECT 1
      FROM product_images pi
      WHERE pi.product_id = p.id
        AND pi.is_primary = TRUE
  );


-- ------------------------------------------------------------
-- UPSC - A Brief History of Modern India
-- Verified ISBN: 9788179308622
-- ------------------------------------------------------------

INSERT INTO product_images
    (product_id, image_url, alt_text, sort_order, is_primary)
SELECT
    p.id,
    'https://covers.openlibrary.org/b/isbn/9788179308622-L.jpg?default=false',
    p.name || ' - Book Cover',
    0,
    TRUE
FROM products p
WHERE p.sku = 'BOOK-UPSC-HIS-001'
  AND NOT EXISTS (
      SELECT 1
      FROM product_images pi
      WHERE pi.product_id = p.id
        AND pi.is_primary = TRUE
  );


-- ------------------------------------------------------------
-- UPSC - Certificate Physical and Human Geography
-- Verified ISBN: 9780195628166
-- ------------------------------------------------------------

INSERT INTO product_images
    (product_id, image_url, alt_text, sort_order, is_primary)
SELECT
    p.id,
    'https://covers.openlibrary.org/b/isbn/9780195628166-L.jpg?default=false',
    p.name || ' - Book Cover',
    0,
    TRUE
FROM products p
WHERE p.sku = 'BOOK-UPSC-GEO-001'
  AND NOT EXISTS (
      SELECT 1
      FROM product_images pi
      WHERE pi.product_id = p.id
        AND pi.is_primary = TRUE
  );


-- ------------------------------------------------------------
-- UPSC - Indian Economy
-- Verified ISBN: 9789352606146
-- ------------------------------------------------------------

INSERT INTO product_images
    (product_id, image_url, alt_text, sort_order, is_primary)
SELECT
    p.id,
    'https://covers.openlibrary.org/b/isbn/9789352606146-L.jpg?default=false',
    p.name || ' - Book Cover',
    0,
    TRUE
FROM products p
WHERE p.sku = 'BOOK-UPSC-ECO-001'
  AND NOT EXISTS (
      SELECT 1
      FROM product_images pi
      WHERE pi.product_id = p.id
        AND pi.is_primary = TRUE
  );


-- ------------------------------------------------------------
-- UPSC - Indian Art and Culture
-- Verified ISBN: 9789353168193
-- ------------------------------------------------------------

INSERT INTO product_images
    (product_id, image_url, alt_text, sort_order, is_primary)
SELECT
    p.id,
    'https://covers.openlibrary.org/b/isbn/9789353168193-L.jpg?default=false',
    p.name || ' - Book Cover',
    0,
    TRUE
FROM products p
WHERE p.sku = 'BOOK-UPSC-ART-001'
  AND NOT EXISTS (
      SELECT 1
      FROM product_images pi
      WHERE pi.product_id = p.id
        AND pi.is_primary = TRUE
  );


-- ------------------------------------------------------------
-- UPSC - Lexicon for Ethics
-- Verified ISBN: 9788193922484
-- ------------------------------------------------------------

INSERT INTO product_images
    (product_id, image_url, alt_text, sort_order, is_primary)
SELECT
    p.id,
    'https://covers.openlibrary.org/b/isbn/9788193922484-L.jpg?default=false',
    p.name || ' - Book Cover',
    0,
    TRUE
FROM products p
WHERE p.sku = 'BOOK-UPSC-ETH-001'
  AND NOT EXISTS (
      SELECT 1
      FROM product_images pi
      WHERE pi.product_id = p.id
        AND pi.is_primary = TRUE
  );


-- ------------------------------------------------------------
-- JEE - Concepts of Physics
-- Verified ISBN: 9788177091878
-- ------------------------------------------------------------

INSERT INTO product_images
    (product_id, image_url, alt_text, sort_order, is_primary)
SELECT
    p.id,
    'https://covers.openlibrary.org/b/isbn/9788177091878-L.jpg?default=false',
    p.name || ' - Book Cover',
    0,
    TRUE
FROM products p
WHERE p.sku = 'BOOK-JEE-PHY-001'
  AND NOT EXISTS (
      SELECT 1
      FROM product_images pi
      WHERE pi.product_id = p.id
        AND pi.is_primary = TRUE
  );


-- ------------------------------------------------------------
-- NEET - Trueman's Elementary Biology
-- Verified ISBN: 9788187223597
-- ------------------------------------------------------------

INSERT INTO product_images
    (product_id, image_url, alt_text, sort_order, is_primary)
SELECT
    p.id,
    'https://covers.openlibrary.org/b/isbn/9788187223597-L.jpg?default=false',
    p.name || ' - Book Cover',
    0,
    TRUE
FROM products p
WHERE p.sku = 'BOOK-NEET-BIO-003'
  AND NOT EXISTS (
      SELECT 1
      FROM product_images pi
      WHERE pi.product_id = p.id
        AND pi.is_primary = TRUE
  );

COMMIT;