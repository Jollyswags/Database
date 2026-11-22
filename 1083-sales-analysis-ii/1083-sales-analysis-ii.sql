# Write your MySQL query statement below

select distinct buyer_id
from sales 
where buyer_id in ( select s.buyer_id
                     from sales s
                     left join product p
                     on s.product_id=p.product_id
                     where p.product_name = 'S8')
and buyer_id not in ( select s.buyer_id
                     from sales s
                     left join product p
                     on s.product_id=p.product_id
                     where p.product_name = 'iPhone')

