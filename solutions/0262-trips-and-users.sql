# Write your MySQL query statement below

with cte1 as (
    select client_id, driver_id, status, request_at, 
        count(status) over (partition by request_at) as total_trips, 
        sum(case when status = "cancelled_by_driver" then 1 when status = "cancelled_by_client" then 1 else 0 end) over (partition by request_at) as num_cancels
    from Trips
    where client_id in (select users_id from Users where banned = "No") and driver_id in (select users_id from Users where banned = "No")
)
select distinct request_at as `Day`, round(num_cancels / total_trips, 2) as "Cancellation Rate" from cte1 where request_at between "2013-10-01" and "2013-10-03"