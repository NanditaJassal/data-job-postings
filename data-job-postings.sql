USE DATA_JOB_POSTINGS;

#Displays the job titles similar to Data analyst, data engineer and analytics engineer
SELECT DISTINCT title FROM Data_Job_Postings
WHERE LOWER(title) LIKE '%data analyst%' OR LOWER(title) LIKE '%data engineer%' OR LOWER(title) LIKE '%analytics engineer%';

#Displays Job counts from different types of data job and their salary ranges
SELECT DISTINCT title, country, COUNT(*) AS job_count,
ROUND(AVG(salary_min_usd), 2) AS avg_min_salary,
ROUND(AVG(salary_max_usd), 2) AS avg_max_salary
FROM Data_Job_Postings d
WHERE LOWER(title) LIKE '%data analyst%' OR LOWER(title) LIKE '%data ENGINEER%' OR LOWER(title) LIKE '%analYTICS ENGINEER%'
GROUP BY title, country
ORDER BY title, job_count DESC;

#Displays job counts for different data jobs
SELECT DISTINCT title, COUNT(*) AS job_count
FROM Data_Job_Postings d
GROUP BY title
ORDER BY job_count DESC;

#Displays the counts for type of work i.e remote, hybrud, onsite
SELECT DISTINCT remote, COUNT(*) AS job_count
FROM Data_Job_Postings d
GROUP BY remote
ORDER BY job_count DESC;

#Displays the skills in demand
SELECT skills
FROM data_job_postings
LIMIT 10;

#Displays the skills in demand in a priority order
SELECT
    TRIM(skill) AS skill,
    COUNT(*) AS job_count
FROM data_job_postings,
JSON_TABLE(
    CONCAT(
        '["',
        REPLACE(skills, '|', '","'),
        '"]'
    ),
    '$[*]' COLUMNS (
        skill VARCHAR(100) PATH '$'
    )
) AS skill_list
GROUP BY TRIM(skill)
ORDER BY job_count DESC
LIMIT 15;