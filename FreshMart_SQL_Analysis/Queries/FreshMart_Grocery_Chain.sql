create database freshmart_db;
use freshmart_db;
create table Customers (
cutomer_id int primary key auto_increment,
name varchar(100) default null,
age int,
region varchar(50) default null,
signup_date date default null
);
select * from Customers;

create table Stores (
store_id int primary key auto_increment,
city varchar(50) default null,
region varchar(50) default null,
manager_name varchar(100) default null
);
select * from stores;

create table Products (
product_id int primary key auto_increment,
product_name varchar(50) default null,
categoty varchar(50) default null,
subcategory varchar(50) default null,
unit_cost decimal(5,2) default null
);
select * from Products;

create table Orders (
order_id int primary key auto_increment,
customer_id int,
store_id int,
order_date date default null,
total_amount decimal (5,2) default null,
foreign key (customer_id) references Customers(customer_id),
foreign key (store_id) references Stores(store_id)
);
select * from Orders;

create table Order_Items (
order_item_id int primary key auto_increment,
order_id int,
product_id int,
quantity int default null,
unit_price decimal(5,2),
foreign key (order_id) references Orders(order_id),
foreign key (product_id) references Products(product_id)
);
select * from Order_Items;

-- Total Revenue by Region

select region, sum(total_amount) as total_revenue 
from Stores join Orders on Stores.store_id = Orders.store_id
group by region order by total_revenue desc;

-- Average Order Value (AOV)

select round(sum(total_amount) / count(distinct order_id), 2) as avg_order_value from Orders;

-- Top 5 Selling Products

select product_name, sum(quantity) as total_quantity
from Products join Order_Items on Products.product_id = Order_Items.product_id
group by product_name order by total_quantity desc limit 5;

-- Customer Retention (Repeat Buyers)

select customer_id, count(order_id) as total_orders
from Orders group by customer_id
order by total_orders desc;

-- Monthly Revenue Trend

select date_format(order_date, '%Y-%M') as month_year, sum(total_amount) as montly_sales
from Orders group by month_year order by month_year;

-- Store Performance Ranking

select city, sum(total_amount) as store_revenue, count(order_id) as total_orders
from Stores join Orders on Stores.store_id = Orders.store_id
group by city order by store_revenue desc;

