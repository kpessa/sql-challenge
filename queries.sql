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
-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex from employees WHERE first_name = 'Hercules' and last_name LIKE 'B%'
-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT e.emp_no, last_name, first_name, dept_name FROM employees as e
JOIN dept_emp as de on e.emp_no = de.emp_no
JOIN departments as d on de.dept_no = d.dept_no
WHERE dept_name = 'Sales'
-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, last_name, first_name, dept_name FROM employees as e
JOIN dept_emp as de on e.emp_no = de.emp_no
JOIN departments as d on de.dept_no = d.dept_no
WHERE dept_name = 'Sales' or dept_name = 'Development'
-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) as frequency FROM employees 
GROUP BY last_name
ORDER BY frequency desc