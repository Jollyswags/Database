# Write your MySQL query statement below
with cte as (
    select user_Id, sum(distance) as travelled_distance
    from rides
    group by user_id
)
select u.name,  coalesce(cte.travelled_distance,0) as travelled_distance
from users u
Left join
cte
on u.id=cte.user_id
order by cte.travelled_distance desc, u.name