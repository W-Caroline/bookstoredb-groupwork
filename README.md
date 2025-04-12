# 📚 BookstoreDB Project

This is a MySQL database project designed to manage a bookstore system. It includes tables for managing books, authors, customers, orders, shipping, and more.

---

## 📊 ER Diagram

The diagram below shows the relationships between all tables in the database.

![ER Diagram](./bookstoredb%20flowchart/bookstoredb-flowchart.png)

---

## 🏗️ Database Tables

Here’s a summary of the tables created in the project:

- **Country** – List of countries  
- **Address** – Contains address details, linked to a country  
- **Address_Status** – Indicates if an address is current or old  
- **Customer** – Stores customer details  
- **Customer_Address** – Links customers to addresses and their status  
- **Author** – Stores author names  
- **Publisher** – Information about book publishers  
- **Book_Language** – Lists book languages  
- **Book** – Book details including title, price, language, and publisher  
- **Book_Author** – Links books to authors (many-to-many relationship)  
- **Shipping_Method** – Delivery options for orders  
- **Order_Status** – Status of orders like pending, shipped, delivered  
- **Cust_Order** – Orders placed by customers  
- **Order_Line** – Books in each order  
- **Order_History** – Tracks status changes of orders  

---

## 🔄 Example Data Flow Through the System

1. A customer is created and linked to an address.
2. They place an order, selecting books and a shipping method.
3. The order is stored in `cust_order`, with book details in `order_line`.
4. The status is tracked over time using the `order_history` table.

---

## 🔐 User Management (Examples)

```sql
-- Read-only user
CREATE USER 'readonly_user'@'localhost' IDENTIFIED BY 'password123';
GRANT SELECT ON BookStoreDB.* TO 'readonly_user'@'localhost';

-- Admin user
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'adminpass456';
GRANT ALL PRIVILEGES ON BookStoreDB.* TO 'admin_user'@'localhost';
