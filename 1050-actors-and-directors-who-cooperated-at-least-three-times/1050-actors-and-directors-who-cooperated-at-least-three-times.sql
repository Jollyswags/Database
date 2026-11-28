# Write your MySQL query statement below
with cte as (
    select distinct actor_id, director_id
    from actordirector
    group by actor_id,director_id
    having count(*)>=3)

select * from cte