# Write your MySQL query statement below
WITH cte AS (
    SELECT 
        salary,
        RANK() OVER (ORDER BY salary DESC) AS rk
    FROM (
        SELECT DISTINCT salary
        FROM employee
    ) t
)
SELECT 
    MAX(CASE WHEN rk = 2 THEN salary END) AS SecondHighestSalary
FROM cte;