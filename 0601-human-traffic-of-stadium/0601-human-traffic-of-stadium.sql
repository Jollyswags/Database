
WITH greater AS (
    SELECT id, visit_date, people
    FROM Stadium
    WHERE people >= 100
),
cte AS (
    SELECT *,
           LAG(id, 1) OVER (ORDER BY id) AS prev_id,
           LAG(id, 2) OVER (ORDER BY id) AS prev_prev_id,
           LEAD(id, 1) OVER (ORDER BY id) AS next_id,
           LEAD(id, 2) OVER (ORDER BY id) AS next_next_id
    FROM greater
)
SELECT id, visit_date, people
FROM cte
WHERE (prev_id = id - 1 AND prev_prev_id = id - 2)
   OR (prev_id = id - 1 AND next_id = id + 1)
   OR (next_id = id + 1 AND next_next_id = id + 2)
ORDER BY visit_date;

