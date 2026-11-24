# Write your MySQL query statement below
select user_id, gender
from genders
order by dense_rank() over (partition by gender order by user_id asc), length(gender) desc