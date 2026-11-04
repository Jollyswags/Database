# Write your MySQL query statement below
with cte as ( select user_id, min(activity_date) as first_date
              from traffic
              where activity ='login'
              group by user_id)
select first_date as login_date, count(user_id) as user_count
from cte
where first_date between date_sub('2019-06-30',Interval 90 day) and '2019-06-30'
group by first_date