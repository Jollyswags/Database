# Write your MySQL query statement below
with cte as (
    select num, count(num) as counts
    from mynumbers
    group by num
    having count(num)=1
)
select max(num) as num
from cte