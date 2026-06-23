# Write your MySQL query statement below

with cte as (
    select employee_id, 
        duration_hours, 
        YEARWEEK(meeting_date, 3) as weeks 
    from meetings
),
total_time as (
    select employee_id, 
        weeks, 
        sum(duration_hours) as total_meeting_hours 
    from cte 
    group by employee_id, weeks
),
over_booked as (
    select *, 
        count(case when total_meeting_hours > 20 then 1 end) over (partition by employee_id) as num_over_booked_weeks 
    from total_time
)
select distinct o.employee_id, 
    e.employee_name, 
    e.department, 
    o.num_over_booked_weeks as meeting_heavy_weeks 
from over_booked o join employees e 
on o.employee_id = e.employee_id 
where o.num_over_booked_weeks >= 2 
order by meeting_heavy_weeks desc, employee_name asc