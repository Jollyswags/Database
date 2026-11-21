
WITH RECURSIVE cte AS (
    -- Anchor query
    SELECT num, frequency, 1 AS cnt
    FROM Numbers

    UNION ALL

    -- Recursive query
    SELECT num, frequency, cnt + 1
    FROM cte
    WHERE cnt < frequency
),
ranked AS (
    SELECT
        num,
        ROW_NUMBER() OVER (ORDER BY num) AS rn
    FROM cte
),
total AS (
    SELECT SUM(frequency) AS total_count
    FROM Numbers
)

SELECT ROUND(AVG(num), 1) AS median
FROM ranked
CROSS JOIN total
WHERE rn IN (
    FLOOR((total_count + 1) / 2),
    FLOOR((total_count + 2) / 2)
)