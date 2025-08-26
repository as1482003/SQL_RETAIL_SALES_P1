#Create Table

DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
(
transactions_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR(15),
age INT,
category VARCHAR(11),
quantity INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
);

-- Data Exploration--

-- Select NULL columns

SELECT * FROM retail_sales
WHERE transactions_id IS NULL
OR
sale_date IS NULL
OR
sale_time IS NULL
OR
customer_id IS NULL
OR
gender IS NULL
OR
category IS NULL
OR
quantity IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;

-- How many sales we have?
SELECT COUNT(*) AS total_sales FROM retail_sales;

-- How many customers we have?
-SELECT COUNT(customer_id) as total_sale FROM retail_sales
-SELECT DISTINCT category FROM retail_sales


-- Data Analysis & Business Key Problems & Answers--

-- Q1. Write a SQL query to retrive all colums for sales made on '2022-11-05'?

SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05'

-- Q2. Write a SQL query to retrive all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the months of Nov -2022.

SELECT * from retail_sales
where category = 'Clothing'
and to_char(sale_date, 'YYYY-MM') = '2022-11'
and quantity >= 4

-- Q3. Write a SQL query to calculate the total sales (total_sale) for each category and total Orders.

SELECT CATEGORY, SUM(TOTAL_SALE) AS NET_SALE,
COUNT(*) NET_ORDERS
FROM RETAIL_SALES
GROUP BY CATEGORY

-- Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT CATEGORY, ROUND(AVG(AGE), 2) AS AVERAGE_AGE
FROM RETAIL_SALES
WHERE CATEGORY = 'Beauty'
GROUP BY 1

-- Q5. Write a SQL query to find all the transactions where the total_sales is greater than 1000.

SELECT TRANSACTIONS_ID, SUM(TOTAL_SALE)
FROM RETAIL_SALES
WHERE TOTAL_SALE > 1000
GROUP BY 1

-- Q6. Write a SQL query to find the total number of transactions made by each gender in each category.

SELECT GENDER, CATEGORY,
COUNT(*) AS TOTAL_NUMBER_OF_TRANSACTIONS
FROM RETAIL_SALES
GROUP BY 1,2

-- Q7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.

SELECT YEAR,MONTH,AVERAGE_SALE FROM
(
SELECT EXTRACT(YEAR FROM SALE_DATE) AS YEAR,
EXTRACT(MONTH FROM SALE_DATE) AS MONTH,
AVG(TOTAL_SALE)  AS AVERAGE_SALE,
RANK() OVER(PARTITION BY EXTRACT(YEAR FROM SALE_DATE) ORDER BY AVG(TOTAL_SALE) DESC) AS RANK
FROM RETAIL_SALES
GROUP BY 1,2
) AS BEST_SELLING_MONTH_OF_EACH_YEAR 
WHERE RANK = 1

-- Q8. Write a SQL query to find the top 5 customers based on the highest total sales.

SELECT CUSTOMER_ID, SUM(TOTAL_SALE) AS HIGHEST_TOTAL_SALES
FROM RETAIL_SALES
GROUP BY CUSTOMER_ID
ORDER BY 2 DESC
LIMIT 5

-- Q9. Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT CATEGORY, COUNT(DISTINCT CUSTOMER_ID) AS UNIQUE_CUSTOMERS
FROM RETAIL_SALES
GROUP BY 1

-- Q10. Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

SELECT * FROM RETAIL_SALES

WITH HOURLY_SALE AS (
SELECT *,
CASE
WHEN EXTRACT(HOUR FROM SALE_TIME) < 12 THEN 'MORNING'
WHEN EXTRACT(HOUR FROM SALE_TIME) BETWEEN 12 AND 17 THEN 'AFTERNOON' 
ELSE 'EVENING'
END AS SHIFT
FROM RETAIL_SALES
)
SELECT SHIFT, COUNT(*) AS TOTAL_ORDERS
FROM HOURLY_SALE
GROUP BY SHIFT

--END OF PROJECT--














