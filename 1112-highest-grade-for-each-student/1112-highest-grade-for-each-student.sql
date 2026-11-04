# Write your MySQL query statement below
with cte as (
    select student_id, course_id, grade, dense_rank() over (partition by student_id order by grade desc) as rk
    from enrollments
    
),
cte1 as (
    select student_id, course_id, grade, rank() over (partition by student_id order by course_id) as rk2
    from cte
    where rk=1
)
select student_id, course_id, grade
from cte1
where rk2=1