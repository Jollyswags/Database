# Write your MySQL query statement below
SELECT
    p.patient_id,
    pt.patient_name,
    pt.age,
    DATEDIFF(n.first_negative, p.first_positive) AS recovery_time
FROM (
    SELECT
        patient_id,
        MIN(test_date) AS first_positive
    FROM covid_tests
    WHERE result = 'Positive'
    GROUP BY patient_id
) AS p
INNER JOIN (
    SELECT
        c.patient_id,
        MIN(c.test_date) AS first_negative
    FROM covid_tests AS c
    INNER JOIN (
        SELECT
            patient_id,
            MIN(test_date) AS first_positive
        FROM covid_tests
        WHERE result = 'Positive'
        GROUP BY patient_id
    ) AS fp
        ON c.patient_id = fp.patient_id
    WHERE c.result = 'Negative'
      AND c.test_date > fp.first_positive
    GROUP BY c.patient_id
) AS n
    ON p.patient_id = n.patient_id
INNER JOIN patients AS pt
    ON p.patient_id = pt.patient_id
ORDER BY recovery_time ASC, pt.patient_name ASC; 