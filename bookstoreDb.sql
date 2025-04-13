CREATE DATABASE BookstoreDB;
USE BookstoreDB;
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL
);
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    phone VARCHAR(20)
);
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(150),
    contact_email VARCHAR(150)
);
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(100) NOT NULL
);
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    price DECIMAL(10,2) NOT NULL,
    publish_date DATE,
    language_id INT,
    publisher_id INT,
    FOREIGN KEY (language_id) REFERENCES book_language(language_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);
CREATE TABLE shipping_method (
    method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100),
    cost DECIMAL(10,2)
);
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50)
);
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    shipping_method_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id)
);
CREATE TABLE order_line (
    order_id INT,
    book_id INT,
    quantity INT,
    line_total DECIMAL(10,2),
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    status_date DATETIME,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);


-- Create a read-only user
CREATE USER 'readonly_user'@'localhost' IDENTIFIED BY 'password123';
GRANT SELECT ON BookStoreDB.* TO 'readonly_user'@'localhost';

-- Create an admin user
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'adminpass456';
GRANT ALL PRIVILEGES ON BookStoreDB.* TO 'admin_user'@'localhost';

-- COUNTRY
INSERT INTO country (country_name) VALUES ('Kenya'), ('USA'), ('UK'), ('Nigeria');

-- ADDRESS
INSERT INTO address (street, city, state, postal_code, country_id)
VALUES ('123 River Rd', 'Nairobi', 'Nairobi', '00100', 1),
('123 Koinange St', 'Nairobi', 'Nairobi County', '00100', 1),
('456 Oxford Street', 'London', 'England', 'W1D 1BS', 3),
('789 Fifth Ave', 'New York', 'NY', '10022', 2);

-- ADDRESS_STATUS
INSERT INTO address_status (status_name) VALUES ('Current'), ('Old');

-- CUSTOMER
INSERT INTO customer (first_name, last_name, email, phone)
VALUES ('John', 'Doe', 'john@example.com', '0712345678'),
('Wanjiku', 'Mugo', 'wanjiku@example.com', '+254722345699'),
('James', 'Smith', 'james@example.com', '+1-555-1234'),
('Amina', 'Mohammed', 'amina@example.com', '+2348034567890');

-- CUSTOMER_ADDRESS
INSERT INTO customer_address (customer_id, address_id, status_id)
VALUES (1, 1, 1), (1, 4, 1), (2, 3, 1), (3, 2, 3);

-- PUBLISHER
INSERT INTO publisher (publisher_name, contact_email)
VALUES ('Oxford Press', 'contact@oxford.com'),
('East African Publishers', 'info@eap.co.ke'),
('Penguin Random House', 'contact@penguin.com'),
('Macmillan', 'support@macmillan.com');

-- BOOK_LANGUAGE
INSERT INTO book_language (language_name) VALUES ('English'), ('Swahili'), ('Yoruba');

-- AUTHOR
INSERT INTO author (first_name, last_name)
VALUES ('Chinua', 'Achebe'), ('Ngũgĩ wa', 'Thiong''o'),
('Chimamanda', 'Adichie'),
('J.K.', 'Rowling');

-- BOOK
INSERT INTO book (title, isbn, price, publish_date, language_id, publisher_id)
VALUES ('Things Fall Apart', '9780435913502', 15.99, '1958-06-17', 1, 1),
('Petals of Blood', '9780435905484', 24.99, '1977-01-01', 1, 1),
('Half of a Yellow Sun', '9780007200283', 19.99, '2006-01-01', 1, 2),
('Harry Potter and the Philosopher''s Stone', '9780747532743', 29.99, '1997-06-26', 1, 3);

-- BOOK_AUTHOR
INSERT INTO book_author (book_id, author_id) VALUES (1, 1), (1, 7), (2, 2), (3, 3);

-- SHIPPING_METHOD
INSERT INTO shipping_method (method_name, cost)
VALUES ('Standard Shipping', 5.00),
('Express Shipping', 12.00),
('International Shipping', 25.00);

-- ORDER_STATUS
INSERT INTO order_status (status_name)
VALUES ('Pending'), ('Processing'), ('Shipped'), ('Delivered'), ('Cancelled');

-- CUST_ORDER
INSERT INTO cust_order (customer_id, order_date, total_amount, shipping_method_id)
VALUES (1, '2025-01-15', 15.99, 1);
(1, '2025-01-25', 24.99, 1),
(2, '2025-02-16', 49.98, 3),
(3, '2025-02-17', 29.99, 2);

-- ORDER_LINE
INSERT INTO order_line (order_id, book_id, quantity, line_total)
VALUES (1, 1, 1, 15.99),
(1, 1, 1, 24.99),
(2, 2, 2, 39.98),
(3, 3, 1, 29.99);

-- ORDER_HISTORY
INSERT INTO order_history (order_id, status_id, status_date)
VALUES (1, 1, '2025-01-20 10:00:00'),
(1, 4, '2025-01-30 10:00:00'),
(2, 3, '2025-02-18 14:30:00'),
(3, 2, '2025-02-20 16:45:00');

SELECT b.title, CONCAT(a.first_name, ' ', a.last_name) AS author
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id;

SELECT c.first_name, c.last_name, o.order_id, s.status_name, h.status_date
FROM customer c
JOIN cust_order o ON c.customer_id = o.customer_id
JOIN order_history h ON o.order_id = h.order_id
JOIN order_status s ON h.status_id = s.status_id;

SELECT o.order_id, b.title, ol.quantity
FROM cust_order o
JOIN order_line ol ON o.order_id = ol.order_id
JOIN book b ON ol.book_id = b.book_id;

SELECT c.first_name, c.last_name, a.city, co.country_name
FROM customer c
JOIN customer_address ca ON c.customer_id = ca.customer_id
JOIN address a ON ca.address_id = a.address_id
JOIN country co ON a.country_id = co.country_id
JOIN address_status s ON ca.status_id = s.status_id
WHERE s.status_name = 'Current' AND co.country_name = 'Kenya';
