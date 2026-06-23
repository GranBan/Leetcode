# Write your MySQL query statement below
#select query_name,
#round(avg(1.00 * rating / position), 2) as quality,
#round(100.00 * sum(case when rating < 3 then 1 else 0 end) / count(1), 2) as poor_query_percentage
#from Queries group by query_name













select query_name,
round(avg(1.00 * rating/position), 2) quality,
round(100.00 * sum(rating < 3) / sum(rating > 0), 2) poor_query_percentage from Queries group by 1