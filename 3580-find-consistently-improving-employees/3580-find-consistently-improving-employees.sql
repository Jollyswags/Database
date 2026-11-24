# Write your MySQL query statement below
WITH ranked_reviews AS (
    SELECT
        employee_id,
        rating,
        review_date,
        ROW_NUMBER() OVER (
            PARTITION BY employee_id
            ORDER BY review_date DESC
        ) AS rn
    FROM performance_reviews
),

latest_reviews AS (
    SELECT *
    FROM ranked_reviews
    WHERE rn <= 3
),

employee_ratings AS (
    SELECT
        employee_id,

        MAX(CASE WHEN rn = 3 THEN rating END) AS oldest_rating,

        MAX(CASE WHEN rn = 2 THEN rating END) AS middle_rating,

        MAX(CASE WHEN rn = 1 THEN rating END) AS newest_rating

    FROM latest_reviews
    GROUP BY employee_id

    HAVING COUNT(*) = 3
       AND oldest_rating < middle_rating
       AND middle_rating < newest_rating
)

SELECT
    e.employee_id,
    e.name,
    (r.newest_rating - r.oldest_rating) AS improvement_score
FROM employees e
JOIN employee_ratings r
    ON e.employee_id = r.employee_id
ORDER BY improvement_score DESC, e.name ASC;