# Write your MySQL query statement below
WITH total_points AS (
    SELECT
        country,
        winery,
        SUM(points) AS total_points
    FROM Wineries
    GROUP BY country, winery
),

rankings AS (
    SELECT
        *,
        ROW_NUMBER() OVER(
            PARTITION BY country
            ORDER BY total_points DESC, winery 
        ) AS rn
    FROM total_points
),

top AS (
SELECT
    country,
    CONCAT(winery, ' (', total_points, ')') AS top_winery
FROM rankings 
WHERE rn = 1
),

second AS (
SELECT
    country,
    CONCAT(winery, ' (', total_points, ')') AS second_winery
FROM rankings 
WHERE rn = 2
),

third AS (
SELECT
    country,
    CONCAT(winery, ' (', total_points, ')') AS third_winery
FROM rankings 
WHERE rn = 3
)

SELECT
    w.country, 
    t.top_winery,
    COALESCE(s.second_winery , 'No second winery') AS second_winery,
    COALESCE(th.third_winery, 'No third winery') AS third_winery
FROM Wineries w
LEFT JOIN top t
    ON t.country = w.country
LEFT JOIN second s
    ON s.country = w.country
LEFT JOIN third th
    ON th.country = w.country
GROUP BY 1
ORDER BY 1