-- Data Exploration Analysis

SELECT count(*)  as total_sales from retail_sales;

-- How many unnique customer we have ? 
SELECT count(distinct customer_id) as total from retail_sales;

-- How many unique category we have ? 
SELECT distinct category from retail_sales;

-- Write a quary to retrive sales for 2022-11-25
SELECT *
FROM retail_sales
where sale_date = "2022-11-05";

-- Write a quary where sales are clothing and the transasation is more than 10
SELECT * 
FROM retail_sales
WHERE category = 'Clothing' 
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2023-11'
  AND quantiy >= 4;
-- Write a sql quary to calculate each category 
SELECT 
category,
sum(total_sale) as net_sales,
count(*) as total_order
FROM retail_sales
 group by category;
 
 -- Write a quary t find the average age purchaseing beauty category 
 
 Select round(avg(age),2) as avg_age
 from retail_sales
 where category = "beauty";
 
 -- Write a quary to find all transaction where the total_sales is greater than 1000
 
 select * from retail_sales
 where total_sale > 1000;
 
 
 -- Write t quary to findd total no of transacation made by each gender in each category
 
 select category, gender, count(*)  as total_trans
 from retail_sales
 group by category,gender;
 
 
 -- write  a quary to calculate the average sale for each month  find the  best selling  moonth in each year
 
SELECT 
  year,
  month,
  AVG_sales
FROM (
  SELECT 
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    ROUND(AVG(total_sale), 2) AS AVG_sales,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS sales_rank
  FROM retail_sales
  GROUP BY year, month
) AS ranked_months
WHERE sales_rank = 1;

-- write a quary to find the top 5 custmer based on the highest sales

select
     customer_id,
     sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by total_sales desc
limit 5;

-- write a quary to find the unique customer who purchased item from each categry 

select 
   category,
   count(distinct customer_id) as uniqe_customer 
from retail_sales
group by category;
   
-- write a  quary to create each shft and number of order ( example morning < 12, afternooon between 12 and 17 evening > 17 ) 

WITH hourly_sales AS (
  SELECT *,
    CASE 
      WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'morning'
      WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'afternoon'
      ELSE 'evening'
    END AS shift
  FROM retail_sales
)
SELECT 
  shift,
  COUNT(*) AS total_orders
FROM hourly_sales
GROUP BY shift;
