SELECT *
FROM ( --subquery
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs

LIMIT 100
;

WITH january_jobs AS ( --CTE
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)

SELECT *
FROM january_jobs

LIMIT 100
;

SELECT
    company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT
        company_id
    FROM job_postings_fact
    WHERE
        job_no_degree_mention = true
)
ORDER BY company_id ASC
;

SELECT
    company_id
FROM job_postings_fact
WHERE
    job_no_degree_mention = true
ORDER BY company_id ASC
;


WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM job_postings_fact
    GROUP BY company_id
)
SELECT
    companies.name AS company_name,
    job.total_jobs
FROM company_dim AS companies
LEFT JOIN company_job_count AS job
    ON job.company_id = companies.company_id
ORDER BY total_jobs DESC

;

--practice problem 1
SELECT
    skill_id AS skill_id,
    skills AS skill_name
FROM skills_dim
WHERE skill_id IN(
    SELECT
        skill_id
    FROM skills_job_dim
    GROUP BY skill_id
    ORDER BY COUNT(*) DESC
    LIMIT 5
)
;

--showing count
SELECT
    s.skill_id AS skill_id,
    s.skills AS skill_name,
    (
        SELECT
            COUNT(*)
            FROM skills_job_dim AS sdj
            WHERE sdj.skill_id = s.skill_id
    ) AS total_mentions
FROM skills_dim AS s
WHERE s.skill_id IN(
    SELECT
        skill_id
    FROM skills_job_dim
    GROUP BY skill_id
    ORDER BY COUNT(*) DESC
    LIMIT 10
)
ORDER BY total_mentions DESC
;

--subquery
SELECT
    skill_id,
    COUNT(*) AS total_mentions
FROM skills_job_dim
GROUP BY skill_id
ORDER BY COUNT(*) DESC
LIMIT 5
;

--practice problem 2
SELECT
    cd.company_id AS company_id,
    cd.name AS company_name,
    (
        SELECT 
            COUNT(*)
        FROM job_postings_fact AS jf
        WHERE jf.company_id = cd.company_id
    ) AS total_posted_jobs,
    CASE
        WHEN (
            SELECT COUNT(*)
            FROM job_postings_fact AS jf
            WHERE jf.company_id = cd.company_id
        ) > 50 THEN 'Large'
        WHEN (
            SELECT COUNT(*)
            FROM job_postings_fact AS jf
            WHERE jf.company_id = cd.company_id
        ) >= 10 THEN 'Medium'
        ELSE 'Small'
    END AS size_category
FROM company_dim AS cd
WHERE cd.company_id IN(
    SELECT
        company_id
    FROM job_postings_fact
    GROUP BY company_id
)
ORDER BY total_posted_jobs DESC
LIMIT 50000
;

--subquery
SELECT
    company_id,
    COUNT(*) AS total_jobs
FROM job_postings_fact
GROUP BY company_id
ORDER BY COUNT(*) DESC

;

--practice problem 7
WITH remote_job_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings
        ON job_postings.job_id = skills_to_job.job_id
    --WHERE
        --job_postings.job_work_from_home = true
    GROUP BY skill_id
)

SELECT
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills
    ON skills.skill_id = remote_job_skills.skill_id
ORDER BY skill_count DESC
LIMIT 10
;

