# Introduction
📊 Let's dive right into the data job market! As we focus on data analyst roles. This project will explore 💰top-paying jobs, 🔥in-demand skills, and 📈evaluate salary scales in data analytics.

🔍 Looking for my SQL queries? Check them out over here: [project_sql folder](/project_sql/)

# Background
This quest was driven by my need to sharpen my SQL skills, overcome my imposter syndrome, and start and complete an entire SQL project. My desire to get myself out there and work has resulted in me doing this project. And what a great way to start! This project navigates the data analysis job market effectively, aiming to pinpoint the top-paid and in-demand skills, assisting us in finding the most optimal jobs.

Data explored in this project hails from Luke Barousse's [SQL Course](https://lukebarousse.com/sql) also available on [YouTube](https://www.youtube.com/watch?v=7mz73uXD9DA). It's packed with insights on job titles, salaries, locations, and essential skills.

### Here are the questions I wanted to answer through my SQL queries:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# The Tools I Used
For my deep dive into the data analyst job market, these are the several tools I harnessed to achieve this:

- **SQL:** This was the backbone of my analysis, SQL allowed me to query the database and retract critical insights.
- **PostgreSQL:** This was the chosen database management system, it is ideal for handling large job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
With each query used in this project, I aimed to investigate specific aspects of the job market for a data analyst. Below is how I approached each question:

### 1. Top Paying Data Analyst Jobs
We first looked at which are the highest-paying Data Analyst roles. To identify this I filtered data analyst positions by average yearly salary and location, drawing attention to remote roles. This query assisted in highlighting the high-paying opportunities in the field. 

```sql
SELECT  
 job_id,
 job_title,
 job_location,
 job_schedule_type,
 salary_year_avg,
 job_posted_date,
    name AS company_name
FROM
 job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
 job_title_short = 'Data Analyst' AND 
 job_location = 'Anywhere' AND 
 salary_year_avg IS NOT NULL
ORDER BY
 salary_year_avg DESC
LIMIT 10;
```
Here's the breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, which indicates significant salary potential in the field.
- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

![Top Paying Roles](assets\yearly_avgerage_salary.png)
*Bar graph visualizing the salary for the top 10 salaries for data analysts; ChatGPT generated this graph from my SQL query results*

### 2. Skills for Top Paying Jobs
The second query helps me understand what skills are required for the top-paying jobs. I joined the job postings table with the skills data table, providing insights into what employers value for high-compensation roles.
```sql
WITH top_paying_jobs AS (
    SELECT  
 job_id,
 job_title,
 salary_year_avg,
        name AS company_name
    FROM
 job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
 job_title_short = 'Data Analyst' AND 
 job_location = 'Anywhere' AND 
 salary_year_avg IS NOT NULL
    ORDER BY
 salary_year_avg DESC
    LIMIT 10
)

SELECT 
 top_paying_jobs.*,
 skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
 salary_year_avg DESC;
```
Here's the breakdown of the most demanded skills for the top 10 highest-paying data analyst jobs in 2023:
- **SQL** is leading with a bold count of 8.
- **Python** follows closely with a bold count of 7.
- **Tableau** is also highly sought after, with a bold count of 6.
Other skills like **R**, **Snowflake**, **Pandas**, and **Excel** show varying degrees of demand.

![Top Paying Skills](assets\skill_count.png)
*Bar graph visualizing the count of skills for the top 10 paying jobs for data analysts; ChatGPT generated this graph from my SQL query results*

### 3. In-Demand Skills for Data Analysts

This query helped me identify the skills that are most frequently requested in job postings, directing focus to areas with high demand.

```sql
SELECT 
 skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
 job_title_short = 'Data Analyst' 
    AND job_work_from_home = True 
GROUP BY
 skills
ORDER BY
 demand_count DESC
LIMIT 5;
```
Here's the breakdown of the most demanded skills for data analysts in 2023
- **SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- **Programming** and **Visualization Tools** like **Python**, **Tableau**, and **Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

| Skills   | Demand Count |
|----------|--------------|
| SQL      | 7291         |
| Excel    | 4611         |
| Python   | 4330         |
| Tableau  | 3745         |
| Power BI | 2609         |

*Table of the demand for the top 5 skills in data analyst job postings*

### 4. Skills Based on Salary
Next, I explored the average salaries associated with different skills, this then revealed which skills will get you paid the most, high-paying skills.
```sql
SELECT 
 skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
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
LIMIT 25;
```
Here's a breakdown of the results for top-paying skills for Data Analysts:
- **High Demand for Big Data & ML Skills:** Top salaries are commanded by analysts skilled in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy), reflecting the industry's high valuation of data processing and predictive modeling capabilities.
- **Software Development & Deployment Proficiency:** Knowledge in development and deployment tools (GitLab, Kubernetes, Airflow) indicates a lucrative crossover between data analysis and engineering, with a premium on skills that facilitate automation and efficient data pipeline management.
- **Cloud Computing Expertise:** Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based analytics environments, suggesting that cloud proficiency significantly boosts earning potential in data analytics.

| Skills        | Average Salary ($) |
|---------------|-------------------:|
| pyspark       |            208,172 |
| bitbucket     |            189,155 |
| couchbase     |            160,515 |
| watson        |            160,515 |
| datarobot     |            155,486 |
| gitlab        |            154,500 |
| swift         |            153,750 |
| jupyter       |            152,777 |
| pandas        |            151,821 |
| elasticsearch |            145,000 |

*Table of the average salary for the top 10 paying skills for data analysts*

### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
SELECT 
 skills_dim.skill_id,
 skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
 job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
 skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
 avg_salary DESC,
 demand_count DESC
LIMIT 25;
```

| Skill ID | Skills     | Demand Count | Average Salary ($) |
|----------|------------|--------------|-------------------:|
| 8        | go         | 27           |            115 320 |
| 234      | confluence | 11           |            114 210 |
| 97       | hadoop     | 22           |            113 193 |
| 80       | snowflake  | 37           |            112 948 |
| 74       | azure      | 34           |            111 225 |
| 77       | bigquery   | 13           |            109 654 |
| 76       | aws        | 32           |            108 317 |
| 4        | java       | 17           |            106 906 |
| 194      | ssis       | 12           |            106 683 |
| 233      | jira       | 20           |            104 918 |

*Table of the most optimal skills for data analysts sorted by salary*

Here's a breakdown of the most optimal skills for Data Analysts in 2023: 
- **High-Demand Programming Languages:** Python and R stand out for their high demand, with demand counts of 236 and 148 respectively. Despite their high demand, their average salaries are around $101,397 for Python and $100,499 for R, indicating that proficiency in these languages is highly valued but also widely available.
- **Cloud Tools and Technologies:** Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis.
- **Business Intelligence and Visualization Tools:** Tableau and Looker, with demand counts of 230 and 49 respectively, and average salaries around $99,288 and $103,795, highlight the critical role of data visualization and business intelligence in deriving actionable insights from data.
- **Database Technologies:** The demand for skills in traditional and NoSQL databases (Oracle, SQL Server, NoSQL) with average salaries ranging from $97,786 to $104,534, reflects the enduring need for data storage, retrieval, and management expertise.

# What I Learned

This has truly been an adventure and a huge learning curve. I have gained valuable skills to power through SQL:

- **🧩 Complex Query Crafting:** I have mastered the art of SQL, merging tables like a pro and utilizing WITH clauses for advanced temporary table maneuvers.
- **📊 Data Aggregation:** I was able to get comfortable with GROUP BY commands and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- **💡 Analytical Wizardry:** I then leveled up my real-world experience and problem-solving skills, turning questions into actionable, insightful SQL queries.

# Conclusions

### Insights
From the analysis we have done, there are many valuable insights drawn:

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts are in the highs of $650 000 and not only is the salary apleasing, but these roles also allow remote work. Offering great work-life balance opportunities. 
2. **Skills for Top-Paying Jobs**: High-paying data analyst jobs require advanced proficiency in SQL, suggesting that it is a critical skill for earning a top salary.
3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, making it essential for job seekers.
4. **Skills with Higher Salaries**: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

### Closing Thoughts

This project was exactly what I needed. This project allowed me to take a deep dive into the data analyst job market. It allowed me to expand on my SQL skills while providing me with the opportunity to gain important insights into the required skills for data analysts. The findings from this analysis serve as a guide on the optimal skills required for high-paying data analyst roles. Aspiring data analysts can look at this report and better position themselves in the job market and develop their skills with relevant in-demand skills. This project highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics. 