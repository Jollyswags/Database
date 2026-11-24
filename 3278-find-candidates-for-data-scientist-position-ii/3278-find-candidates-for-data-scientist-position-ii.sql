# Write your MySQL query statement below
WITH candidate_scores AS (
    SELECT
        c.candidate_id,
        p.project_id,

        COUNT(p.skill) AS required_skills,

        SUM(
            CASE
                WHEN c.proficiency > p.importance THEN 10
                WHEN c.proficiency < p.importance THEN -5
                ELSE 0
            END
        ) AS skill_score,

        COUNT(c.skill) AS matched_skills

    FROM (
        SELECT DISTINCT candidate_id
        FROM Candidates
    ) cands

    CROSS JOIN (
        SELECT DISTINCT project_id
        FROM Projects
    ) projects

    JOIN Projects p
        ON p.project_id = projects.project_id

    LEFT JOIN Candidates c
        ON c.candidate_id = cands.candidate_id
        AND c.skill = p.skill

    GROUP BY
        cands.candidate_id,
        p.project_id
),

valid_candidates AS (
    SELECT
        candidate_id,
        project_id,
        100 + skill_score AS score
    FROM candidate_scores
    WHERE matched_skills = required_skills
),

ranked AS (
    SELECT
        candidate_id,
        project_id,
        score,
        ROW_NUMBER() OVER (
            PARTITION BY project_id
            ORDER BY score DESC, candidate_id ASC
        ) AS rn
    FROM valid_candidates
)

SELECT
    project_id,
    candidate_id,
    score
FROM ranked
WHERE rn = 1
ORDER BY project_id
