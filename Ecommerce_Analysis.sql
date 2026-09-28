CREATE DATABASE ecommerce_analytics;

USE ecommerce_analytics;

-- 1. Customers Table
CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);

-- 2. Sellers Table
CREATE TABLE sellers (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_city VARCHAR(100),
    seller_state VARCHAR(10)
);

-- 3. Products Table
CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100)
);

-- 4. Category Translation Table
CREATE TABLE category_translation (
    product_category_name VARCHAR(100) PRIMARY KEY,
    product_category_name_english VARCHAR(100)
);

-- 5. Orders Table
CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(30),
    order_purchase_timestamp DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME,

    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);

-- 6. Order Items Table
CREATE TABLE order_items (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2),

    PRIMARY KEY (order_id, order_item_id),

    FOREIGN KEY (order_id)
    REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
    REFERENCES products(product_id),

    FOREIGN KEY (seller_id)
    REFERENCES sellers(seller_id)
);

-- 7. Payments Table
CREATE TABLE payments (
    order_id VARCHAR(50),
    payment_type VARCHAR(30),
    payment_installments INT,
    payment_value DECIMAL(10,2),

    FOREIGN KEY (order_id)
    REFERENCES orders(order_id)
);

-- 8. Reviews Table
CREATE TABLE reviews (
    review_id VARCHAR(50) PRIMARY KEY,
    order_id VARCHAR(50),
    review_score INT CHECK (review_score BETWEEN 1 AND 5),
    review_creation_date DATETIME,

    FOREIGN KEY (order_id)
    REFERENCES orders(order_id)
);
 select  count(*) from sellers;
  
# ------------------------------------------------------- 	 QUESTIONS     -------------------------------------------------- #
select * from order_items;
 # Q1) What is the total revenue generated ?
select sum(price + freight_value) as `Total revenue`
from order_items;

# Q2) What is average order value ?

select avg(order_total) as Average_total_order
from ( 
      select 
      order_id , sum(price+freight_value) as order_total
      from order_items
      group by order_id ) as order_summery ;
      
# Q3) How many total orders were placed ?

select count(*) as `Total_orders`  from orders ;

# Q4) How many unique customers exists?

select count(distinct customer_id) as `unique customers`  
from customers ;

# Q5) Which payment method is most used ?

select payment_type , count(*) as `Total_usage`
from payments
group by payment_type
order by Total_usage desc
limit 1;

# Q6) what are the monthly sales trends ?
select month(order_purchase_timestamp)  as month , count(*) as `total_sales`
from orders
group by month(order_purchase_timestamp)
order by month(order_purchase_timestamp) ;

# Q7) Which month generated highest revenue ?

select month(order_purchase_timestamp)  as month , count(*) as `total_sales`
from orders
group by month(order_purchase_timestamp)
order by total_sales desc
limit 1;

# Q.8) What are the top 10 selling product categories ?

select p.product_category_name, 
       count(*) as `Total_sales`, 
       sum(oi.price + oi.freight_value) as `Total_revenue`
from order_items oi
join products p
on p.product_id = oi.product_id
group by p.product_category_name
order by Total_revenue desc
limit 10;

# Q9) Who are the top spending customers ?

select c.customer_unique_id , sum(oi.price + oi.freight_value) as `Most_spend_customer` 
from orders o 
join customers c
on o.customer_id = c.customer_id
join order_items oi
on o.order_id = oi.order_id 
group by c.customer_unique_id 
order by Most_spend_customer desc 
limit 5;

# Q10) how many repeat customer are there ?

select count(*) as `Repeat_customers`
from(
select c.customer_unique_id 
from orders o 
join customers c
on o.customer_id = c.customer_id
group by c.customer_unique_id
having count(o.order_id) > 1
) as repeat_customers_list;

# Q11) Which states generate the highest revenue? 
select c.customer_state , sum(io.price + io.freight_value) as `Total Revenue` 
from customers c 
join orders o
using(customer_id)
join order_items io
using(order_id)
group by c.customer_state
order by `Total Revenue` desc
limit 1;

# Q.12) Which sellers generated the highest revenue ?

select s.seller_id ,
       count(distinct oi.order_id) as `Total_orders`,
       count(*) as `products_sold`,
       sum(oi.price + oi.freight_value) as `Revenue_Total`
from sellers s
join order_items oi
using(seller_id)
group by s.seller_id	
order by Revenue_Total desc ;

# Q.13) Which 3 product categories generated the highest revenue in every customer state?

select *
from (
      select p.product_category_name , c.customer_state , sum(oi.price + oi.freight_value) as `Total Revenue`,
      rank() over(
      partition by c.customer_state
      order by sum(oi.price + oi.freight_value) desc
      ) as Rnk
from customers c
join orders  o
using(customer_id)
join order_items oi
using(order_id)
join products p
using(product_id)
group by p.product_category_name , c.customer_state ) t
where rnk <=3
order by customer_state , rnk ;
 
 
 # Q.14) Identify customers whose spending is above the average customer spending .alter
  
 with customer_sum as 
 ( select c.customer_id , sum(oi.price + oi.freight_value) as `Total_spend` 
         from customers c
         join orders o
         using(customer_id)
         join order_items oi
         using(order_id)
         group by c.customer_id 
         )

select customer_id , Total_spend
from customer_sum 
where Total_spend >
( select avg(Total_spend)
from customer_sum );
	
	
# Q15) Calculate Month-over-Month Revenue Growth
with revenue as (
select date_format(o.order_purchase_timestamp,'%Y-%m') as month , 
sum(oi.price + oi.freight_value) as `Revenue`
from order_items oi 
join orders o
using(order_id)
group by date_format(o.order_purchase_timestamp,'%Y-%m')
 )
select 
month
revenue,
lag(revenue) over(order by month desc) as prev_revenue
from revenue;

# Q16) Calculate the average delivery time for each seller and identify the top 10 fastest and slowest sellers.

select oi.seller_id ,
       count(distinct o.order_id) as Total_ordees,
       round(avg(datediff(order_delivered_customer_date,order_purchase_timestamp)),0) as avg_delievery_days
from orders o
join order_items oi
using(order_id)
join sellers s
using(seller_id)
where order_delivered_customer_date is not null
group by oi.seller_id ;

# Q 17) Which sellers contribute to the first 80% of total company revenue? 

WITH seller_revenue AS
(
    SELECT
        seller_id,
        SUM(price + freight_value) AS revenue
    FROM order_items
    GROUP BY seller_id
),

revenue_calc AS
(
    SELECT
        seller_id,
        revenue,
        SUM(revenue) OVER(ORDER BY revenue DESC) AS running_revenue,
        SUM(revenue) OVER() AS total_revenue
    FROM seller_revenue
)

SELECT
    seller_id,
    revenue,
    running_revenue,
    ROUND(running_revenue * 100.0 / total_revenue, 2) AS cumulative_percentage
FROM revenue_calc
WHERE running_revenue * 100.0 / total_revenue <= 80
ORDER BY revenue DESC;

