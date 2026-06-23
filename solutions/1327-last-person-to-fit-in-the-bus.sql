# Write your MySQL query statement below
-- select person_name from (select person_name, sum(weight) over (order by turn) as cumulative_weight from Queue) as c
-- where cumulative_weight <= 1000
-- order by cumulative_weight desc limit 1











with cte as (
    select *, sum(weight) over (order by turn rows between unbounded preceding and current row) as Total_weight from Queue
)

select person_name from cte where Total_weight <= 1000 order by Total_weight desc limit 1