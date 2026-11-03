# Write your MySQL query statement below
with cte as (
    select customer_id, delivery_id, order_date, case when order_date=customer_pref_delivery_date then 'immediate'
    else 'scheduled'
    end as type
    from delivery
),
cte2 as (
    select customer_id, Min(order_date) as firstdate
    from delivery
    group by customer_id
),
cte3 as (
    select cte.customer_id, cte.delivery_id, cte.order_date, cte.type
    from cte 
    right join
    cte2
    on (cte.customer_id=cte2.customer_id)
    and (cte.order_date=cte2.firstdate)
)

SELECT 
    ROUND(
        SUM(CASE WHEN type = 'immediate' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS immediate_percentage
FROM cte3;