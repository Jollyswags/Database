# Write your MySQL query statement below
SELECT
    REGEXP_SUBSTR(tweet, '#[A-Za-z0-9_]+', 1, 1) AS hashtag,
    COUNT(*) AS hashtag_count
FROM Tweets
GROUP BY hashtag
ORDER BY 2 DESC, 1 DESC
LIMIT 3
