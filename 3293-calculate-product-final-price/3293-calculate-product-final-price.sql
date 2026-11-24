# Write your MySQL query statement below
select product_id ,
price -((price*coalesce(discount,0))*1.00/100) as final_price ,
p.category
from products p left join discounts d 
on p.category =d.category 
order by product_id asc 