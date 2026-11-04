# Write your MySQL query statement below
with cte as ( select candidateid, count(id) as total from vote group by candidateid order by total desc limit 1)
select name from candidate
where id = (select candidateid from cte)
