-- ============================================================
-- Retail Store Database Project
-- Author: [Your Name]
-- Description: A MySQL-based retail store database project
-- demonstrating database creation, table design, relationships,
-- sample data insertion, and analytical queries.
-- ============================================================

-- 1️⃣ Create Database
CREATE DATABASE IF NOT EXISTS retail_store;
USE retail_store;

-- 2️⃣ Create Tables
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(200)
);

CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    city VARCHAR(50),
    state VARCHAR(50),
    registration_date DATE
);

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
    price DECIMAL(10,2),
    stock_quantity INT,
    supplier VARCHAR(100),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    status VARCHAR(20),
    shipping_address VARCHAR(200),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- 3️⃣ Insert Sample Data

-- Categories
INSERT INTO Categories (category_name, description) VALUES
('Electronics', 'Devices and gadgets'),
('Clothing', 'Apparel and accessories'),
('Books', 'Books and novels'),
('Home & Kitchen', 'Appliances and cookware'),
('Sports', 'Sports items'),
('Toys', 'Kids toys'),
('Beauty', 'Cosmetics and skincare'),
('Furniture', 'Home furniture'),
('Groceries', 'Daily food items'),
('Footwear', 'Shoes and sandals');

-- Customers
INSERT INTO Customers (first_name, last_name, email, phone, city, state, registration_date) VALUES
('Raj', 'Kumar', 'raj@email.com', '9876543210', 'Mumbai', 'Maharashtra', '2024-01-15'),
('Priya', 'Sharma', 'priya@email.com', '9876543211', 'Delhi', 'Delhi', '2024-02-20'),
('Amit', 'Patel', 'amit@email.com', '9876543212', 'Ahmedabad', 'Gujarat', '2024-03-10'),
('Sneha', 'Reddy', 'sneha@email.com', '9876543213', 'Hyderabad', 'Telangana', '2024-04-05'),
('Vikram', 'Singh', 'vikram@email.com', '9876543214', 'Bangalore', 'Karnataka', '2024-05-12'),
('Anita', 'Desai', 'anita@email.com', '9876543215', 'Pune', 'Maharashtra', '2024-06-18'),
('Rohit', 'Mehta', 'rohit@email.com', '9876543216', 'Chennai', 'Tamil Nadu', '2024-07-22'),
('Kavita', 'Joshi', 'kavita@email.com', '9876543217', 'Jaipur', 'Rajasthan', '2024-08-30'),
('Deepak', 'Verma', 'deepak@email.com', '9876543218', 'Lucknow', 'Uttar Pradesh', '2024-09-25'),
('Neha', 'Bose', 'neha@email.com', '9876543219', 'Kolkata', 'West Bengal', '2024-10-10');

-- Products
INSERT INTO Products (product_name, category_id, price, stock_quantity, supplier) VALUES
('iPhone 14', 1, 79900.00, 30, 'Apple'),
('Samsung TV 43"', 1, 45999.00, 20, 'Samsung'),
('Mens Shirt', 2, 1200.00, 100, 'Raymond'),
('Womens Dress', 2, 2000.00, 80, 'Fabindia'),
('The Alchemist', 3, 400.00, 200, 'HarperCollins'),
('Pressure Cooker', 4, 1800.00, 50, 'Prestige'),
('Cricket Bat', 5, 2500.00, 40, 'MRF'),
('Lego Toy Set', 6, 1500.00, 60, 'LEGO'),
('Face Cream', 7, 899.00, 70, 'Lakme'),
('Sofa Set', 8, 25000.00, 10, 'Godrej');

-- Orders
INSERT INTO Orders (customer_id, order_date, total_amount, status, shipping_address) VALUES
(1, '2024-09-01 10:30:00', 79900.00, 'Delivered', 'Mumbai, Maharashtra'),
(2, '2024-09-05 14:20:00', 4000.00, 'Delivered', 'Delhi, Delhi'),
(3, '2024-09-10 09:15:00', 48000.00, 'Shipped', 'Ahmedabad, Gujarat'),
(4, '2024-09-15 16:45:00', 2000.00, 'Delivered', 'Hyderabad, Telangana'),
(5, '2024-09-20 11:00:00', 2500.00, 'Pending', 'Bangalore, Karnataka'),
(6, '2024-10-01 13:30:00', 1800.00, 'Delivered', 'Pune, Maharashtra'),
(7, '2024-10-05 10:10:00', 1500.00, 'Shipped', 'Chennai, Tamil Nadu'),
(8, '2024-10-10 15:25:00', 899.00, 'Delivered', 'Jaipur, Rajasthan'),
(9, '2024-10-15 12:00:00', 25000.00, 'Delivered', 'Lucknow, Uttar Pradesh'),
(10, '2024-10-20 17:45:00', 799.00, 'Pending', 'Kolkata, West Bengal');

-- Order Details
INSERT INTO Order_Details (order_id, product_id, quantity, unit_price, subtotal) VALUES
(1, 1, 1, 79900.00, 79900.00),
(2, 3, 2, 1200.00, 2400.00),
(2, 5, 4, 400.00, 1600.00),
(3, 2, 1, 45999.00, 45999.00),
(3, 9, 2, 899.00, 1798.00),
(4, 4, 1, 2000.00, 2000.00),
(5, 7, 1, 2500.00, 2500.00),
(6, 6, 1, 1800.00, 1800.00),
(7, 8, 1, 1500.00, 1500.00),
(9, 10, 1, 25000.00, 25000.00);

-- 4️⃣ Queries

-- Show all products with their categories
SELECT p.product_name, c.category_name, p.price, p.stock_quantity
FROM Products p
JOIN Categories c ON p.category_id = c.category_id;

-- Orders with customer details
SELECT o.order_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       o.total_amount, o.status, o.order_date
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id;

-- Top-selling products
SELECT p.product_name, SUM(od.quantity) AS total_sold
FROM Products p
JOIN Order_Details od ON p.product_id = od.product_id
GROUP BY p.product_id
ORDER BY total_sold DESC;

-- Total revenue by category
SELECT c.category_name, SUM(od.subtotal) AS total_revenue
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
JOIN Order_Details od ON p.product_id = od.product_id
GROUP BY c.category_name;

-- Update stock after a sale
UPDATE Products SET stock_quantity = stock_quantity - 1 WHERE product_id = 1;

-- Delete cancelled orders
DELETE FROM Orders WHERE status = 'Cancelled';
