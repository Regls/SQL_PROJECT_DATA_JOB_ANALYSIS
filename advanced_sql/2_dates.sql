--test if all data is loaded
SELECT *
FROM company_dim
LIMIT 1000
;
SELECT *
FROM job_postings_fact
LIMIT 1000
;
SELECT *
FROM skills_dim
LIMIT 1000
;
SELECT *
FROM skills_job_dim
LIMIT 1000
;

SELECT
    '2023-02-19'::DATE,
    '123'::INT,
    'true'::BOOLEAN,
    '3.14'::REAL
;

SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date::DATE AS date
FROM job_postings_fact

LIMIT 100
;

SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time
FROM job_postings_fact

LIMIT 100
;

SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    EXTRACT(YEAR FROM job_posted_date) AS date_year
FROM job_postings_fact

LIMIT 100
;

SELECT
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY month
ORDER BY job_posted_count DESC
LIMIT 100
;

SELECT *
FROM job_postings_fact

LIMIT 50
;
--practice problem 1
SELECT
    job_schedule_type AS job_type,
    AVG(salary_year_avg) AS year_salary,
    AVG(salary_hour_avg) AS hour_salary
FROM job_postings_fact
WHERE
    job_posted_date > '2023-06-01' AND
    (salary_year_avg IS NOT NULL OR salary_hour_avg IS NOT NULL)
GROUP BY job_schedule_type
ORDER BY year_salary DESC
LIMIT 100
;

--practice problem 2
SELECT
    COUNT(*) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS month,
    EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS year
FROM job_postings_fact
WHERE
    EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') = 2023
GROUP BY year, month
ORDER BY month
LIMIT 100
;

SELECT
    TO_CHAR(job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York', 'Mon-YYYY') AS month_year,
    COUNT(*) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS month_order
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') = 2023
GROUP BY month_year, month_order
ORDER BY month_order
;

WITH jobs_ny AS (
    SELECT
        TO_CHAR(job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York', 'Mon-YYYY') AS month_year,
        EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS year,
        EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS month
    FROM job_postings_fact
    WHERE EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') = 2023
)
SELECT
    month_year,
    COUNT(*) AS job_posted_count
FROM jobs_ny
GROUP BY month_year, year, month
ORDER BY year, month
;

--practice problem 3
SELECT
    companies.company_id,
    companies.name AS company_name,
    EXTRACT(YEAR FROM job_postings.job_posted_date) AS year,
    EXTRACT(QUARTER FROM job_postings.job_posted_date) AS quarter,
    job_postings.job_posted_date::DATE AS date,
    job_postings.job_health_insurance
FROM job_postings_fact AS job_postings
LEFT JOIN company_dim AS companies
    ON job_postings.company_id = companies.company_id
WHERE
    job_postings.job_health_insurance = 'true' AND
    EXTRACT(YEAR FROM job_postings.job_posted_date) = 2023 AND
    EXTRACT(QUARTER FROM job_postings.job_posted_date) = 2
ORDER BY company_id
LIMIT 100000
;

