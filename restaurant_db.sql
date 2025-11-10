
-- EXPLORE THE ITEMS OF THE TABLE


-- View menu_items table
select * from menu_items;


-- 2. Find the number of items on the menu
select COUNT(*) FROM menu_items;

-- 3. what are the least and most expensive items on the menu?

select item_name, price 
from menu_items
order by price;

select item_name, price 
from menu_items
order by price DESC;

-- 4. How many italian dishes are on the menu?

Select COUNT(category)
from menu_items
where category = 'italian';

-- 5. What are the least and most expensive Italian dishes on the menu?

Select *
from menu_items
where category = 'italian'
order by price;

Select *
from menu_items
where category = 'italian'
order by price DESC;


-- 6. How many dishes are in each category?

select category, COUNT(item_name) AS num_dishes
from menu_items
group by category;

-- 7. Whats the average dish price within each category?

select category, AVG(price ) AS avg_price
from menu_items
group by category;





-- EXPLORE THE ORDERS TABLE


-- 1. Viev the order_details table.

SELECT * FROM order_details;

-- 2. What is the date range of the table ?

SELECT MIN(order_date), MAX(order_date) FROM order_details;

-- 3. How many orders were made within this date range?

SELECT COUNT(DISTINCT order_id)AS total_Orders from order_details;

-- 4. How many items were ordered within this date range?

SELECT COUNT(*) from order_details;



-- 5. which orders had the most number of items?

SELECT order_id, COUNT(item_id) AS num_items
from order_details
group by order_id
ORDER BY num_items DESC;

-- 6. how many orders had more than 12 items ?

SELECT COUNT(*) FROM 
(SELECT order_id, COUNT(item_id) AS num_items
from order_details
group by order_id
HAVING num_items > 12) as num_orders;






-- ANALYZE CUSTOMER BEHAVIOR

-- 1. Combine the menu items and order_details tables into a single table

	SELECT * FROM menu_items;
    SELECT * FROM order_details;

	SELECT * 
    FROM order_details od LEFT JOIN menu_items mi
    ON od.item_id = mi.menu_item_id;

-- 2. what were the least and most ordered items? what categories were they in?

	SELECT item_name, COUNT(order_details_id) AS num_purcharse
    FROM order_details od LEFT JOIN menu_items mi
    ON od.item_id = mi.menu_item_id
    group by item_name
    order by num_purcharse desc;
    
    SELECT item_name,category, COUNT(order_details_id) AS num_purcharse
    FROM order_details od LEFT JOIN menu_items mi
    ON od.item_id = mi.menu_item_id
    group by item_name , category
    order by num_purcharse desc;

-- 3. what were the top 5 orders that spent the most money?
	SELECT order_id, SUM(price) AS top_orders
    FROM order_details od LEFT JOIN menu_items mi
    ON od.item_id = mi.menu_item_id
    group BY order_id
    order by top_orders desc limit 5;


-- 4. view the details of the highest spend order. what insights can you gather from the result?


SELECT category, COUNT(item_id) AS num_items
    FROM order_details od LEFT JOIN menu_items mi
    ON od.item_id = mi.menu_item_id
    WHERE order_id = 440
    group by category;
   
    


-- 5. view the details of the top 5 highest spend orders. what insights can you gather from the results? 
	
    SELECT order_id, category, COUNT(item_id) AS num_items
	FROM order_details od LEFT JOIN menu_items mi
    ON od.item_id = mi.menu_item_id
    WHERE order_id IN ( 440, 2075,1957,330,2675)
    group by order_id, category;
   

