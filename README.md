# Library Management Database + Data Validation Testing

A MySQL database for a library system, with a suite of **18 SQL-based test cases** that verify data integrity, business rules, and database constraints.

## Tech Stack
- MySQL 8.0
- MySQL Workbench
- Git / GitHub

## Database Design

5 tables with primary keys, foreign keys, and constraints:

| Table | Purpose |
|---|---|
| `students` | Library members (unique email, NOT NULL name) |
| `authors` | Book authors |
| `books` | Book catalogue (CHECK: total_copies >= 0) |
| `issue_records` | Which student issued which book, with due and return dates |
| `fines` | Late return fines (CHECK: amount >= 0) |

**Sample data:** 10 students, 8 authors, 15 books, 20 issue records, 5 fines.

## Project Structure

```
library-db-sql-testing/
├── 01_schema.sql              # Database and table creation
├── 02_sample_data.sql         # Sample data inserts
├── 03_queries.sql             # Joins, aggregates, subqueries, views
├── 04_validation_tests.sql    # 18 validation tests
├── 05_test_cases.xlsx         # Test case documentation (expected vs actual)
└── README.md
```

## How to Run

1. Open MySQL Workbench and connect to your local server.
2. Run the files in this order: `01` -> `02` -> `03` -> `04`.
3. In `04_validation_tests.sql`, run TC13 to TC18 **one by one** (they are designed to fail with an error).

## SQL Concepts Covered
- INNER JOIN and LEFT JOIN across 3-4 tables
- GROUP BY, HAVING, aggregate functions (COUNT, SUM, AVG)
- Subqueries (IN, NOT IN, scalar subquery)
- Views: `v_book_availability`, `v_overdue_books`

## Testing Approach

| Category | Test Cases | Pass Condition |
|---|---|---|
| Duplicate check | TC01 | Query returns 0 rows |
| NULL check | TC02 | Query returns 0 rows |
| Orphan records | TC03 - TC06 | Query returns 0 rows |
| Business rules | TC07 - TC09 | Query returns 0 rows |
| Fine calculation | TC10 - TC12 | Query returns 0 rows |
| Constraint (negative) tests | TC13 - TC18 | Database returns an error |

- **Validation tests (TC01 - TC12):** a SELECT query looks for bad data. Zero rows means the data is clean.
- **Negative tests (TC13 - TC18):** invalid data is inserted or deleted on purpose. The database must reject it with an error.
- Fine rule verified: Rs. 5 per late day, using `DATEDIFF`.

Full details (query, expected result, actual result, status) are in `05_test_cases.xlsx`.

## Results

| Total Tests | Passed | Failed |
|---|---|---|
| 18 | 18 | 0 |

After running all negative tests, row counts were re-checked (students 10, books 15, fines 5, issue_records 20), confirming that no invalid data entered the tables.

## Key Learnings
- Writing positive and negative test cases for a database
- Using LEFT JOIN to detect orphan records
- Verifying constraints: UNIQUE, NOT NULL, CHECK, FOREIGN KEY
- Documenting tests with expected vs actual results

## Author
**Vishal Govinda Padal**
GitHub: [github.com/vishalpadal](https://github.com/vishalpadal)

## Future Improvements
- Add a `CHECK (due_date > issue_date AND (return_date IS NULL OR return_date >= issue_date))` constraint, since the current schema does not enforce date logic at the database level (it is only checked by TC07 and TC08).
- Automate the test run with a script instead of running queries manually.
- Add triggers to calculate fines automatically.
