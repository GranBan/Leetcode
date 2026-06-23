# Write your MySQL query statement below

with cat as (
    select "Low Salary" as category union all select "Average Salary" union all select "High Salary"
),
cte1 as (
    select case when income < 20000 then "Low Salary" 
                when income > 50000 then "High Salary" 
                else "Average Salary" end as category 
    from Accounts
)

select c.category, count(cte1.category) as accounts_count from cat c left join cte1 on c.category = cte1.category group by 1

-- select "Low Salary" as category, count(1) as accounts_count from Accounts where income < 20000
-- union all
-- select "Average Salary" as category, count(1) as accounts_count from Accounts where income between 20000 and 50000
-- union all
-- select "High Salary" as category, count(1) as accounts_count from Accounts where income > 50000