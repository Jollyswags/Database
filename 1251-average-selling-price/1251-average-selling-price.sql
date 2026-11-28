select u.product_id,
       round(ifnull(sum(u.units*p.price)/sum(u.units),0),2) as average_price
from UnitsSold u
left join Prices p
    on u.product_id = p.product_id
    and u.purchase_date between p.start_date and p.end_date
group by u.product_id;