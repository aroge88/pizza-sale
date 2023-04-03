#1.First 5 rows of datatset
SELECT * 
FROM PizzaRevenue.`pizza sales`
LImit 5;
# 		order_details_id	order_id	pizza_id	quantity	order_date	order_time	unit_price	total_price	pizza_size	pizza_category	pizza_ingredients	pizza_name
#			1					1		hawaiian_m		1			1/1/15	11:38 AM	$13.25	$13.25	M	Classic	Sliced Ham, Pineapple, Mozzarella Cheese	The Hawaiian Pizza
#			2					2		classic_dlx_m		1			1/1/15	11:57 AM	$16.00	$16.00	M	Classic	Pepperoni, Mushrooms, Red Onions, Red Peppers, Bacon	The Classic Deluxe Pizza
#			3					2		five_cheese			1			1/1/15	11:57 AM	$18.50	$18.50	L	Veggie	Mozzarella Cheese, Provolone Cheese, Smoked Gouda Cheese, Romano Cheese, Blue Cheese, Garlic	The Five Cheese Pizza
#			4					2		ital_supr_l			1			1/1/15	11:57 AM	$20.75	$20.75	L	Supreme	Calabrese Salami, Capocollo, Tomatoes, Red Onions, Green Olives, Garlic	The Italian Supreme Pizza
#			5					2		mexicana_m			1			1/1/15	11:57 AM	$16.00	$16.00	M	Veggie	Tomatoes, Red Peppers, Jalapeno Peppers, Red Onions, Cilantro, Corn, Chipotle Sauce, Garlic	The Mexicana Pizza


# 2. Total Revenue
SELECT CONCAT('$', FORMAT(SUM(REPLACE(total_price, '$', '')), 2)) AS Revenue
FROM PizzaRevenue.`pizza sales`;
# Revenue
#$817,860.05

#3 Quantitiy Sold
select sum(quantity) as pizza
FROM PizzaRevenue.`pizza sales`;
# pizza
# 49574

#Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM PizzaRevenue.`pizza sales`;
# total_orders
# 21350


# 4. calculates the total revenue for each pizza category:
WITH category_revenue AS (
    SELECT 
        pizza_category, 
        CONCAT('$', FORMAT(SUM(REPLACE(total_price, '$', '')), 2)) as Revenue_by_Category
    FROM 
       PizzaRevenue.`pizza sales`
    GROUP BY 
        pizza_category
)
SELECT 
    pizza_category, 
    Revenue_by_Category
FROM 
    category_revenue
ORDER BY 
    Revenue_by_Category DESC;
# pizza_category	Revenue_by_Category
# Classic			$220,053.10
# Supreme			$208,197.00
# Chicken			$195,919.50
# Veggie			$193,690.45
    
    
# 5. Show the average revenue generated per order for each pizza category:
SELECT pizza_category, CONCAT('$', FORMAT(Avg(REPLACE(total_price, '$', '')), 2)) AS avg_revenue_per_order
FROM PizzaRevenue.`pizza sales`
GROUP BY pizza_category;
# pizza_category	avg_revenue_per_order
# Classic			$15.09
# Veggie			$16.92
# Supreme			$17.68
# Chicken			$18.12

# 6. Show the average unit price of all pizzas, grouped by size and category
SELECT pizza_size, pizza_category, CONCAT('$', FORMAT(SUM(REPLACE(total_price, '$', '')), 2)) AS avg_price
FROM PizzaRevenue.`pizza sales`
GROUP BY pizza_size, pizza_category
ORDER BY pizza_size, pizza_category ASC;
# pizza_size	pizza_category	avg_price
# L				Chicken			$102,339.00
# L				Classic			$74,518.50
# L				Supreme			$94,258.50
# L				Veggie			$104,202.70
# M				Chicken			$65,224.50

# 7. What is the least pizza ingredient?
SELECT 
    pizza_ingredients, 
    COUNT(*) AS ingredient_count 
FROM 
    PizzaRevenue.`pizza sales`
GROUP BY 
    pizza_ingredients 
ORDER BY 
    ingredient_count ASC 
    limit 5;
# 8. What is the most common pizza ingredient?
SELECT 
    pizza_ingredients, 
    COUNT(*) AS ingredient_count 
FROM 
    PizzaRevenue.`pizza sales`
GROUP BY 
    pizza_ingredients 
ORDER BY 
    ingredient_count desc;
   

# 9. Show the number of orders placed during each hour of the day
SELECT HOUR(order_time) AS hour_of_day, COUNT(*) AS total_orders
FROM PizzaRevenue.`pizza sales`
GROUP BY hour_of_day 
ORDER BY total_orders desc;
# hour_of_day	total_orders
# 12				6543
# 1					6203
# 6					5359
# 5					5143
# 7					4350
# 4					4185
# 2					3521
# 8					3487
# 3					3170
# 11				2740
# 9					2532
# 10				1387

# 10. Show the top 5 most popular pizza names for each pizza size:
SELECT pizza_category, pizza_name, SUM(quantity) AS total_orders
FROM PizzaRevenue.`pizza sales`
GROUP BY pizza_category, pizza_name
ORDER BY pizza_category, total_orders DESC;
# pizza_category	pizza_name			total_orders
# Chicken	The Barbecue Chicken Pizza	2432
# Chicken	The Thai Chicken Pizza		2371
# Chicken	The California Chicken Pizza 2370
# Chicken	The Southwest Chicken Pizza	1917
# Chicken	The Chicken Alfredo Pizza	987

# 11. Show the number of overall orders placed during  week
SELECT DAYNAME(order_date) AS day_of_week,
COUNT(*) AS pizza_count, CONCAT('$', FORMAT(SUM(REPLACE(total_price, '$', '')), 2)) AS Revenue_by_weekly
FROM PizzaRevenue.`pizza sales`
where DAYOFWEEK(order_date)
GROUP BY day_of_week
ORDER BY pizza_count DESC;
# day_of_week	Revenue_by_weekly
# Thursday	$54,627.15
# Sunday	$49,211.55
# Tuesday	$48,498.75
# Monday	$45,824.95
# Friday	$45,235.25
# Saturday	$44,011.60
# Wednesday	$41,920.55










