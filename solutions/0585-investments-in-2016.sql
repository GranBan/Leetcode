# Write your MySQL query statement below
#make 2 tables - same_tiv2015 and diff_city. then select from those with decimal and round.

with same_tiv_2015 as (select * from Insurance group by tiv_2015 having count(tiv_2015) > 1),
diff_city as (select * from Insurance group by lat, lon having count(1) = 1)
select round(sum(i.tiv_2016), 2) as tiv_2016 from Insurance i
join same_tiv_2015 s on i.tiv_2015 = s.tiv_2015
join diff_city d on i.pid = d.pid