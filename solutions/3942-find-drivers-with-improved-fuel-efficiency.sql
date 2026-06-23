# Write your MySQL query statement below

-- with first_half as (
--     select driver_id, round(avg(distance_km / fuel_consumed), 4) as first_half_avg from trips where EXTRACT(MONTH FROM trip_date) BETWEEN 1 AND 6 group by driver_id
-- ),
-- second_half as (
--     select driver_id, round(avg(distance_km / fuel_consumed), 4) as second_half_avg from trips where EXTRACT(MONTH FROM trip_date) BETWEEN 7 AND 12 group by driver_id
-- ),
-- consol as (
--     select f.driver_id, f.first_half_avg, s.second_half_avg, round(s.second_half_avg - f.first_half_avg, 2) as efficiency_improvement from first_half f join second_half s on f.driver_id = s.driver_id
-- )
-- select c.driver_id, d.driver_name, round(c.first_half_avg, 2) as first_half_avg, round(c.second_half_avg, 2) as second_half_avg, c.efficiency_improvement from consol c join drivers d on d.driver_id = c.driver_id where efficiency_improvement > 0 order by 5 desc, 2 asc


with consol as (
    select driver_id, 
    AVG(CASE WHEN MONTH(trip_date) BETWEEN 1 AND 6 THEN distance_km/fuel_consumed END) as first_half_avg, 
    AVG(CASE WHEN MONTH(trip_date) BETWEEN 7 AND 12 THEN distance_km/fuel_consumed END) as second_half_avg from trips group by driver_id
)
select c.driver_id, d.driver_name, 
        round(c.first_half_avg, 2) as first_half_avg, 
        round(c.second_half_avg, 2) as second_half_avg, 
        round(c.second_half_avg - c.first_half_avg, 2) as efficiency_improvement 
from consol c join drivers d on d.driver_id = c.driver_id where c.second_half_avg > c.first_half_avg order by 5 desc, 2 asc