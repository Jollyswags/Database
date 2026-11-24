# Write your MySQL query statement below
WITH previous AS (
    SELECT
        *,
        LAG(free) OVER(
            ORDER BY seat_id
        ) AS prev
    FROM Cinema
),

flag AS (
    SELECT
        *,
        IF(free = 1 AND (prev = 0 OR prev IS NULL), 1, 0) AS flag
    FROM previous
),

streak AS (
    SELECT
        *,
        SUM(flag) OVER(
            ORDER BY seat_id
        ) AS streak
    FROM flag
    WHERE free = 1
)

SELECT
    first_seat_id,
    last_seat_id,
    consecutive_seats_len
FROM (
    SELECT
        MIN(seat_id) AS first_seat_id,
        MAX(seat_id) AS last_seat_id,
        COUNT(*) AS consecutive_seats_len,
        RANK() OVER(
            ORDER BY COUNT(*) DESC
        ) AS rn
    FROM streak
    GROUP BY streak
    ) AS t
WHERE rn = 1

