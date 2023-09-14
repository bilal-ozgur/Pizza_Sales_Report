

-- KPI’s REQUIREMENT
-- We need to analyze key indicators for our pizza sales data to gain insights into our business performance. Specifically, we want to calculate the following metrics:


SELECT * FROM pizza_sales;

-- 1. Total Revenue: The sum of the total price of all pizza orders.

SELECT	SUM(total_price) AS total_revenue
FROM	pizza_sales;

-- 2. Average Order Value: The average amount spent per order, calculated by dividing the total revenue by the total number of orders.

SELECT	SUM(total_price) / COUNT(DISTINCT order_id) AS avg_order_value
FROM	pizza_sales;

-- 3. Total Pizzas Sold: The sum of the quantities of all pizzas sold.

SELECT	SUM(quantity) AS total_pizzas_sold
FROM	pizza_sales;

-- 4. Total Orders: The total number of orders placed.

SELECT	COUNT(DISTINCT order_id) AS total_orders
FROM	pizza_sales;

-- 5. Average Pizzas Per Order: The average number of pizzas sold per order, calculated by dividing the total number of pizzas sold by the total number of orders.

SELECT	CAST(SUM(quantity) * 1.0 / COUNT(DISTINCT order_id) AS decimal(10,2)) AS avg_pizza_order
FROM	pizza_sales;


-- CHARTS REQUIREMENT
-- We would like to visualize various aspects of our pizza sales data to gain insights and understand key trends. We have identified the following requirements for creating charts:

SELECT * FROM pizza_sales;

--  1. Hourly Trend for Total Pizzas Sold:

SELECT		DATEPART(HOUR, order_time) AS order_hour,
			SUM(quantity) AS total_pizzas_sold
FROM		pizza_sales
GROUP BY	DATEPART(HOUR, order_time)
ORDER BY	1	;

--  2. Weekly Trend for Total Orders:

SELECT		YEAR(order_date) AS order_year,
			DATEPART(ISO_WEEK,order_date) AS order_week, 
			COUNT(DISTINCT order_id) AS total_quantity
FROM		pizza_sales
GROUP BY	YEAR(order_date),
			DATEPART(ISO_WEEK,order_date)
ORDER BY	1,2;

--  3. Percentage of Sales by Pizza Category:

SELECT		pizza_category,
			CAST(SUM(total_price) AS decimal(10,2) ) AS total_sales,
			CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS decimal(10,2)) AS "percentage"
FROM		pizza_sales
GROUP BY	pizza_category;


--  4. Percentage of Sales by Pizza Size:

SELECT		pizza_size,
			CAST(SUM(total_price) AS decimal(10,2) ) AS total_sales,
			CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS decimal(10,2)) AS "percentage"
FROM		pizza_sales
GROUP BY	pizza_size
ORDER BY	1;


--  5. Total Pizzas Sold by Pizza Category:

SELECT		pizza_category,
			SUM(quantity) AS total_quantity_sold
FROM		pizza_sales
GROUP BY	pizza_category
ORDER BY	total_quantity_sold;


--  6. Top 5 Best Sellers by Revenue, Total Quantity and Total Orders

SELECT		TOP 5 pizza_name,
			SUM(total_price) AS total_revenue,
			SUM(quantity) AS total_quantity,
			COUNT(DISTINCT order_id) AS total_order
FROM		pizza_sales
GROUP BY	pizza_name
ORDER BY	total_revenue DESC;


--  7. Bottom 5 Best Sellers by Revenue, Total Quantity and Total Orders

SELECT		TOP 5 pizza_name,
			SUM(total_price) AS total_revenue,
			SUM(quantity) AS total_quantity,
			COUNT(DISTINCT order_id) AS total_order
FROM		pizza_sales
GROUP BY	pizza_name
ORDER BY	total_revenue ASC;

------


select * from pizza_sales