SELECT
    job_title_short,
    job_location
FROM job_postings_fact

LIMIT 100
;

SELECT
    job_title_short,
    job_location,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
LIMIT 1000
;

SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY location_category
--LIMIT 1000
;

--practice problem 1
SELECT
    job_id,
    companies.name AS company_name,
    job_title,
    salary_year_avg AS salary_year,
    CASE
        WHEN salary_year_avg > 200000 THEN 'High'
        WHEN salary_year_avg > 150000 THEN 'Standard'
        ELSE 'Low'
    END AS salary_type
FROM job_postings_fact AS jobs
INNER JOIN company_dim AS companies
    ON jobs.company_id = companies.company_id
WHERE
    jobs.salary_year_avg IS NOT NULL AND
    jobs.job_title_short = 'Data Analyst'
ORDER BY salary_year_avg DESC
;

