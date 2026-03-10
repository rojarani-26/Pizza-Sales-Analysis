 -- 1. Total Revenue Generated

SELECT ROUND(SUM(total_price), 2) AS total_revenue
FROM pizza_sales;

 -- 2. Total Number of Orders

SELECT COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales;

 -- 3. Total Number of Pizzas Sold

SELECT SUM(quantity) AS total_pizzas_sold
FROM pizza_sales;

 -- 4. Average Order Value

SELECT ROUND(SUM(total_price) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM pizza_sales;

 -- 5. Maximum and Minimum Order Value

SELECT MAX(total_price) AS max_price,
       MIN(total_price) AS min_price
FROM pizza_sales;

 -- 6. Revenue by Pizza Category

SELECT pizza_category,ROUND(SUM(total_price),2) AS total_revenue
FROM pizza_sales
GROUP BY pizza_category;

 -- 7. Quantity Sold by Pizza Size

SELECT pizza_size,SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_size
ORDER BY total_quantity DESC;

 -- 8. Highest Revenue Generating Pizza

SELECT TOP 1 pizza_name,SUM(total_price) AS revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY revenue DESC;

 -- 9. Order Per Month

SELECT DATENAME(MONTH, order_date) AS order_month,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date), MONTH(order_date)
ORDER BY MONTH(order_date);

 -- 10. Top 5 Best Selling Pizzas

SELECT TOP 5 pizza_name,SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity DESC;

 -- 11. Second Highest Revenue Pizza

SELECT pizza_name, revenue FROM 
(
     SELECT pizza_name,
            SUM(total_price) AS revenue,
            DENSE_RANK() OVER (ORDER BY SUM(total_price) DESC) AS rank_num
     FROM pizza_sales
     GROUP BY pizza_name
) t
WHERE rank_num = 2;

-- 12. Top 5 Pizzas generate revenue higher than the average pizza revenue

SELECT TOP 5 pizza_name, SUM(total_price) AS revenue
FROM pizza_sales
GROUP BY pizza_name
HAVING SUM(total_price) >
(
    SELECT AVG(revenue)
    FROM (
        SELECT SUM(total_price) AS revenue
        FROM pizza_sales
        GROUP BY pizza_name
    ) t
)
ORDER BY revenue DESC;