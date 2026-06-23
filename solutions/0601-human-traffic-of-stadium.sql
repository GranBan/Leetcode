# Write your MySQL query statement below

with cte as (
    select *, 
        lag(people, 1) over (order by id) as pre_people, 
        lead(people, 1) over (order by id) as next_people, 
        lag(people, 2) over (order by id) as pre_pre_people, 
        lead(people, 2) over (order by id) as next_next_people, 
        lag(id, 1) over (order by id) as pre_id, 
        lead(id, 1) over (order by id) as next_id
    from Stadium
)
select id, visit_date, people from cte where (people >= 100 and pre_people >= 100 and next_people >= 100) or (people >= 100 and pre_people >= 100 and pre_pre_people >= 100) or (people >= 100 and next_people >= 100 and next_next_people >= 100)