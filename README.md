# Netflix Data Analysis using PostgreSQL
“Data analysis of Netflix movies and TV shows using PostgreSQL and SQL queries.”
## Project Overview
This project focuses on analyzing Netflix Movies and TV Shows data using PostgreSQL.
The objective is to derive meaningful business insights by performing SQL-based data analysis
on content distribution, genres, countries, and release trends.

## Dataset
- Dataset: Netflix Movies and TV Shows
- Format: CSV
- Source: Public dataset (Kaggle)
- Records include information such as title, type, country, genre, release year, and rating.

## Objectives
- Analyze the distribution of Movies vs TV Shows
- Identify top countries producing Netflix content
- Find most popular genres
- Analyze year-wise content growth
- Perform data filtering and aggregation using SQL

## Tools & Technologies
- PostgreSQL
- SQL
- CSV Dataset
- GitHub

## Key SQL Concepts Used
- CREATE TABLE
- INSERT / COPY commands
- WHERE filtering
- GROUP BY & HAVING
- ORDER BY
- Aggregate functions (COUNT, AVG)
- String and date operations

## Sample Query
```sql
SELECT type, COUNT(*) AS total_content
FROM netflix_titles
GROUP BY type;
