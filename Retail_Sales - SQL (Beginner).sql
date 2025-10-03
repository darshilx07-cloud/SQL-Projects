-- CREATING THE DATABASE
--
CREATE DATABASE RETAIL;
USE RETAIL;

-- CREATING THE TABLE 
-- 
CREATE TABLE RETAIL_SALES(
transactions_id	INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id	INT,
gender VARCHAR(15),
age	INT,
category VARCHAR(15),
quantiy	INT,
price_per_unit	FLOAT,
cogs FLOAT,
total_sale FLOAT
);

SELECT * FROM RETAIL_SALES;


--  INDENTIFY THE NULL VALUES FROM THE DATASET
--
SELECT * FROM RETAIL_SALES
WHERE 
	transactions_id IS NULL
    or
    sale_date IS NULL 
    or
    sale_time IS NULL 
    or
    customer_id IS NULL
    or
    gender IS NULL
    or
    age IS NULL
    or
    category IS NULL
    or
    quantiy IS NULL 
    or
    price_per_unit IS NULL
    or
    cogs IS NULL
    or
    total_sale IS NULL;
    
    
-- DELETNG THE NULL VALUES IF EXISIT
--
DELETE  FROM RETAIL_SALES
WHERE 
	transactions_id IS NULL
    or
    sale_date IS NULL 
    or
    sale_time IS NULL 
    or
    customer_id IS NULL
    or
    gender IS NULL
    or
    age IS NULL
    or
    category IS NULL
    or
    quantiy IS NULL 
    or
    price_per_unit IS NULL
    or
    cogs IS NULL
    or
    total_sale IS NULL;
    
    
-- DATA EXPLORATION 

SELECT * FROM RETAIL_SALES;

#1 HOW MANY SALES WE HAVE?
SELECT COUNT(*) AS TOTAL_SALES FROM RETAIL_SALES;

#2 HOW MANY UNIQUES CUTOMERS WE HAVE?
SELECT COUNT(DISTINCT customer_id) AS TOTAL_CUSTOMERS FROM RETAIL_SALES;

#3 HOW MANY CATOGORIES WE HAVE IN THE LIST?
SELECT DISTINCT category FROM RETAIL_SALES;


-- Data Analysis & Bussiness key problems and answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'?

SELECT * FROM 
RETAIL_SALES
WHERE sale_date = '2022-11-05';


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022?

SELECT * FROM RETAIL_SALES
WHERE category = 'Clothing' 
		AND 
        DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
		AND 
        quantiy >= 4;
        

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category?

SELECT RETAIL_SALES.CATEGORY, 
		SUM(TOTAL_SALE) AS TOTAL_SALES,
        COUNT(*) AS TOTAL_ORDERS
FROM RETAIL_SALES
GROUP BY RETAIL_SALES.CATEGORY;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category?

SELECT ROUND(AVG(age), 2) AS AVG_AGE
FROM RETAIL_SALES
WHERE CATEGORY = 'BEAUTY';



-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000?
SELECT *
FROM RETAIL_SALES
WHERE total_sale >= 1000;



-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category?

SELECT GENDER,CATEGORY, COUNT(transactions_id)
FROM RETAIL_SALES
GROUP BY GENDER, CATEGORY;



-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year?

SELECT 
	EXTRACT(YEAR FROM sale_date) AS YEAR,
    EXTRACT(MONTH FROM sale_date) AS MONTH,
    ROUND(AVG(TOTAL_SALE),2) AS AVG_SALES,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date)  ORDER BY AVG(TOTAL_SALE) ) AS BEST_SELLING_YEAR
FROM RETAIL_SALES
GROUP BY 1, 2;
-- ORDER BY 1, 3 DESC;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales?

SELECT customer_id,
		SUM(total_sale) AS TOTAL_SALES
 FROM RETAIL_SALES
 GROUP BY customer_id
 ORDER BY TOTAL_SALES DESC
 LIMIT 5;



-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category?

SELECT category,
		COUNT(DISTINCT customer_id) AS CUSTOMER_ID,
        SUM(TOTAL_SALE) AS TOTAL_SALES
FROM RETAIL_SALES
GROUP BY category;



-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)?

SELECT  *, 
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN "MORNING"
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN "AFTERNOON"
        ELSE "EVENING"
	END AS SHIFT
FROM RETAIL_SALES;

