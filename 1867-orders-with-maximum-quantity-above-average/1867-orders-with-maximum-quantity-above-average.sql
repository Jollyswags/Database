# Write your MySQL query statement below
with cte as (
    select order_id, max(quantity) as maxq, avg(quantity) as avgq
    from ordersdetails
    group by order_id
)
select order_id 
from cte 
where maxq>(select max(avgq) from cte)
