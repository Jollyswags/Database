# Write your MySQL query statement below
with cte as (
    select project_id, count(employee_id) as total
    from project
    group by project_id
),
max_emp as (
    select Max(total) as mx_emp from cte 
)
select project_id
from project
group by project_id
having count(employee_id) = (select mx_emp from max_emp)