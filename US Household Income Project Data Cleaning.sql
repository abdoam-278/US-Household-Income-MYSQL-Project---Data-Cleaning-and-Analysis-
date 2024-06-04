### 1. Removing Duplicates for both tables 

SELECT * 
FROM(
SELECT row_id, id,
ROW_NUMBER() OVER(PARTITION BY id ORDER BY row_id) as row_num 
FROM USHouseholdIncome) as t 
WHERE row_num > 1; 

DELETE FROM USHouseholdIncome
WHERE row_id IN ( 
SELECT row_id
FROM(
SELECT row_id, id,
ROW_NUMBER() OVER(PARTITION BY id ORDER BY row_id) as row_num 
FROM USHouseholdIncome) as t 
WHERE row_num > 1) ; 


SELECT CONCAT(id,state_name) as row_id, id
FROM ushouseholdincome_statistics
GROUP BY id
HAVING COUNT(row_id) > 1;  ## investigating , no duplicates 


### 2. normalize Upper case in state_name

SELECT DISTINCT State_name, state_ab 
FROM USHouseholdIncome
GROUP BY state_name, state_ab
ORDER BY 1;   ## investigating 


UPDATE ushouseholdincome
SET state_name = 'Georgia' 
WHERE state_name = 'georia' ;

UPDATE ushouseholdincome 
SET state_name = 'Alabama' 
WHERE state_name = 'alabama';


### 3. Replace NULLs 

SELECT * 
FROM ushouseholdincome 
WHERE county = 'Autauga County' 
ORDER BY 1;

UPDATE ushouseholdincome 
SET Place = 'Autaugaville'
WHERE county = 'Autauga County' and Place is NULL ;


### 4. regular investigation 

SELECT type, COUNT(type)
FROM USHouseholdIncome
GROUP BY type;


UPDATE ushouseholdincome 
SET type = 'Borough'
WHERE type = 'Boroughs' ; ## just duplicates 


SELECT Aland, Awater 
FROM ushouseholdincome 
WHERE Awater = 0 OR Awater  = '' OR Awater is NULL; 
 

SELECT Aland, Awater 
FROM ushouseholdincome 
WHERE Aland = 0 OR Aland  = '' OR Aland is NULL ;
 
