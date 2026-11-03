# Write your MySQL query statement below
with cte as (select person_name, sum(weight) over (order by turn ) as rw
from queue)
select person_name
from cte
where rw <=1000
order by rw desc
limit 1
