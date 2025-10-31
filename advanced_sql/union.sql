SELECT
    job_title_short,
    company_id,
    job_location
FROM jan_2023_jobs

UNION
--or UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM feb_2023_jobs

UNION
--or UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM mar_2023_jobs
;

--practice problem 1

--CTE to get 1st quarter
WITH all_jobs AS (
    SELECT *, 'January' AS month_name FROM jan_2023_jobs
    UNION ALL
    SELECT *, 'February' AS month_name FROM feb_2023_jobs
    UNION ALL
    SELECT *, 'March' AS month_name FROM mar_2023_jobs
),
--CTE to get skill names
skills_to_names AS (
    SELECT
        sj.job_id AS job_id,
        sj.skill_id AS skill_id,
        s.skills AS skill_name
    FROM skills_job_dim AS sj
    INNER JOIN skills_dim AS s
        ON sj.skill_id = s.skill_id
)
-- principal query
SELECT
    aj.job_id,
    stn.skill_id,
    stn.skill_name,
    aj.salary_year_avg AS salary_year,
    aj.month_name
FROM all_jobs AS aj
INNER JOIN skills_to_names AS stn
    ON aj.job_id = stn.job_id
WHERE
    aj.salary_year_avg > 70000

ORDER BY salary_year ASC
;

--CTE to get 1st quarter
WITH all_jobs AS (
    SELECT *, 'January' AS month_name FROM jan_2023_jobs
    UNION ALL
    SELECT *, 'February' AS month_name FROM feb_2023_jobs
    UNION ALL
    SELECT *, 'March' AS month_name FROM mar_2023_jobs
),
--CTE to get skill names
skills_to_names AS (
    SELECT
        sj.job_id AS job_id,
        sj.skill_id AS skill_id,
        s.skills AS skill_name
    FROM skills_job_dim AS sj
    LEFT JOIN skills_dim AS s
        ON sj.skill_id = s.skill_id
)
-- principal query
SELECT
    aj.job_id,
    COALESCE(stn.skill_name, 'No skill listed') AS skill_name,
    aj.salary_year_avg AS salary_year,
    aj.month_name
FROM all_jobs AS aj
LEFT JOIN skills_to_names AS stn
    ON aj.job_id = stn.job_id
WHERE
    aj.salary_year_avg > 70000

ORDER BY salary_year ASC
;
