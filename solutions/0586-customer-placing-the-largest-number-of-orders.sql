# Write your MySQL query statement below
#with cte as (select count(customer_number) as cus_num from Orders group by customer_number)
#select max(cte.cus_num) as customer_number

select customer_number from Orders
group by 1 order by count(1) desc limit 1