# Write your MySQL query statement below
#Select d.name as Department, e.name as Employee, e.salary as Salary FROM Employee as e
#Join Department as d ON e.departmentId = d.id
#where (departmentId, salary) in (Select departmentId, max(e.salary) FROM Employee as e group by departmentId);

with cte as (
    select e.*, d.name as dept, dense_rank() over (partition by d.name order by salary desc) as ranking
    from Employee e join Department d on e.departmentId = d.id
)
select dept as Department, name as Employee, salary as Salary
from cte where ranking = 1