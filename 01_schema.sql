-- Library Management Database: Schema
DROP DATABASE IF EXISTS library_db;
CREATE DATABASE library_db;
USE library_db;

CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    joined_date DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    author_name VARCHAR(100) NOT NULL
);

CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    author_id INT,
    category VARCHAR(50),
    total_copies INT CHECK (total_copies >= 0),
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

CREATE TABLE issue_records (
    issue_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    book_id INT NOT NULL,
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

CREATE TABLE fines (
    fine_id INT PRIMARY KEY AUTO_INCREMENT,
    issue_id INT NOT NULL,
    amount DECIMAL(8,2) CHECK (amount >= 0),
    paid BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (issue_id) REFERENCES issue_records(issue_id)
);