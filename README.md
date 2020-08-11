<style>
.flex-container{
    width: 100%;
    margin: 0 auto;
    display: -webkit-flex; /* Safari */     
    display: flex; /* Standard syntax */
}
.flex-container .column{
    padding: 10px;
    -webkit-flex: 1; /* Safari */
    -ms-flex: 1; /* IE 10 */
    flex: 1; /* Standard syntax */
}
</style>

<div class="flex-container">
    <div class="column">
        <h1>sql-challenge</h1>
        <h3>Pewlett Hackard: 1980's to 1990s</h2>
    </div>
    <div class="column bg-alt"><img src="sql.png" height=100></div>
</div>

## Data Engineering
---
### 1. Entity-Relationship Diagram (ERD)

![](entity_relationship_diagram_erd.png)

### 2. Creating tables in PostGreSQL
<details><summary>Schema for creatings tables in PostGreSQL </summary>

```sql
​CREATE TABLE "employees"
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
```
​    
</details>

## Data Analysis
---
### 3. Querying the PostGreSQL Database
1. List the following details of each employee: employee number, last name, first name, sex, and salary.
```postgresql
SELECT e.emp_no, last_name, first_name, sex, salary 
FROM employees as e 
JOIN salaries as s 
ON e.emp_no = s.emp_no 
```
2. List first name, last name, and hire date for employees who were hired in 1986.
```postgresql
SELECT first_name, last_name, hire_date 
FROM employees 
WHERE extract(year from hire_date) = 1986
```
3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
```postgresql
SELECT dm.dept_no, dept_name, dm.emp_no, last_name, first_name 
FROM dept_manager as dm
JOIN departments as d on dm.dept_no = d.dept_no
JOIN employees as e on dm.emp_no = e.emp_no
```
4. List the department of each employee with the following information: employee number, last name, first name, and department name.
```postgresql
SELECT de.emp_no, last_name, first_name, dept_name 
FROM dept_emp as de
JOIN employees as e on de.emp_no = e.emp_no
JOIN departments as d on de.dept_no = d.dept_no
```
5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
```postgresql
SELECT first_name, last_name, sex 
FROM employees 
WHERE first_name = 'Hercules' and last_name LIKE 'B%'
```
6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
```postgresql
SELECT e.emp_no, last_name, first_name, dept_name 
FROM employees as e
JOIN dept_emp as de on e.emp_no = de.emp_no
JOIN departments as d on de.dept_no = d.dept_no
```
7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
```postgresql
SELECT e.emp_no, last_name, first_name, dept_name 
FROM employees as e
JOIN dept_emp as de on e.emp_no = de.emp_no
JOIN departments as d on de.dept_no = d.dept_no
WHERE dept_name = 'Sales' or dept_name = 'Development'
```
8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
```postgresql
SELECT last_name, COUNT(last_name) as frequency 
FROM employees 
GROUP BY last_name
ORDER BY frequency desc
```
9. BONUS: Querying yourself with emp_no = 499942
```postgresql
SELECT e.emp_no, first_name, last_name, sex, hire_date, salary, title
FROM employees as e
JOIN salaries as s on s.emp_no = e.emp_no
JOIN titles as ti on e.emp_title_id = ti.title_id
WHERE e.emp_no = 499942
```

## Bonus
---
1. Import the SQL database into Pandas
   - Setting up Connection
    ```python
    # Creating a connection with the PostGreSQL database
    from config import password
    from sqlalchemy import create_engine

    engine = create_engine(f"postgresql://postgres:{password}@localhost/sql-challenge")
    connection = engine.connect()
    ```
    - Querying database and importing into Pandas dataframe
    ```python
    # Querying database and storing in Pandas Dataframe
    import pandas as pd
    sql_query = "Select * from employees as e join salaries as s on e.emp_no = s.emp_no"
    df = pd.read_sql(sql_query,connection)
    ```
2. Plot histogram of employee's salaries
    ```python
    import matplotlib.pyplot as plt
    import matplotlib as mpl

    # Plot histogram of salaries
    ax = df.salary.hist(bins=20)
    ax.xaxis.set_major_formatter(mpl.ticker.StrMethodFormatter('${x:,.0f}'))
    ax.yaxis.set_major_formatter(mpl.ticker.StrMethodFormatter('{x:,.0f}'))
    plt.title("Histogram of Salaries: Pewlett Hackard, 1980s-1990s")
    plt.xlabel("Salary")
    plt.ylabel("Frequency")
    fig = mpl.pyplot.gcf()
    fig.set_size_inches(8, 6)
    fig.savefig('histogram_of_salaries.png')
    plt.show()
    ```
    ![](histogram_of_salaries.png)

3. Create a bar chart of average salaries by title
    ```python
    sql_query_2 = "Select title, AVG(salary) as Average_Salary from employees as e join salaries as s on e.emp_no = s.emp_no JOIN titles as t on t.title_id = e.emp_title_id GROUP BY title"

    df2 = pd.read_sql(sql_query_2,connection)

    # Create a bar chart of average salaries based on employee title
    ax = df2.plot.bar(x="title",y='average_salary')
    ax.yaxis.set_major_formatter(mpl.ticker.StrMethodFormatter('${x:,.0f}'))
    plt.tight_layout(pad=2)
    plt.xlabel("Employee Title")
    plt.ylabel("Salary")
    plt.title("Average Salaries by Employee Title at Pewlett Hackard, 1980s-1990s")
    fig = mpl.pyplot.gcf()
    fig.set_size_inches(8, 6)
    fig.savefig('average_salaries.png')
    plt.show()
    ```
    ![](average_salaries.png)