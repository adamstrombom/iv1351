
/*
List ids and names of all instructors who has given more than a specific number of lessons during the current month
*/

SELECT
	ins.instructor_id AS instructor_id,
	SPLIT_PART(name, ' ', 1)  AS first_name,
	SPLIT_PART(name, ' ', 2)  AS last_name,
	COUNT(*) AS lesson_count
FROM 
	instructor AS ins	
LEFT JOIN 
	all_lessons as al		--view of all lessons combined	
ON 
	ins.instructor_id = al.instructor_id
WHERE 
	EXTRACT(MONTH FROM date) = EXTRACT(MONTH FROM CURRENT_DATE)
	AND 
	EXTRACT(YEAR FROM date) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY 
	ins.instructor_id
HAVING 
	COUNT(*) > 5
ORDER BY 
	lesson_count DESC;


