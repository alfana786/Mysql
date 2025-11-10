**Database Structure

Database Name: retail_store**

**Table Name	Description**
Categories	Stores product categories and descriptions
Customers	Holds customer personal and contact details
Products	Contains product details, category link, and stock info
Orders	Tracks customer orders and shipping details
Order_Details	Links orders and products, including quantities and pricing
** Features Implemented**

Database creation and normalization

 Relationships using foreign keys

 Inserted 10 sample records per table

 Complex SQL queries (joins, grouping, aggregation)

 DML operations (UPDATE, DELETE)

 Real-world simulation of an online retail store

 Entity-Relationship Overview

**Main Relationships:**

Categories ↔ Products (One-to-Many)

Customers ↔ Orders (One-to-Many)

Orders ↔ Order_Details (One-to-Many)

Products ↔ Order_Details (One-to-Many)

**SQL Files
File Name	Description**
retail_store_project.sql	Complete SQL code: table creation, sample data, and queries
