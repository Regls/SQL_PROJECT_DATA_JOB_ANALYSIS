/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Focuses ob job postings with specified salaries (remove nulls).
- BONUS: Include comany names of top 10 roles
- Why? Highlight the top-paying oopportunities for Data Analysts, offering insights into employment...
*/

SELECT
    jobs.job_id,
    jobs.job_title,
    companies.name AS company_name,
    jobs.job_location,
    jobs.job_schedule_type,
    jobs.salary_year_avg,
    jobs.job_posted_date
FROM job_postings_fact AS jobs
LEFT JOIN company_dim AS companies
    ON jobs.company_id = companies.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10
;