# Write your MySQL query statement below
with cte as (select managerId from Employee group by managerId having count(managerId) >= 5)
select e.name from Employee e
join cte on e.id = cte.managerId