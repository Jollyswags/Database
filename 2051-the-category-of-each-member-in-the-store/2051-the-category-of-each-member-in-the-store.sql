/* Write your T-SQL query statement below */





with member_visit as (
select member_id ,count(p.visit_id)*100.00 /count(*) as cr
from visits v left join purchases p 
on p.visit_id =v.visit_id
group by member_id )



select m.member_id,m.name ,case when cr >= 80 then 'Diamond' 
                                when cr>= 50 then 'Gold'
                                when cr<50 then 'Silver' 
                                else 'Bronze' end as category
from members m left join member_visit mv 
on mv.member_id =m.member_id
