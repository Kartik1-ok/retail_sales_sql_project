select * from retail_sales; 
#data cleaning
select * from retail_sales
where transactions_id is null;

select * from retail_sales
where transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantity is null
or price_per_unit is null
or cogs is null
or total_sale is null;

delete from retail_sales
where transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantity is null
or price_per_unit is null
or cogs is null
or total_sale is null;

#data exploration
#1. how many sales we have
select count(*) as total_sales from retail_sales;

#2. How many customers we have
select count(customer_id) total_customers from retail_sales;

#3. How many unique customers we have
select count(distinct customer_id) actual_customers from retail_sales;

#4. How many unique categories we have
select count(distinct category) total_categories from retail_sales;

#5. what categories do we have
select distinct category from retail_sales;

#Data Analyis and business key problems
#!. Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select * from retail_sales
where sale_date = "2022-11-05";

#2. Write a SQL query to retrieve all transactions where the category is 'Clothing' 
#   and the quantity sold is more than 4 in the month of Nov-2022:
select * from retail_sales 
where category like '%clothing%' and quantity >= 4 
and sale_date < "2022-11-30" and sale_date > "2022-11-01";

#3. Write a SQL query to calculate the total sales (total_sale) 
#   for each category.:
select category, sum(total_sale) total_sales, count(*) total_orders
from retail_sales
group by  category;

#4. Write a SQL query to find the average age of customers 
#   who purchased items from the 'Beauty' category.:
select category, round(avg(age),0) average_age 
from retail_sales
where category like '%beauty%'
group by category;

#5. Write a SQL query to find all transactions 
#   where the total_sale is greater than 1000.:
select transactions_id, total_sale from retail_sales
where total_sale > 1000;

#6. Write a SQL query to find the total number of transactions (transaction_id) 
#   made by each gender in each category.:
select category, gender, count(transactions_id) total_transactions
from retail_sales
group by category, gender;

#7. Write a SQL query to calculate the average sale for each month. 
#   Find out best selling month in each year:
select years, months, total_sales from
(select year(sale_date) years, month(sale_date) months, 
round(avg(total_sale),0) total_sales, 
rank() over(partition by year(sale_date) order by round(avg(total_sale),0) desc) as rnk
from retail_sales
group by  year(sale_date), month(sale_date)) as t1
where rnk = 1;

#8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
select customer_id, sum(total_sale) net_sales from retail_sales
group by customer_id
order by net_sales desc
limit 5;

#9. Write a SQL query to find the number of unique customers
#   who purchased items from each category.:
select category, count(distinct customer_id)
from retail_sales
group by category;

#10. Write a SQL query to create each shift and number of orders 
#   (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
with hourly_sale as (select *, Case 
          when hour(sale_time) < 12 then "morning"
          when hour(sale_time) between 12 and 17 then "afternoon"
          else "evening"
          end as shift 
from retail_sales)

select shift, count(*) total_orders
from hourly_sale
group by shift;

#End of project


