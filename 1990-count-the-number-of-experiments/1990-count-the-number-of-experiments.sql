# Write your MySQL query statement below
SELECT
    p.platform,
    e.experiment_name,
    COUNT(x.experiment_id) AS num_experiments
FROM (
    SELECT 'Android' AS platform
        UNION ALL
    SELECT 'IOS'
        UNION ALL
    SELECT 'Web'
) p

CROSS JOIN (
    SELECT 'Reading' AS experiment_name
        UNION ALL
    SELECT 'Sports'
        UNION ALL
    SELECT 'Programming'
) e

LEFT JOIN Experiments x
    ON x.platform = p.platform
    AND x.experiment_name = e.experiment_name

GROUP BY 1, 2
ORDER BY 1, 2