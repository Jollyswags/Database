# Write your MySQL query statement below
WITH ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY session_start
        ) AS rn
    FROM Sessions
)

SELECT
    user_id,
    COUNT(*) AS sessions_count
FROM ranked
WHERE user_id IN (
    SELECT user_id
    FROM ranked
    WHERE rn = 1 AND session_type = 'Viewer'
)
AND session_type = 'Streamer'
GROUP BY user_id
ORDER BY 2 DESC, 1 DESC
