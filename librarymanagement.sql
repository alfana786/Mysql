-- Create Database
CREATE DATABASE IF NOT EXISTS library_management;
USE library_management;

-- 1️⃣ Create Tables

CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(200)
);

CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    city VARCHAR(50),
    state VARCHAR(50),
    join_date DATE
);

CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(100),
    category_id INT,
    price DECIMAL(10,2),
    stock_quantity INT,
    publisher VARCHAR(100),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Issued_Books (
    issue_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    book_id INT,
    issue_date DATE,
    due_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

CREATE TABLE Book_Returns (
    return_id INT AUTO_INCREMENT PRIMARY KEY,
    issue_id INT,
    return_date DATE,
    fine_amount DECIMAL(10,2),
    FOREIGN KEY (issue_id) REFERENCES Issued_Books(issue_id)
);

-- 2️⃣ Insert Sample Data

INSERT INTO Categories (category_name, description) VALUES
('Fiction', 'Novels and stories'),
('Science', 'Scientific research and journals'),
('Technology', 'Programming and IT'),
('History', 'Historical records and books'),
('Children', 'Books for children'),
('Comics', 'Graphic novels and comics'),
('Philosophy', 'Thought and philosophy'),
('Biography', 'Life stories of people'),
('Education', 'Textbooks and guides'),
('Art', 'Books on painting and design');

INSERT INTO Members (first_name, last_name, email, phone, city, state, join_date) VALUES
('Amit', 'Sharma', 'amit@email.com', '9876512340', 'Delhi', 'Delhi', '2024-01-12'),
('Priya', 'Verma', 'priya@email.com', '9876512341', 'Mumbai', 'Maharashtra', '2024-02-14'),
('Ravi', 'Kumar', 'ravi@email.com', '9876512342', 'Pune', 'Maharashtra', '2024-03-05'),
('Sneha', 'Patel', 'sneha@email.com', '9876512343', 'Ahmedabad', 'Gujarat', '2024-04-18'),
('Vikas', 'Reddy', 'vikas@email.com', '9876512344', 'Hyderabad', 'Telangana', '2024-05-10'),
('Neha', 'Joshi', 'neha@email.com', '9876512345', 'Bangalore', 'Karnataka', '2024-06-12'),
('Rohit', 'Singh', 'rohit@email.com', '9876512346', 'Lucknow', 'Uttar Pradesh', '2024-07-01'),
('Kavita', 'Bose', 'kavita@email.com', '9876512347', 'Kolkata', 'West Bengal', '2024-08-20'),
('Deepak', 'Mehta', 'deepak@email.com', '9876512348', 'Chennai', 'Tamil Nadu', '2024-09-22'),
('Anita', 'Desai', 'anita@email.com', '9876512349', 'Jaipur', 'Rajasthan', '2024-10-05');

INSERT INTO Books (title, author, category_id, price, stock_quantity, publisher) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 1, 499.00, 20, 'Penguin'),
('Brief History of Time', 'Stephen Hawking', 2, 699.00, 15, 'Bantam'),
('Learning Python', 'Mark Lutz', 3, 1299.00, 10, 'O’Reilly'),
('World War II', 'John Keegan', 4, 850.00, 8, 'Oxford'),
('Harry Potter', 'J.K. Rowling', 5, 999.00, 25, 'Bloomsbury'),
('Batman: Year One', 'Frank Miller', 6, 499.00, 12, 'DC Comics'),
('Meditations', 'Marcus Aurelius', 7, 450.00, 30, 'Modern Library'),
('Steve Jobs', 'Walter Isaacson', 8, 899.00, 18, 'Simon & Schuster'),
('Mathematics Class 12', 'NCERT', 9, 350.00, 50, 'NCERT'),
('Art of Painting', 'Leonardo Vinci', 10, 999.00, 5, 'ArtHouse');

INSERT INTO Issued_Books (member_id, book_id, issue_date, due_date, status) VALUES
(1, 1, '2024-09-01', '2024-09-15', 'Returned'),
(2, 3, '2024-09-05', '2024-09-20', 'Issued'),
(3, 5, '2024-09-10', '2024-09-25', 'Returned'),
(4, 2, '2024-09-12', '2024-09-27', 'Issued'),
(5, 4, '2024-09-15', '2024-09-30', 'Returned'),
(6, 7, '2024-09-20', '2024-10-05', 'Issued'),
(7, 9, '2024-09-22', '2024-10-07', 'Returned'),
(8, 8, '2024-09-25', '2024-10-10', 'Issued'),
(9, 10, '2024-09-28', '2024-10-13', 'Returned'),
(10, 6, '2024-09-30', '2024-10-15', 'Issued');

INSERT INTO Book_Returns (issue_id, return_date, fine_amount) VALUES
(1, '2024-09-14', 0.00),
(3, '2024-09-24', 0.00),
(5, '2024-09-29', 0.00),
(7, '2024-10-05', 20.00),
(9, '2024-10-12', 0.00);

-- 3️⃣ Queries

-- Show all books with category
SELECT b.title, b.author, c.category_name, b.price, b.stock_quantity
FROM Books b
JOIN Categories c ON b.category_id = c.category_id;

-- Members with books they issued
SELECT m.first_name, m.last_name, b.title, ib.issue_date, ib.status
FROM Issued_Books ib
JOIN Members m ON ib.member_id = m.member_id
JOIN Books b ON ib.book_id = b.book_id;

-- Total books issued per category
SELECT c.category_name, COUNT(ib.issue_id) AS total_issued
FROM Categories c
JOIN Books b ON c.category_id = b.category_id
JOIN Issued_Books ib ON b.book_id = ib.book_id
GROUP BY c.category_name;

-- Members with overdue books
SELECT m.first_name, m.last_name, ib.due_date
FROM Issued_Books ib
JOIN Members m ON ib.member_id = m.member_id
WHERE ib.due_date < CURDATE() AND ib.status = 'Issued';

-- Update and Delete
-- Update stock after a book is issued
UPDATE Books SET stock_quantity = stock_quantity - 1 WHERE book_id = 3;

-- Delete records for returned books older than 1 year
DELETE FROM Issued_Books WHERE status = 'Returned' AND issue_date < '2023-10-01';
