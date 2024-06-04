## How do states compare when to comes to the Area of land & water? TOP 10 areas by land?

SELECT state_name, SUM(Aland), SUM(Awater)
FROM ushouseholdincome
GROUP by state_name
ORDER BY SUM(Aland) DESC
LIMIT 10;


## JOIN 2 tables to start working with income data 

SELECT * 
FROM ushouseholdincome u
JOIN ushouseholdincome_statistics us
ON u.id = us.id 
WHERE mean <> 0;



## average household income ( 1 person or a couple)  & the  avg median 

SELECT u.state_name,  ROUND(AVG(mean),1) as avg_mean, ROUND(AVG(median),1) as avg_median 
FROM ushouseholdincome u
JOIN ushouseholdincome_statistics us
ON u.id = us.id 
WHERE mean <> 0 
GROUP by u.state_name
ORDER BY avg_mean DESC;

## average salaries compared by different areas

SELECT Type, Count(type), ROUND(AVG(mean),1) as avg_mean, ROUND(AVG(median),1) as avg_median 
FROM ushouseholdincome u
JOIN ushouseholdincome_statistics us
ON u.id = us.id 
WHERE mean <> 0 
GROUP by Type
HAVING COUNT(type) > 100 ## to filter the outliers  ( you should have good background knowledge on the data before doing this)
ORDER BY avg_mean DESC;

## avg salaries in big cities?

SELECT u.state_name, City, ROUND(AVG(mean),1) as avg_mean, ROUND(AVG(median),1) as avg_median 
FROM ushouseholdincome u
JOIN ushouseholdincome_statistics us
ON u.id = us.id 
WHERE mean <> 0 
GROUP by u.state_name, City
ORDER BY Avg_mean DESC;

