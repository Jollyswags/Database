WITH show_cte AS (
    SELECT question_id, COUNT(*) AS showed
    FROM SurveyLog
    WHERE action = 'show'
    GROUP BY question_id
),
answer_cte AS (
    SELECT question_id, COUNT(*) AS answer
    FROM SurveyLog
    WHERE action = 'answer'
    GROUP BY question_id
),
fract_cte AS (
    SELECT
        s.question_id,
        ROUND(COALESCE(a.answer, 0) / s.showed, 2) AS fraction
    FROM show_cte s
    LEFT JOIN answer_cte a
        ON s.question_id = a.question_id
)
SELECT MIN(question_id) AS survey_log
FROM fract_cte
WHERE fraction = (SELECT MAX(fraction) FROM fract_cte)
HAVING COUNT(*) > 0;;