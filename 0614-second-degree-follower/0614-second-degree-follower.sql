# Write your MySQL query statement below
with follows_cte as (select distinct follower from follow)
select followee as "follower", count(distinct follower) as num
from follow
where followee in (select* from follows_cte)
group by followee
order by followee