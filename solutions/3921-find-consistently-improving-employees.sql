# Write your MySQL query statement below

with cte as (
    select employee_id, row_number() over (partition by employee_id order by review_date desc) as rn, rating as first_rating from performance_reviews
),

filter_3 as (select *, LAG(first_rating) OVER (PARTITION BY employee_id ORDER BY rn) AS second_rating, LAG(first_rating, 2) OVER (PARTITION BY employee_id ORDER BY rn) as latest_rating from cte where rn <= 3)

select f.employee_id, e.name, f.latest_rating - f.first_rating as improvement_score from filter_3 f join employees e on e.employee_id = f.employee_id where rn = 3 and first_rating < second_rating and second_rating < latest_rating order by 3 desc, e.name