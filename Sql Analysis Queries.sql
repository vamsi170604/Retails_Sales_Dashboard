select * from Customers;
select * from Orders;
select * from Products;

--> What is the total sales generated in the retail shop?
SELECT 
    ROUND(SUM(sales), 2) AS total_sales
FROM Products;

--> What is the total profit earned across all orders?
SELECT 
    ROUND(SUM(profit), 2) AS total_profit
FROM Products;

--> How many total orders were placed?
SELECT 
    COUNT(DISTINCT order_id) AS total_orders
FROM Orders;

--> Which product category has the highest sales?
SELECT 
    Category,
    ROUND(SUM(sales), 2) AS total_sales
FROM Products
GROUP BY Category
ORDER BY total_sales DESC
LIMIT 1;

--> Which state contributes the maximum sales?
SELECT 
    c.State,
    ROUND(SUM(p.sales), 2) AS total_sales
FROM Customers c
JOIN Orders o
ON c.Customer_ID = o.Customer_ID
JOIN Products p
ON o.Order_ID = p.Order_ID
GROUP BY c.state
ORDER BY total_sales DESC
LIMIT 1;

--> What is the total quantity of products sold?
SELECT 
    SUM(quantity) AS total_quantity_sold
FROM Products;

--> Which customer segment generates the highest revenue?
SELECT 
    c.segment,
    ROUND(SUM(p.sales), 2) AS total_revenue
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
JOIN Products p
ON o.order_id = p.order_id
GROUP BY c.segment
ORDER BY total_revenue DESC
LIMIT 1;

--> Which shipping mode is used the most?
SELECT 
    ship_mode,
    COUNT(*) AS usage_count
FROM Orders
GROUP BY ship_mode
ORDER BY usage_count DESC
LIMIT 1;

--> Compare sales and profit across different regions
SELECT 
    c.region,
    ROUND(SUM(p.sales), 2) AS total_sales,
    ROUND(SUM(p.profit), 2) AS total_profit
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
JOIN Products p
ON o.order_id = p.order_id
GROUP BY c.region
ORDER BY total_sales DESC;

--> Which sub-category generates the highest profit?
SELECT 
    Product_name,
    ROUND(SUM(profit), 2) AS total_profit
FROM Products
GROUP BY Product_name
ORDER BY total_profit DESC
LIMIT 1;

--> Identify the top 10 customers based on total purchase value
SELECT 
    c.customer_name,
    ROUND(SUM(p.sales), 2) AS total_purchase_value
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
JOIN Products p
ON o.order_id = p.order_id
GROUP BY c.customer_name
ORDER BY total_purchase_value DESC
LIMIT 10;

--> Which month recorded the highest sales?
SELECT 
    TO_CHAR(o.order_date, 'Month') AS month_name,
    ROUND(SUM(p.sales), 2) AS total_sales
FROM Orders o
JOIN Products p
ON o.order_id = p.order_id
GROUP BY month_name
ORDER BY total_sales DESC
LIMIT 1;

--> Find the average discount provided by each category
SELECT 
    category,
    ROUND(AVG(discount), 2) AS avg_discount
FROM Products
GROUP BY category
ORDER BY avg_discount DESC;

--> Which state has high sales but low profit?
SELECT 
    c.state,
    ROUND(SUM(p.sales), 2) AS total_sales,
    ROUND(SUM(p.profit), 2) AS total_profit
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
JOIN Products p
ON o.order_id = p.order_id
GROUP BY c.state
ORDER BY total_sales DESC, total_profit ASC;

--> Which state has high sales but low profit?
SELECT 
    c.state,
    ROUND(SUM(p.sales), 2) AS total_sales,
    ROUND(SUM(p.profit), 2) AS total_profit
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
JOIN Products p
ON o.order_id = p.order_id
GROUP BY c.state
ORDER BY total_sales DESC, total_profit ASC;

--> Compare yearly sales growth from 2020 to 2023
SELECT 
    EXTRACT(YEAR FROM o.order_date) AS year,
    ROUND(SUM(p.sales), 2) AS yearly_sales
FROM Orders o
JOIN Products p
ON o.order_id = p.order_id
GROUP BY year
ORDER BY year;

--> Which products are frequently ordered in high quantities?
SELECT 
    product_name,
    SUM(quantity) AS total_quantity_ordered
FROM Products
GROUP BY product_name
ORDER BY total_quantity_ordered DESC
LIMIT 10;

--> Calculate profit percentage for each category and sub-category
SELECT 
    category,
    Product_name,

    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,

    ROUND(
        (SUM(profit) / NULLIF(SUM(sales),0)) * 100,
    2) AS profit_percentage

FROM Products
GROUP BY category,Product_name
ORDER BY profit_percentage DESC;

--> Analyze the impact of discount on profit
SELECT 
    CASE 
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 0.10 THEN 'Low Discount'
        WHEN discount <= 0.30 THEN 'Medium Discount'
        ELSE 'High Discount'
    END AS discount_category,

    ROUND(AVG(profit), 2) AS avg_profit,
    ROUND(AVG(sales), 2) AS avg_sales,
    COUNT(*) AS total_orders

FROM Products
GROUP BY discount_category
ORDER BY avg_profit DESC;

--> Identify the top-performing region based on both sales and profit
SELECT 
    c.region,

    ROUND(SUM(p.sales), 2) AS total_sales,
    ROUND(SUM(p.profit), 2) AS total_profit

FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id

JOIN Products p
ON o.order_id = p.order_id

GROUP BY c.region
ORDER BY total_sales DESC, total_profit DESC
LIMIT 1;

--> Calculate order delivery duration
SELECT 
    order_id,
    order_date,
    ship_date,

    (ship_date - order_date) AS delivery_days

FROM Orders
ORDER BY delivery_days DESC;