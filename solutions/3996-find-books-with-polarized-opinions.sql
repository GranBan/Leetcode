# Write your MySQL query statement below

with cte as (
    select book_id, session_rating, sum(case when session_rating >= 4 then 1 else 0 end) over (partition by book_id) as greater_rating,
        sum(case when session_rating <= 2 then 1 else 0 end) over (partition by book_id) as lesser_rating,
        max(session_rating) over (partition by book_id) as max_rating,
        min(session_rating) over (partition by book_id) as min_rating,
        sum(case when session_rating <= 2 then 1 when session_rating >= 4 then 1 else 0 end) over (partition by book_id) as num_extreme_rating,
        count(session_rating) over (partition by book_id) as num_sessions
    from reading_sessions
)
select distinct b.*, c.max_rating - c.min_rating as rating_spread, round(c.num_extreme_rating / c.num_sessions, 2) as polarization_score from cte c join books b on c.book_id = b.book_id
where num_sessions >= 5 and round(c.num_extreme_rating / c.num_sessions, 2) >= 0.60 and greater_rating >= 1 and lesser_rating >= 1
order by polarization_score desc, b.title desc