/*
Question: What are the top skills based on salary?
-Look at the average salary associated with each skill for Data Analyst positions
-Focus on roles with soecified salaries, regardless of locarion
-Why? I t reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to aquire or improve
*/

SELECT 
    skills,
    ROUND (AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY 
    skills
ORDER BY 
    avg_salary DESC
LIMIT 25

/*
🔍 Top-Paying Data Analyst Skill Trends
-Strong demand for big data & cloud technologies
Tools like PySpark, Databricks, Airflow, 
and GCP command high salaries, showing that data analysts with experience in distributed computing 
and cloud platforms are highly valued.

-Engineering and DevOps skills boost earnings
Skills like Bitbucket, GitLab, Jenkins, Kubernetes, 
and Linux appear frequently—highlighting that hybrid data analyst–engineering roles 
are emerging as some of the most lucrative.

-9ML & data science tools are highly rewarded
Knowledge of Pandas, NumPy, Scikit-learn, and platforms like DataRobot and 
Watson suggests that employers are paying more for analysts who can build or interpret machine learning models.
*/