from config import password
from sqlalchemy import create_engine

engine = create_engine(f"postgresql://postgres:{password}@localhost/sql-challenge")
connection = engine.connect()

sql_query = "Select * from employees as e join salaries as s on e.emp_no = s.emp_no"

import pandas as pd
import matplotlib.pyplot as plt
import matplotlib as mpl

df = pd.read_sql(sql_query,connection)

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

sql_query_2 = "Select title, AVG(salary) as Average_Salary from employees as e join salaries as s on e.emp_no = s.emp_no JOIN titles as t on t.title_id = e.emp_title_id GROUP BY title"
df2 = pd.read_sql(sql_query_2,connection)

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