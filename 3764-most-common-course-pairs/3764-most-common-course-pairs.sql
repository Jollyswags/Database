# Write your MySQL query statement below

WITH top_performing_students AS (
    SELECT user_id
    FROM course_completions
    GROUP BY user_id
    HAVING COUNT(course_id) >=5 AND AVG(course_rating) >= 4
    )

    , sequence_of_courses AS (
    SELECT course_name AS first_course
        , LEAD(course_name, 1) OVER (PARTITION BY user_id ORDER BY completion_date, course_id) AS second_course
    FROM course_completions
    WHERE user_id IN (SELECT user_id FROM top_performing_students)
    )


SELECT first_course, second_course, COUNT(*) AS transition_count
FROM sequence_of_courses
WHERE second_course IS NOT NULL
GROUP BY first_course, second_course
ORDER BY transition_count DESC, LOWER(first_course), LOWER(second_course)