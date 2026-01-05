SELECT * FROM netflix

1-- count the number of movies vs tv shows

SELECT type, COUNT (*) as total_content
FROM netflix GROUP BY type

2-- find the most common rating for movies and tv shows

SELECT type, MAX(rating) FROM netflix GROUP BY 1

SELECT type, rating, COUNT(*) FROM netflix GROUP BY 1,2
ORDER BY 3 DESC 

SELECT type, rating, COUNT(*), RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) as ranking
FROM netflix GROUP BY 1,2 

SELECT type, rating 
FROM 
(
   SELECT type, rating, COUNT(*), RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) as ranking
FROM netflix GROUP BY 1,2  
) as t1 WHERE ranking = 1

3-- list all the movies released in a specific year (e.g 2020)

SELECT * FROM netflix WHERE type = 'Movie' AND release_year = 2020

4-- find the top 5 countries with the most content on netflix

SELECT country, 
COUNT(show_id) as total_content 
FROM netflix
GROUP BY 1

SELECT
UNNEST(STRING_TO_ARRAY(country, ',')) as new_country 
FROM netflix


SELECT 
UNNEST(STRING_TO_ARRAY(country, ',')) as new_country,
COUNT(show_id) as total_content 
FROM netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

5-- IDENTIFY THE LONGEST MOVIE

SELECT * FROM netflix 
WHERE 
type = 'Movie'
AND 
duration = (SELECT MAX(duration) FROM netflix)

6-- find content add in last 5 years

SELECT * FROM netflix 
WHERE
     TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years'

select 	CURRENT_DATE - INTERVAL '5 years'

SELECT
     *,
	 TO_DATE(date_added, 'Month DD, YYYY')
	 FROM netflix
WHERE date_added >= CURRENT_DATE - INTERVAL '5 years'

7-- find al the movies/TV shows by director  'Rajiv chikla'

SELECT * FROM netflix 
WHERE director 
ILIKE '%Rajiv Chilaka%'

8--  list all the tv shows with more than 5 seasons

SELECT * 
FROM netflix 
WHERE 
    type = 'TV Show'
	AND 
	SPLIT_PART(duration, ' ', 1)::numeric > 5

9--  count the number of content items in each genre

SELECT 
     UNNEST(STRING_TO_ARRAY(listed_in,',')) as genre,
	 COUNT(show_id) as total_content
FROM netflix
GROUP BY 1


10-- find each year and the avrg numbers of content release by india on netflix.
return top 5 year with highest avg content release

SELECT 
   EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD,YYYY')) AS year,
   COUNT(*)
   FROM netflix 
   WHERE country = 'India'
   GROUP BY 1

SELECT 
   EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD,YYYY')) AS year,
   COUNT(*) as yearly_content,
   ROUND(
   COUNT(*)::numeric/(SELECT COUNT(*) FROM netflix where country = 'India')::numeric * 100
   ,2) as avg_content_per_year
FROM netflix 
WHERE country = 'India'
GROUP BY 1


11--  list all movies that are documentaries

SELECT * FROM netflix 
WHERE 
    listed_in ILIKE '%documentaries%'

12-- find all content without a director

SELECT * FROM netflix 
WHERE
     director IS NULL

13--  find how many movies actor salman khan appeared in last 10 years

 SELECT * FROM netflix 
WHERE 
    casts ILIKE '%Salman Khan%'
	AND 
	release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10

14-- Find the top 10 actors who have appeared in the highest number of movies produced in india

SELECT 
show_id,
casts,
UNNEST(STRING_TO_ARRAY(casts, ','))
FROM netflix

SELECT 
UNNEST(STRING_TO_ARRAY(casts, ',')) as actors,
COUNT(*) as total_content
FROM netflix
WHERE country ILIKE '%india%'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10


