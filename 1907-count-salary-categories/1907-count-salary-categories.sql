WITH cte AS (
    SELECT account_id,
        CASE
            WHEN income < 20000 THEN 'Low Salary'
            WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
            WHEN income > 50000 THEN 'High Salary'
        END AS category
    FROM Accounts
),
counts AS (
    SELECT category, COUNT(account_id) AS accounts_count
    FROM cte
    GROUP BY category
)
SELECT 'Low Salary' AS category,
       COALESCE(MAX(CASE WHEN category = 'Low Salary'
                         THEN accounts_count END), 0) AS accounts_count
FROM counts

UNION ALL

SELECT 'Average Salary',
       COALESCE(MAX(CASE WHEN category = 'Average Salary'
                         THEN accounts_count END), 0)
FROM counts

UNION ALL

SELECT 'High Salary',
       COALESCE(MAX(CASE WHEN category = 'High Salary'
                         THEN accounts_count END), 0)
FROM counts;