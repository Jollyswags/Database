# Write your MySQL query statement below
with cte as (select s.product_id, p.product_name, Min(s.sale_date) as min_date, max(s.sale_date) as max_date
from Sales s
left join product p
on s.product_id=p.product_id
group by s.product_id, p.product_name)

select product_id, product_name
from cte
where min_date>= '2019-01-01'
and max_date<= '2019-03-31'



