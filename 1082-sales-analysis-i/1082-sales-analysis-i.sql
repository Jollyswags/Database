# Write your MySQL query statement below
with cte as (
    select seller_id, sum(price) as sm
    from sales
    group by seller_id
),
cte2 as (select * , dense_rank() over (order by sm desc) rk
from cte)
select seller_id
from cte2
where rk=1
