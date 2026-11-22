# Write your MySQL query statement below
with cte as (
    select seller_id, sum(price) as total
    from sales
    group by seller_id
),
cte1 as (
    select seller_id, total, dense_rank() over(order by total desc) as rk
    from cte
)
select seller_id
from cte1
where rk=1
