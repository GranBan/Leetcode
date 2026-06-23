# Write your MySQL query statement below

-- with trial as (
--     select user_id, activity_date, activity_type,
--     avg(activity_duration) over (partition by user_id, activity_type) as trial_avg_duration
--     from UserActivity where activity_type = 'free_trial'
-- ),
-- paid as (
--     select user_id, activity_date, activity_type,
--     avg(activity_duration) over (partition by user_id, activity_type) as paid_avg_duration
--     from UserActivity where activity_type = 'paid'
-- )
-- select distinct t.user_id, round(t.trial_avg_duration, 2) as trial_avg_duration, round(p.paid_avg_duration, 2) as paid_avg_duration from trial t join paid p on t.user_id = p.user_id

select user_id, 
    round(avg(case when activity_type = 'free_trial' then activity_duration end), 2) as trial_avg_duration,
    round(avg(case when activity_type = 'paid' then activity_duration end), 2) as paid_avg_duration
from UserActivity
group by user_id
having paid_avg_duration is not null
order by user_id