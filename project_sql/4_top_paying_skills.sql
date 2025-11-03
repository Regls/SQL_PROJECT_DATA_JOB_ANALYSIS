/*
Question: What are the top skills based on salary?
- Look at the average saalry associated with each skills for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and
    helps identify the most financially rewarding skills to acquire or improve
*/

SELECT 
    s.skills,
    ROUND(AVG(j.salary_year_avg),2) AS avg_salary
FROM job_postings_fact AS j
INNER JOIN skills_job_dim AS sj
    ON j.job_id = sj.job_id
INNER JOIN skills_dim AS s
    ON sj.skill_id = s.skill_id
WHERE
    j.job_title_short = 'Data Analyst' AND
    j.salary_year_avg IS NOT NULL
GROUP BY s.skills
ORDER BY avg_salary DESC
LIMIT 25
;

/*
Key Insights

Niche and legacy technologies lead in pay: Skills like SVN ($400K) and Solidity ($179K) top the list, showing high salaries where expertise is rare but business-critical.

AI & ML frameworks dominate the mid-high range: Tools such as PyTorch, TensorFlow, Keras, and Hugging Face consistently exceed $120K, reflecting the premium on applied machine learning talent.

DevOps and data infrastructure stay strong: Skills like Terraform, Kafka, Airflow, and Ansible (≈$115K–$147K) remain essential for scalable data and automation pipelines.
*/
