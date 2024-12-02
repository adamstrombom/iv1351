/*
Show how many students there are with no sibling, with one sibling, with two siblings, etc
*/

SELECT 
    sibling_count,
    COUNT(student_id) AS student_count
FROM (
	SELECT 
		s.student_id,
		COUNT(si.sibling_id) AS sibling_count
	FROM 
		student AS s
	LEFT JOIN 
		siblings AS si
	ON 
		s.student_id = si.student_id
	GROUP BY 
		s.student_id
) res
GROUP BY 
	sibling_count
ORDER BY 
	sibling_count ASC;

