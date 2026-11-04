# Write your MySQL query statement below
with cte as (
select *, rank() over (partition by Date(day) order by amount desc) as rk
from transactions
)
select transaction_id
from cte
where rk=1
order by transaction_id