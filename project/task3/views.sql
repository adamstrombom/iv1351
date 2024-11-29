

--merge all different lessons as a view containing all columns they all have in common
CREATE VIEW all_lessons AS
	SELECT	
		instructor_id,
		date,
		time,
		skill_level_id,
		classroom_id,
		price_id
	FROM
		individual_lesson
		
	UNION ALL

	SELECT
		instructor_id,
		date,
		time,
		skill_level_id,
		classroom_id,
		price_id
	FROM
		group_lesson
		
	UNION ALL

	SELECT
		instructor_id,
		date,
		time,
		skill_level_id,
		classroom_id,
		price_id
	FROM
		ensemble_lesson
;




