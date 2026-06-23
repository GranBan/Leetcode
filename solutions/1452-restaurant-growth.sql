# Write your MySQL query statement below
WITH cte1 AS (
    SELECT visited_on, SUM(amount) AS daily_amount
    FROM Customer
    GROUP BY visited_on
),
cte2 as (
    select *, sum(daily_amount) over (order by visited_on rows between 6 preceding and current row) as total_amount from cte1
),
cte3 as (
    select *, round(1.00 * total_amount / 7, 2) as average_amount from cte2
)
select visited_on, total_amount as amount, average_amount from cte3
where visited_on >= (select min(visited_on) + interval 6 day from Customer)