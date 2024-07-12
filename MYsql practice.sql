create database Salesdb;
use Salesdb;

create table productlines (
    productLine VARCHAR(50) PRIMARY KEY,
    textDescription  VARCHAR(4000),
    htmlDescription MEDIUMTEXT,
    image MEDIUMBLOB
);

create table products(
	productCode VARCHAR(15) PRIMARY KEY,
    productName VARCHAR(70) not null,
    productLine VARCHAR(50) not null,
    productScale VARCHAR(10) not null,
    productVendor VARCHAR(50) NOT NULL,
    productDescription TEXT,
    quantityInStock SMALLINT,
    buyPrice DECIMAL(10, 2) NOT NULL,
    MSRP DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (productLine) REFERENCES productlines(productLine)
);

create table employees(
	employeeNumber INT PRIMARY KEY,
    lastName VARCHAR(50) not null,
    firstName VARCHAR(50) not null,
    extension VARCHAR(10)  not null,
    email VARCHAR(100)  not null,
    officeCode VARCHAR(10)  not null,
    reportsTo INT,
    jobTitle VARCHAR(50)  not null,
    FOREIGN KEY (reportsTo) REFERENCES employees(employeeNumber)
);

create table offices(
	officeCode VARCHAR(10) PRIMARY KEY,
    city VARCHAR(50) not null,
    
    phone VARCHAR(20) not null,
    addressLine1 VARCHAR(50) not null,
    addressLine2 VARCHAR(50) not null,
    state VARCHAR(50) not null,
    country VARCHAR(50) not null,
    postalCode VARCHAR(15) not null,
    territory VARCHAR(10)
);

create table customers(
	customerNumber INT PRIMARY KEY,
    customerName VARCHAR(50) not null,
    contactLastName VARCHAR(50) not null,
    contactFirstName VARCHAR(50) not null,
    phone VARCHAR(20) not null,
    addressLine1 VARCHAR(50) not null,
    addressLine2 VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postalCode VARCHAR(15) not null,
    country VARCHAR(50) not null,
    salesRepEmployeeNumber INT,
    creditLimit DECIMAL(10, 2),
    FOREIGN KEY (salesRepEmployeeNumber) REFERENCES employees(employeeNumber)
);

create table orders(
	orderNumber INT PRIMARY KEY,
    orderDate DATE not null,
    requiredDate DATE not null,
    shippedDate DATE not null,
    status VARCHAR(15) not null,
    
    comments TEXT not null,
    customerNumber INT,
    FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
);

create  table orderdetails(
	orderNumber INT,
    productCode VARCHAR(15),
    quantityOrdered INT not null,
    priceEach DECIMAL(10, 2),
    orderLineNumber SMALLINT,
    PRIMARY KEY (orderNumber, productCode),
    FOREIGN KEY (orderNumber) REFERENCES orders(orderNumber),
    FOREIGN KEY (productCode) REFERENCES products(productCode)
);

create table payments(
	customerNumber INT,
    checkNumber VARCHAR(50),
    paymentDate DATE not null,
    amount DECIMAL(10, 2) not null,
	PRIMARY KEY (customerNumber, checkNumber),
    FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
);

select *from orderdetails;

INSERT INTO productlines (productLine, textDescription)
VALUES ('Bikes', 'Various styles'),
       ('Sports', 'Activities'),
       ('Shoes', 'Footwear needs'),
       ('Clothing', 'Apparel (not included)'),
       ('Electronics', 'Devices (not included)');

INSERT INTO offices (officeCode, city, phone, addressLine1, addressLine2, state, country, postalCode, territory)
VALUES ('CA01', 'Los Angeles', '310-555-1313', '333 Ocean Boulevard', NULL, 'CA', 'USA', '90210', 'America'),
       ('NY01', 'New York', '212-555-1212', '1 Wall Street', NULL, 'NY', 'USA', '10005', 'Spain'),
       ('UK01', 'London', '020-7946-0000', '123 Oxford Street', NULL, '', 'UK', 'W1C 1AB', 'Europe'),
       ('FR01', 'Paris', '01-4567-8901', '45 Rue de Rivoli', NULL, '', 'France', '75001', 'Europe'),
       ('JP01', 'Tokyo', '81-3-1234-5678', '1-10-10 Minato-ku', NULL, '', 'Japan', '108-0070', 'Asia');

INSERT INTO products (productCode, productName, productLine, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP)
VALUES ('P00001', 'Classic Bike', 'Bikes', 'Medium', 'Roadmaster', 'This classic bike is perfect for casual rides.', 15, 250.00, 350.00),
 ('P00002', 'Mountain Trail', 'Bikes', 'Medium', 'Schwinn', 'This mountain bike is ideal for off-road adventures.', 10, 300.00, 420.00),
       ('P00003', 'Tennis Racket', 'Sports', 'Small', 'Wilson', 'A high-performance tennis racket for competitive play.', 20, 75.00, 120.00),
       ('P00004', 'Running Shoes', 'Shoes', 'Medium', 'Nike', 'Lightweight running shoes for optimal performance.', 30, 60.00, 100.00),
       ('P00005', 'Baseball Bat', 'Sports', 'Medium', 'Louisville Slugger', 'A classic wooden baseball bat for serious hitters.', 12, 50.00, 80.00);

INSERT INTO customers (customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, addressLine2, city, state, postalCode, country, salesRepEmployeeNumber, creditLimit)
VALUES (20001, 'Acme Corporation', 'Smith', 'John', '555-555-0001', '100 Main Street', 'Suite 500', 'New York', 'NY', '10001', 'USA', NULL, 50000.00),
       (20002, 'JK Tech', 'Kim', 'Soojin', '555-555-0002', '33 Elm Street', NULL, 'Los Angeles', 'CA', '90210', 'USA', NULL, 25000.00),
       (20003, 'London Supplies', 'Williams', 'David', '020-7123-4567', '22 Baker Street', NULL, 'London', '', 'W1C 1AB', 'UK', NULL, 10000.00),
       (20004, 'Parisian Delights', 'Blanc', 'Marie', '01-4456-7890', '1 Rue de la Seine', NULL, 'Paris', '', '75001', 'France', NULL, 30000.00),
       (20005, 'Tokyo Electronics', 'Tanaka', 'Shiro', '81-3-9876-5432', '4-3-2 Minato-ku', NULL, 'Tokyo', '', '108-0070', 'Japan', NULL, 40000.00);

INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle)
VALUES (10001, 'Lee', 'Susan', '1111', 'susan.lee@company.com', 'NY01', NULL, 'Sales Manager'),
       (10002, 'Johnson', 'John', '2222', 'john.johnson@company.com', 'CA01', 10001, 'Sales Representative'),
       (10003, 'Miller', 'David', '3333', 'david.miller@company.com', 'NY01', 10001, 'Sales Representative'),
       (10004, 'Williams', 'Anne', '4444', 'anne.williams@company.com', 'UK01', NULL, 'Marketing Specialist'),
       (10005, 'Jones', 'Daniel', '5555', 'daniel.jones@company.com', 'FR01', NULL, 'Customer Service Representative');

INSERT INTO orders (orderNumber, orderDate, requiredDate, shippedDate, status, comments, customerNumber)
VALUES (1001, '2024-07-08', '2024-07-22', '2024-07-15', 'Shipped', 'Special instructions: handle with care.', 20001),
       (1002, '2024-07-09', '2024-07-25', '2024-07-18', 'Shipped', 'None', 20002),
       (1003, '2024-07-10', '2024-07-28', NULL, 'Pending', 'Customer requested expedited shipping.', 20003),
       (1004, '2024-07-11', '2024-07-29', NULL, 'Processing', 'Awaiting inventory for some items.', 20004),
       (1005, '2024-07-12', '2024-08-02', NULL, 'New', 'None', 20005);

-- Check the existing order numbers in the orders table before inserting order details.

INSERT INTO orderdetails (orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber)
VALUES (101, 'P00002', 2, 310.00, 1), 
       (101, 'P00003', 1, 80.00, 2),  
       (102, 'P00001', 1, 270.00, 1),  
       (1022, 'P00004', 3, 63.00, 2),  
       (103, 'P00005', 4, 52.00, 1);  



INSERT INTO payments (customerNumber, checkNumber, paymentDate, amount)
VALUES (20001, 'CK12345', '2024-07-10', 5000.00),  
       (20002, 'JKT78901', '2024-07-11', 3200.00), 
       (20003, 'LS34567', '2024-07-12', 1530.00),
       (20004, 'PD90123', '2024-07-08', 1320.00),  
       (20005, 'TE56789', '2024-07-09', 4450.00);  


show tables;

select * from productlines;
SELECT * FROM offices;
SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM orders;
SELECT * FROM orderdetails;
SELECT * FROM payments;














	




	

