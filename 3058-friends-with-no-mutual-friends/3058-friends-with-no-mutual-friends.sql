# Write your MySQL query statement below
WITH bidirectional AS (
    SELECT user_id1 AS user_id, user_id2 AS friend_id
    FROM Friends

    UNION ALL

    SELECT user_id2 AS user_id, user_id1 AS friend_id
    FROM Friends
),

mutual AS (
    SELECT
        f1.user_id AS user_id1,
        f2.user_id AS user_id2
    FROM bidirectional f1
    JOIN bidirectional f2
        ON f1.friend_id = f2.friend_id
)

SELECT
    f.user_id1,
    f.user_id2
FROM Friends f
LEFT JOIN mutual m
    ON f.user_id1 = m.user_id1
    AND f.user_id2 = m.user_id2
WHERE m.user_id1 IS NULL
ORDER BY f.user_id1, f.user_id2
