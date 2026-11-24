# Write your MySQL query statement below
select distinct c.title
from  content c
right join
tvprogram t
on c.content_id=t.content_id
where c.kids_content='Y'
and c.content_type='movies'
and Month(t.program_date)=6
and Year(t.program_date)=2020
