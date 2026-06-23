# Write your MySQL query statement below

with cte as (
    select user_id, reaction, count(*) as reaction_count from reactions group by user_id, reaction
),
cte2 as (
    select *,
        sum(reaction_count) over (partition by user_id) as total_reactions,
        row_number() over (partition by user_id order by reaction_count desc) as rn
        from cte
)

select user_id, reaction as dominant_reaction, round(reaction_count/total_reactions, 2) as reaction_ratio from cte2 where rn = 1 and reaction_count >= total_reactions * 0.6 and total_reactions >= 5 order by reaction_ratio desc, user_id