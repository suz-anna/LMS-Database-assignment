USE sampleDB;
-- Create Authors table

-- Insert sample data into Authors table
INSERT INTO Authors (name, dob)
VALUES 
    ('J.K. Rowling', '1965-07-31'),
    ('George Orwell', '1903-06-25'),
    ('J.R.R. Tolkien', '1892-01-03'),
    ('Harper Lee', '1926-04-28');

-- Insert sample data into Books table
INSERT INTO Books (title, isbn, publication_year)
VALUES 
    ('Harry Potter and the Sorcerer\'s Stone', '9780747532699', 1997),
    ('1984', '9780451524935', 1949),
    ('The Hobbit', '9780261103344', 1937),
    ('To Kill a Mockingbird', '9780061120084', 1960);

-- Insert sample data into Members table
INSERT INTO Members (name, email, phone_number)
VALUES 
    ('Alice Johnson', 'alice.johnson@example.com', '555-1234'),
    ('Bob Smith', 'bob.smith@example.com', '555-5678'),
    ('Charlie Brown', 'charlie.brown@example.com', '555-8765');

-- Insert sample data into BookAuthors table (Many-to-Many relationship)
INSERT INTO BookAuthors (book_id, author_id)
VALUES 
    (1, 1),  -- Harry Potter and the Sorcerer's Stone by J.K. Rowling
    (2, 2),  -- 1984 by George Orwell
    (3, 3),  -- The Hobbit by J.R.R. Tolkien
    (4, 4),  -- To Kill a Mockingbird by Harper Lee
    (1, 1),  -- Harry Potter and the Sorcerer's Stone by J.K. Rowling (again)
    (2, 2);  -- 1984 by George Orwell (again)

-- Insert sample data into Loans table
INSERT INTO Loans (member_id, book_id, loan_date, return_date)
VALUES
    (1, 1, '2025-01-01', '2025-02-01'),  -- Alice Johnson borrows Harry Potter
    (2, 2, '2025-01-10', '2025-02-10'),  -- Bob Smith borrows 1984
    (3, 3, '2025-01-15', '2025-02-15');  -- Charlie Brown borrows The Hobbit

SELECT m.name AS member_name, b.title AS book_title, l.loan_date, l.return_date
FROM Loans l
JOIN Members m ON l.member_id = m.member_id
JOIN Books b ON l.book_id = b.book_id
WHERE m.name = 'Alice Johnson';

SELECT b.title AS book_title, a.name AS author_name
FROM BookAuthors ba
JOIN Books b ON ba.book_id = b.book_id
JOIN Authors a ON ba.author_id = a.author_id
WHERE b.title = 'Harry Potter and the Sorcerer\'s Stone';

SELECT a.name AS author_name, b.title AS book_title
FROM BookAuthors ba
JOIN Books b ON ba.book_id = b.book_id
JOIN Authors a ON ba.author_id = a.author_id
WHERE a.name = 'J.K. Rowling';

SELECT m.name AS member_name, b.title AS book_title, l.loan_date, l.return_date
FROM Loans l
JOIN Members m ON l.member_id = m.member_id
JOIN Books b ON l.book_id = b.book_id
WHERE l.return_date < CURDATE();  -- Books with return date in the past

