# Write your MySQL query statement below

with seasons as (
    select s.product_id, p.product_name, p.category, s.sale_date, s.quantity, s.price, case
    when month(s.sale_date) between 03 and 05 then 'Spring'
    when month(s.sale_date) between 06 and 08 then 'Summer'
    when month(s.sale_date) between 09 and 11 then 'Fall'
    else 'Winter' end as season from sales s join products p on s.product_id = p.product_id
),

agg as (
    select *, sum(quantity) over (partition by category, season) as total_quantity, 
    sum(s.quantity * s.price) over (partition by category, season) as total_revenue
    from seasons s
),

cte as (
    select season, category, total_quantity, total_revenue,
    rank() over (partition by season order by total_quantity desc, total_revenue desc, category) as rn
    from agg
)

select season, category, total_quantity, total_revenue from cte where rn = 1 group by season