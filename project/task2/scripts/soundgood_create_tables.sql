------------------------------------------
------create the lookup tables------
--DROP TABLE IF EXISTS "skill_levels";
CREATE TABLE "skill_levels" (
	"skill_level_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	"skill_level" varchar(100) NOT NULL
);

--DROP TABLE IF EXISTS "instrument_types";
CREATE TABLE "instrument_types" (
	"instrument_type_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	"type" varchar(100) NOT NULL
);

--DROP TABLE IF EXISTS "lesson_types";
CREATE TABLE "lesson_types" (
	"lesson_type_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	"type" varchar(100) NOT NULL
);

--DROP TABLE IF EXISTS "classrooms"
CREATE TABLE "classrooms"(
	"classroom_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	"classroom" varchar(100)
);

--DROP TABLE IF EXISTS "discounts"
CREATE TABLE "discounts"(
	"discount_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	"type" varchar(100) NOT NULL,
	"value" float(2)
);

--DROP TABLE IF EXISTS "genres";
CREATE TABLE "genres"(
	"genre_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	"genre" varchar(100)
);
---------------------------------------------


----------------------------------------
-----create "main" tables-----
--DROP TABLE IF EXISTS "student";
CREATE TABLE "student" (
	"student_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	"person_number" varchar(12) UNIQUE NOT NULL,
	"name" varchar(100) NOT NULL,
	"address" varchar(500) NOT NULL,
	"phone" varchar(100) NOT NULL,
	"email" varchar(100) NOT NULL,
	"contact_person_phone" varchar(100),
	"contact_person_email" varchar(100),
	"contact_person_address" varchar(500)
);

--DROP TABLE IF EXISTS "instructor";
CREATE TABLE "instructor" (
	"instructor_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	"person_number" varchar(12) UNIQUE NOT NULL,
	"name" varchar(100) NOT NULL,
	"address" varchar(500) NOT NULL,
	"phone" varchar(100) NOT NULL,
	"email" varchar(100) NOT NULL,
	"teaches_ensemble" boolean NOT NULL
);

--DROP TABLE IF EXISTS "price";
CREATE TABLE "price"(
	"price_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	"lesson_type_id" int NOT NULL REFERENCES "lesson_types",
	"skill_level_id" int NOT NULL REFERENCES "skill_levels",
	"student_price" float(2) NOT NULL,
	"instructor_fee" float(2) NOT NULL,
	"valid_from_date" date NOT NULL
);

--DROP TABLE IF EXISTS "individual_lesson";
CREATE TABLE "individual_lesson"(
	"lesson_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	"skill_level_id" int NOT NULL REFERENCES "skill_levels",
	"instrument_type_id" int NOT NULL REFERENCES "instrument_types",
	"date" date NOT NULL,
	"time" time NOT NULL,
	"classroom_id" int NOT NULL REFERENCES "instrument_types",
	"student_id" int NOT NULL REFERENCES "student",
	"instructor_id" int NOT NULL REFERENCES "instructor",
	"price_id" int NOT NULL REFERENCES "price"
);

--DROP TABLE IF EXISTS "group_lesson";
CREATE TABLE "group_lesson"(
	"lesson_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	"skill_level_id" int NOT NULL REFERENCES "skill_levels",
	"instrument_type_id" int NOT NULL REFERENCES "instrument_types",
	"date" date NOT NULL,
	"time" time NOT NULL,
	"classroom_id" int NOT NULL REFERENCES "instrument_types",
	"instructor_id" int NOT NULL REFERENCES "instructor",
	"price_id" int NOT NULL REFERENCES "price",
	"min_students" int NOT NULL,
	"max_students" int NOT NULL
);

--DROP TABLE IF EXISTS "ensemble_lesson";
CREATE TABLE "ensemble_lesson"(
	"lesson_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	"genre_id" int NOT NULL REFERENCES "genres",
	"skill_level_id" int NOT NULL REFERENCES "skill_levels",
	"date" date NOT NULL,
	"time" time NOT NULL,
	"classroom_id" int NOT NULL REFERENCES "instrument_types",
	"instructor_id" int NOT NULL REFERENCES "instructor",
	"price_id" int NOT NULL REFERENCES "price",
	"min_students" int NOT NULL,
	"max_students" int NOT NULL
);

--DROP TABLE IF EXISTS "instrument";
CREATE TABLE "instrument"(
	"instrument_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	"rental_price" float(2) NOT NULL,
	"student_id" int REFERENCES "student" ON DELETE SET NULL DEFAULT NULL	,
	"lease_date" date DEFAULT NULL,
	"instrument_type_id" int NOT NULL REFERENCES "instrument_types",
	"category" varchar(100),
	"brand" varchar(100)
);

-------------------------------------------


-----------------------------------------
-----create cross reference tables-----
--DROP TABLE IF EXISTS "siblings";
CREATE TABLE "siblings" (
	"student_id" int NOT NULL REFERENCES "student" ON DELETE CASCADE,
	"sibling_id" int NOT NULL REFERENCES "student" ON DELETE CASCADE,
	PRIMARY KEY ("student_id", "sibling_id")
);

--DROP TABLE IF EXISTS "group_lesson_bookings";
CREATE TABLE "group_lesson_bookings"(
	"student_id" int NOT NULL REFERENCES "student" ON DELETE CASCADE,
	"lesson_id" int NOT NULL REFERENCES "group_lesson" ON DELETE CASCADE,
	PRIMARY KEY ("student_id","lesson_id")
);

--DROP TABLE IF EXISTS "ensemble_lesson_bookings";
CREATE TABLE "ensemble_lesson_bookings"(
	"student_id" int NOT NULL REFERENCES "student" ON DELETE CASCADE,
	"lesson_id" int NOT NULL REFERENCES "group_lesson" ON DELETE CASCADE,
	PRIMARY KEY ("student_id","lesson_id")
);

--DROP TABLE IF EXISTS "student_discounts";
CREATE TABLE "student_discounts"(
	"student_id" int NOT NULL REFERENCES "student" ON DELETE CASCADE,
	"discount_id" int NOT NULL REFERENCES "discounts" ON DELETE CASCADE,
	PRIMARY KEY ("student_id", "discount_id")
);

--DROP TABLE IF EXISTS "instructor_instruments";
CREATE TABLE "instructor_instruments"(
	"instructor_id" int NOT NULL REFERENCES "instructor" ON DELETE CASCADE,
	"instrument_type_id" int NOT NULL REFERENCES "instrument_types" ON DELETE CASCADE,
	PRIMARY KEY ("instructor_id", "instrument_type_id")
);

--DROP TABLE IF EXISTS "instructor_availability";
CREATE TABLE "instructor_availability"(
	"instructor_id" int NOT NULL REFERENCES "instructor" ON DELETE CASCADE,
	"date" date NOT NULL,
	"from_time" time NOT NULL,
	"to_time" time NOT NULL,
	PRIMARY KEY ("instructor_id", "date")
);
------------------------------------







