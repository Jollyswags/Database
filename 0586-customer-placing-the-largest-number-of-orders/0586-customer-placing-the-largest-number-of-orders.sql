# Write your MySQL query statement below
with cte as (
    select customer_number, count(order_number) as cnt 
    from orders
    group by customer_number
)
#select * from cte
select customer_number
from cte
order by cnt desc
limit 1