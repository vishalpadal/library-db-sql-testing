-- Library Management Database: Queries
USE library_db;

-- ========== A. JOINS ==========

-- 1. Which student issued which book (full details)
SELECT s.name, b.title, a.author_name, i.issue_date, i.due_date, i.return_date
FROM issue_records i
JOIN students s ON i.student_id = s.student_id
JOIN books b    ON i.book_id = b.book_id
JOIN authors a  ON b.author_id = a.author_id
ORDER BY i.issue_date;

-- 2. Books not yet returned. 
SELECT s.name, b.title, i.due_date
FROM issue_records i
JOIN students s ON i.student_id = s.student_id
JOIN books b    ON i.book_id = b.book_id
WHERE i.return_date IS NULL;

-- 3. All authors and their books. 
SELECT a.author_name, b.title
FROM authors a
LEFT JOIN books b ON a.author_id = b.author_id;


-- ========== B. AGGREGATE + GROUP BY ==========

-- 4. How many times each book was issued (most popular first)
SELECT b.title, COUNT(i.issue_id) AS times_issued
FROM books b
LEFT JOIN issue_records i ON b.book_id = i.book_id
GROUP BY b.book_id, b.title
ORDER BY times_issued DESC;

-- 5. Category wise total copies
SELECT category, SUM(total_copies) AS total_copies, COUNT(*) AS titles
FROM books
GROUP BY category;

-- 6. Students who issued 2 or more books
SELECT s.name, COUNT(i.issue_id) AS books_taken
FROM students s
LEFT JOIN issue_records i ON s.student_id = i.student_id
GROUP BY s.student_id, s.name
HAVING COUNT(i.issue_id) >= 2;

-- 7. Fine collected vs pending. 
SELECT paid, COUNT(*) AS records, SUM(amount) AS total_amount
FROM fines
GROUP BY paid;


-- ========== C. SUBQUERIES ==========

-- 8. Students who have not paid fine. 
SELECT name FROM students
WHERE student_id IN (
    SELECT i.student_id
    FROM issue_records i
    JOIN fines f ON i.issue_id = f.issue_id
    WHERE f.paid = FALSE
);

-- 9. Books with more copies than average
SELECT title, total_copies FROM books
WHERE total_copies > (SELECT AVG(total_copies) FROM books);

-- 10. Books that were never issued. 
SELECT title FROM books
WHERE book_id NOT IN (SELECT book_id FROM issue_records);


-- ========== D. VIEWS ==========

-- 11. Currently available copies
CREATE OR REPLACE VIEW v_book_availability AS
SELECT b.book_id, b.title, b.total_copies,
       b.total_copies - COUNT(i.issue_id) AS available_copies
FROM books b
LEFT JOIN issue_records i
       ON b.book_id = i.book_id AND i.return_date IS NULL
GROUP BY b.book_id, b.title, b.total_copies;

SELECT * FROM v_book_availability;

-- 12. Overdue report (fixed date used because data is from 2025).
CREATE OR REPLACE VIEW v_overdue_books AS
SELECT s.name, b.title, i.due_date,
       DATEDIFF('2025-10-20', i.due_date) AS days_overdue
FROM issue_records i
JOIN students s ON i.student_id = s.student_id
JOIN books b    ON i.book_id = b.book_id
WHERE i.return_date IS NULL
  AND i.due_date < '2025-10-20';

SELECT * FROM v_overdue_books;