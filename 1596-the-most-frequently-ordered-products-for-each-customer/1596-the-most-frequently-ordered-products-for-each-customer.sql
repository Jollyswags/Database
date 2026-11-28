# Write your MySQL query statement below
with cte as (
    select customer_id, product_id, dense_rank() over (partition by customer_id order by count(product_id) desc) as rk
    from orders
    group by customer_id, product_id
)
select cte.customer_id, cte.product_id, p.product_name
from cte
left join products p
on cte.product_id=p.product_id
where cte.rk=1