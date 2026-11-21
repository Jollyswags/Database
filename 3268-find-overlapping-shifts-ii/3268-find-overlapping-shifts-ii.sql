# Write your MySQL query statement below
WITH times AS (
    SELECT DISTINCT
        employee_id,
        start_time AS time
    FROM EmployeeShifts

    UNION

    SELECT DISTINCT
        employee_id,
        end_time AS time
    FROM EmployeeShifts
),

segments AS (
    SELECT
        employee_id,
        time AS start_time,
        LEAD(time) OVER (
            PARTITION BY employee_id
            ORDER BY time
        ) AS end_time
    FROM times
),

overlaps AS (
    SELECT
        s.employee_id,
        s.start_time,
        s.end_time,
        COUNT(*) AS concurrent_count
    FROM segments s
    JOIN EmployeeShifts e
        ON s.employee_id = e.employee_id
        AND s.start_time >= e.start_time
        AND s.end_time <= e.end_time
    GROUP BY 1, 2, 3
)

SELECT
    employee_id,

    MAX(concurrent_count) AS max_overlapping_shifts,

    SUM(
        concurrent_count * (concurrent_count - 1) / 2
        * TIMESTAMPDIFF(MINUTE, start_time, end_time)
    ) AS total_overlap_duration

FROM overlaps
GROUP BY employee_id
ORDER BY employee_id
