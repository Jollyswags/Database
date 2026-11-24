# Write your MySQL query statement below
with most_reacted_users as (
    select user_id,
        count(content_id) as total_cnt
    from reactions
    group by user_id
    having count(content_id) > 4
)
select r.user_id,
    r.reaction as dominant_reaction,
    round(count(r.content_id) / total_cnt, 2) as reaction_ratio
from most_reacted_users m
    join reactions r on r.user_id = m.user_id
group by r.user_id, r.reaction
having reaction_ratio > 0.59
order by reaction_ratio desc, r.user_id