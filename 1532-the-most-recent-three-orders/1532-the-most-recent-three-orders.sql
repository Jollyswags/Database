# Write your MySQL query statement below
with cte as (
select customer_id, order_id, order_date, rank() over(partition by customer_id order by order_date desc) as rk
from orders)

select c.name as customer_name, cte.customer_id, cte.order_id, cte.order_date
from cte
left join
customers c
on cte.customer_id= c.customer_id
where cte.rk<=3
order by name, customer_id, order_date desc