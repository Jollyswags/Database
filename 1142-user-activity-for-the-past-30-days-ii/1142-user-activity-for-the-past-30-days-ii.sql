# Write your MySQL query statement below
with cte as(
    SELECT 
    user_id, count(DISTINCT session_id) AS total_sessions
    FROM Activity
    WHERE activity_date > DATE_SUB('2019-07-27', INTERVAL 30 DAY)
    AND activity_date <= '2019-07-27'
    GROUP BY user_id)
select coalesce(round(avg(total_sessions),2),0) as  average_sessions_per_user
from cte