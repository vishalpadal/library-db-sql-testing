-- Library Management Database: Sample Data
USE library_db;

-- Students (10)
INSERT INTO students (name, email, phone, joined_date) VALUES
('Rahul Patil', 'rahul@gmail.com', '9876543210', '2025-06-10'),
('Sneha Kulkarni', 'sneha@gmail.com', '9876543211', '2025-06-12'),
('Amit Deshmukh', 'amit@gmail.com', '9876543212', '2025-07-01'),
('Pooja Jadhav', 'pooja@gmail.com', '9876543213', '2025-07-05'),
('Rohan Shinde', 'rohan@gmail.com', '9876543214', '2025-07-15'),
('Neha Pawar', 'neha@gmail.com', '9876543215', '2025-08-01'),
('Vikas More', 'vikas@gmail.com', '9876543216', '2025-08-10'),
('Priya Joshi', 'priya@gmail.com', '9876543217', '2025-08-20'),
('Saurabh Gaikwad', 'saurabh@gmail.com', '9876543218', '2025-09-01'),
('Komal Sawant', 'komal@gmail.com', '9876543219', '2025-09-05');

-- Authors (8)
INSERT INTO authors (author_name) VALUES
('Chetan Bhagat'),
('R.K. Narayan'),
('APJ Abdul Kalam'),
('Yashwant Kanetkar'),
('Dennis Ritchie'),
('Ruskin Bond'),
('Sudha Murty'),
('Robert Kiyosaki');

-- Books (15)
INSERT INTO books (title, author_id, category, total_copies) VALUES
('Five Point Someone', 1, 'Fiction', 5),
('2 States', 1, 'Fiction', 4),
('Malgudi Days', 2, 'Fiction', 3),
('The Guide', 2, 'Fiction', 2),
('Wings of Fire', 3, 'Biography', 6),
('India 2020', 3, 'Non-Fiction', 2),
('Let Us C', 4, 'Programming', 8),
('Understanding Pointers in C', 4, 'Programming', 4),
('The C Programming Language', 5, 'Programming', 3),
('The Blue Umbrella', 6, 'Fiction', 3),
('Rusty Stories', 6, 'Fiction', 2),
('Wise and Otherwise', 7, 'Non-Fiction', 4),
('Three Thousand Stitches', 7, 'Non-Fiction', 3),
('Rich Dad Poor Dad', 8, 'Finance', 5),
('Cashflow Quadrant', 8, 'Finance', 2);

-- Issue Records (20)
INSERT INTO issue_records (student_id, book_id, issue_date, due_date, return_date) VALUES
(1, 7, '2025-09-01', '2025-09-15', '2025-09-14'),
(1, 5, '2025-09-20', '2025-10-04', '2025-10-10'),
(2, 1, '2025-09-02', '2025-09-16', '2025-09-16'),
(2, 14, '2025-09-18', '2025-10-02', NULL),
(3, 9, '2025-09-05', '2025-09-19', '2025-09-25'),
(3, 7, '2025-10-01', '2025-10-15', '2025-10-12'),
(4, 3, '2025-09-07', '2025-09-21', '2025-09-20'),
(4, 12, '2025-10-02', '2025-10-16', NULL),
(5, 8, '2025-09-10', '2025-09-24', '2025-10-01'),
(5, 2, '2025-10-03', '2025-10-17', '2025-10-16'),
(6, 5, '2025-09-12', '2025-09-26', '2025-09-26'),
(6, 10, '2025-10-05', '2025-10-19', NULL),
(7, 14, '2025-09-15', '2025-09-29', '2025-10-05'),
(7, 15, '2025-10-06', '2025-10-20', NULL),
(8, 13, '2025-09-17', '2025-10-01', '2025-09-30'),
(8, 4, '2025-10-07', '2025-10-21', NULL),
(9, 7, '2025-09-22', '2025-10-06', '2025-10-06'),
(9, 6, '2025-10-08', '2025-10-22', NULL),
(10, 11, '2025-09-25', '2025-10-09', '2025-10-15'),
(10, 1, '2025-10-10', '2025-10-24', NULL);

-- Fines (5 late returns, Rs. 5 per day)
INSERT INTO fines (issue_id, amount, paid) VALUES
(2, 30.00, TRUE),
(5, 30.00, TRUE),
(9, 35.00, FALSE),
(13, 30.00, FALSE),
(19, 30.00, TRUE);

-- Verify row counts
SELECT COUNT(*) AS authors_count FROM authors;              
SELECT COUNT(*) AS students_count FROM students;            
SELECT COUNT(*) AS books_count FROM books;                  
SELECT COUNT(*) AS issue_records_count FROM issue_records;  
SELECT COUNT(*) AS fines_count FROM fines;                  