WITH cte AS (
    SELECT
        *,
        LAG(action) OVER(PARTITION BY user_id
                    ORDER BY action_date) AS previous_action
    FROM activity
),
cte1 AS (
    SELECT
        *,
        CASE WHEN action <> cte.previous_action
             THEN 1 ELSE 0 END AS change_check
    FROM cte
),
cte2 AS (
    SELECT
        *,
        SUM(change_check) OVER(PARTITION BY user_id
                          ORDER BY action_date) AS streak_group
    FROM cte1
),
result AS (
    SELECT
        user_id,
        action,
        COUNT(*) AS streak_length,
        MIN(action_date) AS start_date,
        MAX(action_date) AS end_date
    FROM cte2
    GROUP BY user_id, action, streak_group
    HAVING COUNT(*) >= 5
),
streak_rank AS (
    SELECT 
        *,
        ROW_NUMBER() OVER(PARTITION BY user_id
                     ORDER BY streak_length DESC) AS rn
    FROM result
)
SELECT
    user_id,
    action,
    streak_length,
    start_date,
    end_date
FROM streak_rank
WHERE rn = 1 -- Longest streak if multiple streaks exist
ORDER BY 3 DESC, 1;



