# Write your MySQL query statement below
#Select distinct L1.num as ConsecutiveNums FROM Logs L1, Logs L2, Logs L3
#where L1.id = L2.id - 1 and L2.id = L3.id - 1
#and L1.num = L2.num and L2.num = L3.num;

with cte as (
    select num, lag(num, 1) over (order by id) as prev1,
        lag(num, 2) over (order by id) as prev2 
    from Logs
)
select distinct num as ConsecutiveNums from cte where num = prev1 and num = prev2