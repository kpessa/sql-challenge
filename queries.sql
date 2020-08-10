-- 1. Employee: employee number, last name, first name, sex, and salary.
Select e.emp_no as "employee number", last_name, first_name, sex, salary from employees as e
join salaries as s on e.emp_no = s.emp_no 
-- 2. List first name, last name, and hire date for employees who were hired in 1986.
Select first_name, last_name, hire_date from employees where extract(year from hire_date) = 1986
-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT dm.dept_no, dept_name, dm.emp_no, last_name, first_name from dept_manager as dm
JOIN departments as d on dm.dept_no = d.dept_no
JOIN employees as e on dm.emp_no = e.emp_no
-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT de.emp_no, last_name, first_name, dept_name FROM dept_emp as de
JOIN employees as e on de.emp_no = e.emp_no
JOIN departments as d on de.dept_no = d.dept_no