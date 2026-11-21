# Write your MySQL query statement below
select student_id
from
(
    select
        s.student_id, 
        case when mandatory='yes' and grade = 'A' then 1 
        when mandatory='yes' and (grade != 'A' or grade is null) then 2 else 0 end as man_fg, 
        case when mandatory='no' and grade in ('A','B') then 1
        when mandatory='no' and grade not in ('A','B') then 2 else 0 end as opt_fg  
        from students s
        join courses c
        on s.major = c.major
        left join enrollments e
        on s.student_id = e.student_id and c.course_id = e.course_id
) a
where student_id in (
    select student_id
    from enrollments
    group by student_id
    having avg(GPA) >= 2.5
    )
group by student_id
having max(man_fg) = 1 and max(opt_fg) = 1 and sum(opt_fg) >= 2
order by student_id
