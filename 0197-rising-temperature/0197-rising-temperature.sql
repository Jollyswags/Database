# Write your MySQL query statement below
with cte as (
select *, lag(recorddate,1) over (order by recorddate) as prevdate, lag(temperature,1) over (order by recorddate) as prevtemp
from weather
)

select id from cte
where recorddate= Date_add(prevdate, Interval 1 day)
and temperature>prevtemp