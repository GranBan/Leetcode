# Write your MySQL query statement below

-- with cte1 as (
--     select u.name from Users u where u.user_id in (
--         select mr.user_id from MovieRating mr group by 1 order by count(1) desc, name limit 1
--     )
-- )

(select u.name as results from Users u
join MovieRating mr on u.user_id = mr.user_id
group by mr.user_id
order by count(mr.user_id) desc, 1 limit 1)
Union all
(select m.title as results from Movies m
join MovieRating mr on m.movie_id = mr.movie_id
where mr.created_at between '2020-02-01' and '2020-02-29'
group by mr.movie_id order by avg(mr.rating) desc, 1 asc limit 1)