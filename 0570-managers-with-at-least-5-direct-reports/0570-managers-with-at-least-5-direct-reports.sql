# Write your MySQL query statement below
with cte as (
    select managerId from employee
    group by managerid
    having count(distinct id)>=5
)
select e.name as name
from cte c
 join
employee e
on c.managerid=e.id