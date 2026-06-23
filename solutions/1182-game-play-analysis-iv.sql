# Write your MySQL query statement below

-- with first_login as (select player_id, min(event_date) as event_date from Activity Group by player_id),
-- compare as (select a.* from Activity a Join first_login f on a.player_id = f.player_id where datediff(a.event_date, f.event_date) = 1)
-- select
-- round(
--     (select count(distinct player_id) from compare) / (select count(distinct player_id) from first_login), 2) as fraction











-- with first_login as (
--     select player_id, min(event_date) as first_login from Activity group by player_id order by player_id
-- ),

-- cte as (
--     select a.player_id as player_id from Activity a join first_login f on a.player_id = f.player_id where a.event_date = f.first_login + Interval 1 day
-- )

-- select round(count(cte.player_id) / count(f.player_id), 2) as fraction from first_login f left join cte on f.player_id = cte.player_id



select round(count(player_id) / (select count(distinct player_id) from Activity), 2) as fraction from Activity
where (player_id, date_sub(event_date, interval 1 day)) in (
    SELECT player_id, MIN(event_date) AS first_login FROM ACTIVITY GROUP BY player_id)