/*
Question: What are the most optimal skills to learn (aka it's high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Target skills that offer job security (high demand) and financial benefits (high salaries),
    offering strategic insights for career development in data analysis
*/

WITH skills_demand AS (
    SELECT
        s.skill_id,
        s.skills,
        COUNT(sj.job_id) AS demand_count
    FROM job_postings_fact AS j
    INNER JOIN skills_job_dim AS sj
        ON j.job_id = sj.job_id
    INNER JOIN skills_dim AS s
        ON sj.skill_id = s.skill_id
    WHERE
        j.job_title_short = 'Data Analyst' AND
        j.salary_year_avg IS NOT NULL AND
        j.job_work_from_home = TRUE
    GROUP BY s.skill_id
),
average_salary AS (
    SELECT
        s.skill_id,
        s.skills,
        ROUND(AVG(j.salary_year_avg),2) AS avg_salary
    FROM job_postings_fact AS j
    INNER JOIN skills_job_dim AS sj
        ON j.job_id = sj.job_id
    INNER JOIN skills_dim AS s
        ON sj.skill_id = s.skill_id
    WHERE
        j.job_title_short = 'Data Analyst' AND
        j.salary_year_avg IS NOT NULL AND
        j.job_work_from_home = TRUE
    GROUP BY s.skill_id
)

SELECT
    sd.skill_id,
    sd.skills,
    sd.demand_count,
    asal.avg_salary
FROM skills_demand AS sd
INNER JOIN average_salary AS asal
    ON sd.skill_id = asal.skill_id
WHERE
    sd.demand_count >= 10
ORDER BY avg_salary DESC, demand_count DESC
LIMIT 25
;
