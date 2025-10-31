--practice problem 6 (advanced)

CREATE TABLE jan_2023_jobs AS 
SELECT *
FROM job_postings_fact
WHERE
    EXTRACT(MONTH FROM job_posted_date) = 1
;

CREATE TABLE feb_2023_jobs AS 
SELECT *
FROM job_postings_fact
WHERE
    EXTRACT(MONTH FROM job_posted_date) = 2
;

CREATE TABLE mar_2023_jobs AS 
SELECT *
FROM job_postings_fact
WHERE
    EXTRACT(MONTH FROM job_posted_date) = 3
;

SELECT *
FROM mar_2023_jobs
ORDER BY job_posted_date ASC
LIMIT 100
;
