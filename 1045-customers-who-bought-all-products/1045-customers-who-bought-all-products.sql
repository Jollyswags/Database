# Write your MySQL query statement below
with cte as (
    select customer_id, count(distinct product_key) as "prod"
    from customer
    group by customer_id
)
select customer_id
from cte
where prod = (select count(product_key) from product)