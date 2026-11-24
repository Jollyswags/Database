# Write your MySQL query statement below
select sale_date, (sum(case when fruit='apples' then sold_num Else 0 end)-sum(case when fruit='oranges' then sold_num Else 0 end)) as diff
from sales
group by sale_date