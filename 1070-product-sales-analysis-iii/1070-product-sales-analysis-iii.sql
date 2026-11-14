# Write your MySQL query statement below
with cte as (select product_id, min(year) as first_year
             from sales
             group by product_id)
select c.product_id,c.first_year, s.quantity, s.price
from cte c
left join sales s
on c.product_id=s.product_id
where s.year=c.first_year