# Write your MySQL query statement below

with cte as (
    select customer_id, order_timestamp, order_rating,
    count(customer_id) over (partition by customer_id) as total_orders,
    count(case when hour(order_timestamp) between 11 and 13 then customer_id
            when hour(order_timestamp) between 18 and 20 then customer_id end) over (partition by customer_id) as peak_hour_orders,
    count(order_rating) over (partition by customer_id) as num_ratings,
    round(avg(order_rating) over (partition by customer_id), 2) as average_rating
    from restaurant_orders
)
select distinct customer_id, total_orders, round((100 * (peak_hour_orders / total_orders)), 0) as peak_hour_percentage, average_rating from cte where total_orders >= 3 and round(peak_hour_orders, 2) >= round(total_orders, 2) * 0.6 and average_rating >= 4.0 and num_ratings >= total_orders * 0.5 order by average_rating desc, customer_id desc