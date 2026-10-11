-- Library Management Database: Validation Tests

USE library_db;

-- ========== A. DUPLICATE CHECK ==========

-- TC01: Duplicate email should not exist
SELECT email, COUNT(*)
FROM students
GROUP BY email
HAVING COUNT(*) > 1;

-- ========== B. NULL CHECK ==========

-- TC02: Student name or email should not be NULL
SELECT * FROM students
WHERE name IS NULL OR email IS NULL;

-- ========== C. ORPHAN RECORD CHECKS ==========

-- TC03: Every book must have a valid author
SELECT b.*
FROM books b
LEFT JOIN authors a ON b.author_id = a.author_id
WHERE a.author_id IS NULL;

-- TC04: Every issue record must have a valid student
SELECT i.*
FROM issue_records i
LEFT JOIN students s ON i.student_id = s.student_id
WHERE s.student_id IS NULL;

-- TC05: Every issue record must have a valid book
SELECT i.*
FROM issue_records i
LEFT JOIN books b ON i.book_id = b.book_id
WHERE b.book_id IS NULL;

-- TC06: Every fine must have a valid issue record
SELECT f.*
FROM fines f
LEFT JOIN issue_records i ON f.issue_id = i.issue_id
WHERE i.issue_id IS NULL;

-- ========== D. BUSINESS RULE CHECKS ==========

-- TC07: due_date must be after issue_date
SELECT * FROM issue_records
WHERE due_date <= issue_date;

-- TC08: return_date must not be before issue_date
SELECT * FROM issue_records
WHERE return_date IS NOT NULL AND return_date < issue_date;

-- TC09: Available copies must not be negative
SELECT * FROM v_book_availability
WHERE available_copies < 0;

-- TC10: Late return must have a fine
SELECT i.*
FROM issue_records i
LEFT JOIN fines f ON i.issue_id = f.issue_id
WHERE i.return_date > i.due_date AND f.fine_id IS NULL;

-- TC11: Fine amount must be 5 x late days
SELECT f.fine_id, f.amount, 5 * DATEDIFF(i.return_date, i.due_date) AS expected
FROM fines f
JOIN issue_records i ON f.issue_id = i.issue_id
WHERE f.amount <> 5 * DATEDIFF(i.return_date, i.due_date);

-- TC12: On-time or unreturned books must not have a fine
SELECT f.*
FROM fines f
JOIN issue_records i ON f.issue_id = i.issue_id
WHERE i.return_date <= i.due_date OR i.return_date IS NULL;

-- ========== E. CONSTRAINT TESTS  ==========

-- TC13: Duplicate email -> Error expected
INSERT INTO students (name, email) VALUES ('Test', 'rahul@gmail.com');

-- TC14: NULL name -> Error expected
INSERT INTO students (name, email) VALUES (NULL, 'new@gmail.com');

-- TC15: Negative copies -> Error expected (CHECK constraint)
INSERT INTO books (title, author_id, category, total_copies)
VALUES ('Bad Book', 1, 'Fiction', -5);

-- TC16: Invalid author_id -> Error expected (foreign key)
INSERT INTO books (title, author_id, category, total_copies)
VALUES ('Ghost Book', 999, 'Fiction', 2);

-- TC17: Negative fine -> Error expected (CHECK constraint)
INSERT INTO fines (issue_id, amount) VALUES (1, -10);

-- TC18: Delete student who has issue records -> Error expected (foreign key)
DELETE FROM students WHERE student_id = 1;

-- ========== F. FINAL DATA CHECK (data unchanged after all tests) ==========
SELECT COUNT(*) FROM students;        -- 10
SELECT COUNT(*) FROM books;           -- 15
SELECT COUNT(*) FROM fines;           -- 5
SELECT COUNT(*) FROM issue_records;   -- 20