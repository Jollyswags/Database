# Write your MySQL query statement below
with cte as (
    select *, Rank() over (partition by player_id order by event_date) as rk
    from activity
)
select player_id, device_id from cte
where rk=1