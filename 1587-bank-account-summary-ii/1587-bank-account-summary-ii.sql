# Write your MySQL query statement below
with cte as (select account, sum(amount) as amt
from transactions
group by account)

select u.name, cte.amt as balance
from users u
left join
cte 
on u.account=cte.account
where cte.amt>10000
