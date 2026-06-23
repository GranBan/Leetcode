# Write your MySQL query statement below

with cte as (
    select user_id, 
    LAST_VALUE(plan_name) OVER (PARTITION BY user_id ORDER BY event_date 
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as current_plan,
    LAST_VALUE(monthly_amount) OVER (PARTITION BY user_id ORDER BY event_date 
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as current_monthly_amount,
    Max(monthly_amount) over (partition by user_id rows between UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as max_historical_amount,
    sum(event_type = 'downgrade') over (partition by user_id) as down_count,
    min(event_date) over (partition by user_id) as start_date,
    max(event_date) over (partition by user_id) as latest_date,
    last_value(event_type) over (partition by user_id ORDER BY event_date 
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as check_canc
    from subscription_events
)

-- select distinct c.user_id, c.current_plan, c.current_monthly_amount, c.max_historical_amount, datediff(c.latest_date, c.start_date) as days_as_subscriber from cte c where c.check_canc != 'cancel' and c.down_count >= 1 and datediff(c.latest_date, c.start_date) >= 60 and c.current_monthly_amount < c.max_historical_amount/2 order by days_as_subscriber desc, user_id

select distinct c.user_id, c.current_plan, c.current_monthly_amount, c.max_historical_amount, datediff(c.latest_date, c.start_date) as days_as_subscriber from cte c where c.check_canc != 'cancel' and c.down_count >= 1 and datediff(c.latest_date, c.start_date) >= 60 and c.current_monthly_amount < c.max_historical_amount/2 order by days_as_subscriber desc, user_id