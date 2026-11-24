# Write your MySQL query statement below
SELECT
    pp.product1_id,
    pp.product2_id,
    pInfo1.category AS product1_category,
    pInfo2.category AS product2_category,
    pp.customer_count
FROM (
    SELECT 
        pp1.product_id AS product1_id, 
        pp2.product_id AS product2_id, 
        COUNT(DISTINCT pp1.user_id) AS customer_count
    FROM productPurchases AS pp1
    INNER JOIN productPurchases AS pp2
    ON 
        pp1.user_id = pp2.user_id
        AND pp1.product_id < pp2.product_id
    GROUP BY pp1.product_id, pp2.product_id
    HAVING COUNT(DISTINCT pp1.user_id) >= 3
) AS pp
INNER JOIN productInfo AS pInfo1
ON pInfo1.product_id = pp.product1_id
INNER JOIN productInfo AS pInfo2
ON pInfo2.product_id = pp.product2_id
ORDER BY customer_count DESC, product1_id ASC, product2_id ASC