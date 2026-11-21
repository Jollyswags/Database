# Write your MySQL query statement below

# find consecutive days number of each customer

# first find the earliest transaction date 

# calculate the day_diff between the transaction date and the earliest day

# then calculate the diff between the day_diff and the row_number ---diff

# count diff group by customer and diff


with CTE1 as (
  select *, datediff(transaction_date, min(transaction_date) over ()) as day_diff, row_number() over (order by customer_id, transaction_date) as r
from Transactions
),

CTE2 as (
  select customer_id, count(*) as diff
from CTE1
group by customer_id, cast(r as signed)-day_diff
)

select distinct  customer_id 
from CTE2
where diff = (select max(diff) from CTE2)
order by 1