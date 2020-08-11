CREATE TABLE "employees"
(
 "emp_no"       integer Primary Key,
 "emp_title_id" varchar(5) ,
 "birth_date"   date ,
 "first_name"   text ,
 "last_name"    text ,
 "sex"          varchar(1) ,
 "hire_date"    date
);

CREATE TABLE "departments"
(
 "dept_no"   varchar(4) Primary Key,
 "dept_name" text
);

CREATE TABLE "dept_emp"
(
 	"emp_no"  integer,
	"dept_no" varchar(4)
);

CREATE TABLE "dept_manager"
(
 	"dept_no" varchar(4),
	"emp_no"  integer
);

CREATE TABLE "salaries"
(
 "emp_no" integer Primary Key,
 "salary" integer
);

CREATE TABLE "titles"
(
 "title_id" varchar(5),
 "title"    text
);
