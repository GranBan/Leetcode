# Write your MySQL query statement below
-- with c1 as (select * from Delivery where order_date = customer_pref_delivery_date),
-- c2 as (select delivery_id, customer_id, order_date as first_order_date, customer_pref_delivery_date from Delivery where (customer_id, order_date) in (select customer_id, min(order_date) from Delivery group by customer_id))
-- select round(100 * count(c1.customer_id) / count(c2.customer_id), 2) as immediate_percentage from c2
-- left join c1 on c2.delivery_id = c1.delivery_id











with cte1 as (select * from Delivery where (customer_id, order_date) in (select customer_id, min(order_date) from Delivery group by customer_id))

select round(100.00 * sum(order_date = customer_pref_delivery_date) / count(*), 2) as immediate_percentage from cte1