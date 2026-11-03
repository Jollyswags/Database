# Write your MySQL query statement below
select stock_name, Sum(Case when operation='Buy' then price*-1
                   else price end) as capital_gain_loss
from stocks
group by stock_name