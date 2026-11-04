# Write your MySQL query statement below
with cte as (select dept_id, count(distinct student_id) as cntstud
             from student
             group by dept_id)

select d.dept_name as dept_name, coalesce(cte.cntstud,0) as student_number
from cte
right join
department d
on (cte.dept_id=d.dept_id)
order by student_number desc, dept_name