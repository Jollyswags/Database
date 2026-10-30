WITH cte AS (
    SELECT
        id,
        name,
        departmentid,
        salary,
        DENSE_RANK() OVER (
            PARTITION BY departmentid
            ORDER BY salary DESC
        ) AS ranking
    FROM employee
)
SELECT
    d.name AS Department,
    c.name AS Employee,
    c.salary AS Salary
FROM cte c
JOIN department d
    ON c.departmentid = d.id
WHERE c.ranking <= 3;