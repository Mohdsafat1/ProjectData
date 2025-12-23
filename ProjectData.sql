CREATE DATABASE names;
USE names;
CREATE TABLE Customers (
customer_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
phone VARCHAR(15),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE Products (
product_id INT AUTO_INCREMENT PRIMARY KEY,
product_name VARCHAR(150) NOT NULL,
price DECIMAL(10,2) NOT NULL,
stock INT NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE Orders (
order_id INT AUTO_INCREMENT PRIMARY KEY,
customer_id INT NOT NULL,
order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
status VARCHAR(30),
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);


CREATE TABLE Order_Items (
order_item_id INT AUTO_INCREMENT PRIMARY KEY,
order_id INT NOT NULL,
product_id INT NOT NULL,
quantity INT NOT NULL,
price DECIMAL(10,2) NOT NULL,
FOREIGN KEY (order_id) REFERENCES Orders(order_id),
FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


CREATE TABLE Payments (
payment_id INT AUTO_INCREMENT PRIMARY KEY,
order_id INT NOT NULL,
payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
amount DECIMAL(10,2) NOT NULL,
payment_method VARCHAR(50),
FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

INSERT INTO Customers (name, email, phone) VALUES
('Amit Sharma', 'amit@gmail.com', '9999999999'),
('Neha Verma', 'neha@gmail.com', '8888888888');


INSERT INTO Products (product_name, price, stock) VALUES
('Laptop', 55000.00, 10),
('Mouse', 500.00, 100);


INSERT INTO Orders (customer_id, status) VALUES
(1, 'Placed'),
(2, 'Shipped');


INSERT INTO Order_Items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 55000.00),
(1, 2, 2, 500.00);


INSERT INTO Payments (order_id, amount, payment_method) VALUES
(1, 56000.00, 'Credit Card');

SELECT o.order_id, c.name, SUM(oi.quantity * oi.price) AS total_amount
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, c.name;

SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.product_name;

CREATE VIEW Sales_Report AS
SELECT o.order_id, c.name, o.order_date,
SUM(oi.quantity * oi.price) AS total_amount
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, c.name, o.order_date;

SELECT * FROM Sales_Report;
SELECT * FROM Customers;
SELECT * FROM Products ;
SELECT * FROM Orders;
SELECT * FROM Payments;
