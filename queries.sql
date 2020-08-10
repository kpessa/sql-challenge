-- 1. Employee: employee number, last name, first name, sex, and salary.
Select e.emp_no as "employee number", last_name, first_name, sex, salary from employees as e
join salaries as s on e.emp_no = s.emp_no 
-- 2. List first name, last name, and hire date for employees who were hired in 1986.
Select first_name, last_name, hire_date from employees where extract(year from hire_date) = 1986
