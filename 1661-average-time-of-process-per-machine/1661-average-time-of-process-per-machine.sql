# Write your MySQL query statement below
with cte as (
    select machine_id, process_id, MAX(case when activity_type='start' then timestamp end) as "start_time", MAX(case when activity_type='end' then timestamp end) as "end_time"
    from activity
    group by machine_id, process_id
),
cte2 as (
    select machine_id, process_id, end_time-start_time as diff
    from cte
)
select machine_id, round(avg(diff),3) as processing_time
from cte2
group by machine_id
