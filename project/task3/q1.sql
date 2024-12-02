---------------------------------------------------------------------
/*
Show the number of lessons given per month during a specified year.
This query is expected to be performed a few times per week.
It shall be possible to retrieve the total number of lessons per month (just one number per month) and the specific number of individual lessons, group lessons and ensembles (three numbers per month).
It's not required that all four numbers (total plus one per lesson type) for a particular month are on the same row; you're allowed to have one row for each number as long as it's clear to which month each number belongs.
However, it's most likely easier to understand the result if you do place all numbers for a particular month on the same row, and it's an interesting exercise, therefore you're encouraged to try. 
*/
-----------------------------------------------------------------------


SELECT 
    TO_CHAR(date, 'Mon') AS month,
    SUM(CASE WHEN lesson_type = 'individual' THEN 1 ELSE 0 END) AS individual,
    SUM(CASE WHEN lesson_type = 'group' THEN 1 ELSE 0 END) AS group,
    SUM(CASE WHEN lesson_type = 'ensemble' THEN 1 ELSE 0 END) AS ensemble,
    COUNT(*) AS total
FROM 
    all_lessons --view for union of all different types of lessons 
WHERE 
    EXTRACT(YEAR FROM date) = 2024
GROUP BY 
    EXTRACT(MONTH FROM date), TO_CHAR(date, 'Mon')
ORDER BY 
    EXTRACT(MONTH FROM date); 


/*FIRST ATTEMPT*/
/*
SELECT
	TO_CHAR(month, 'Month') AS month_name,
	individual_count,
	group_count,
	ensemble_count,
	individual_count + group_count + ensemble_count AS total_count
FROM (
	
	(
	(
	--individual
	SELECT
		DATE_TRUNC('month', date) AS month,
		COUNT(*) AS individual_count
	FROM
		individual_lesson
	WHERE
		EXTRACT(YEAR FROM date) = EXTRACT(YEAR FROM CURRENT_DATE)
	GROUP BY
		month
	) AS individual
		
	FULL JOIN 
	
	(
	--group
	SELECT
		DATE_TRUNC('month', date) AS gro_month,
		COUNT(*) AS group_count
	FROM
		group_lesson
	WHERE
		EXTRACT(YEAR FROM date) = EXTRACT(YEAR FROM CURRENT_DATE)
	GROUP BY
		gro_month
	) AS groups
	
	ON individual.month = groups.gro_month
	
	) AS ind_gro
		

	FULL JOIN
	
	(
	--ensemble
	SELECT
		DATE_TRUNC('month', date) AS ens_month,
		COUNT(*) AS ensemble_count
	FROM
		ensemble_lesson
	WHERE
		EXTRACT(YEAR FROM date) = EXTRACT(YEAR FROM CURRENT_DATE)
	GROUP BY
		ens_month
	) AS  ensemble
	
	ON ind_gro.month = ensemble.ens_month

			
)
*/

	




