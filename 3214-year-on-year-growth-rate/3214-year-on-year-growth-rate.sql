# Write your MySQL query statement below
WITH yearly_spend AS (
    SELECT
        YEAR(transaction_date) AS year,
        product_id,
        SUM(spend) AS curr_year_spend
    FROM user_transactions
    GROUP BY 1, 2
),

growth AS (
    SELECT
        year,
        product_id,
        curr_year_spend,
        LAG(curr_year_spend) OVER (PARTITION BY product_id ORDER BY year) AS prev_year_spend
    FROM yearly_spend
)

SELECT
    year,
    product_id,
    curr_year_spend,
    prev_year_spend,
    ROUND(
        (curr_year_spend - prev_year_spend) * 100 / prev_year_spend
    , 2) AS yoy_rate
FROM growth
ORDER BY 2, 1
