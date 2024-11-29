/*
List all ensembles held during the next week, sorted by music genre and weekday. For each ensemble tell whether it's full booked, has 1-2 seats left or has more seats left. HINT: you might want to use a CASE statement in your query to produce the desired output.
*/



SELECT 
    --el.date,
    TO_CHAR(el.date, 'Dy') AS weekday,
    g.genre AS genre_name,
	--COUNT(elb.student_id) AS bookings_count,
    CASE 
        WHEN COUNT(elb.student_id) >= el.max_students THEN 'No seats'
        WHEN el.max_students - COUNT(elb.student_id) <= 2 THEN '1 or 2 seats'
        ELSE 'Many seats'
    END AS booking_status
FROM 
	ensemble_lesson AS el
LEFT JOIN 
	ensemble_lesson_bookings AS elb
ON 
	el.lesson_id = elb.lesson_id
JOIN 
	genres AS g
ON 
	el.genre_id = g.genre_id
WHERE 
	el.date BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL '7 days'
GROUP BY 
	el.lesson_id, el.date, g.genre
ORDER BY 
	el.date, g.genre;
    
    
    
    


