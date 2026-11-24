# Write your MySQL query statement below
SELECT
    a.employee_id,
    COUNT(*) AS overlapping_shifts
FROM EmployeeShifts a
JOIN EmployeeShifts b
    ON a.employee_id = b.employee_id
    AND a.start_time < b.end_time
    AND b.start_time < a.end_time
    AND a.start_time < b.start_time
GROUP BY a.employee_id
ORDER BY a.employee_id
