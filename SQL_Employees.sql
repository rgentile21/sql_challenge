DROP TABLE Employees;

CREATE TABLE Employees (
    emp_no INT NOT NULL PRIMARY KEY,
	emp_title_id VARCHAR(10) NOT NULL,
    birth_date  DATE NOT NULL,
    first_name  VARCHAR(40) NOT NULL,
    last_name   VARCHAR(40) NOT NULL,
    sex         VARCHAR(2) NOT NULL,    
    hire_date   DATE NOT NULL
    );

SELECT * FROM employees

DROP TABLE Departments
ALTER TABLE Departments 
ADD dept_name VARCHAR(255) NOT NULL   

CREATE TABLE departments (
    dept_no VARCHAR(20) NOT NULL PRIMARY KEY,
   	dept_name VARCHAR(255) NOT NULL    
	);

SELECT * FROM departments;


DROP TABLE dept_manager;

CREATE TABLE dept_manager (
   	dept_no VARCHAR(6) NOT NULL,
	emp_no INT NOT NULL	
    ); 

DROP TABLE dept_manager
CREATE TABLE dept_manager (
	   dept_no VARCHAR(6) NOT NULL,
	   emp_no INT NOT NULL,
	   FOREIGN KEY (emp_no)  REFERENCES employees (emp_no),
	   FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	   PRIMARY KEY (emp_no,dept_no)
	   ); 

SELECT * FROM dept_manager;


DROP TABLE dept_emp
CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
    dept_no VARCHAR(6) NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no,dept_no)
	);

SELECT * FROM dept_emp;

DROP TABLE titles;
CREATE TABLE titles (
    title_id    VARCHAR NOT NULL PRIMARY KEY,
    title       VARCHAR(50) NOT NULL
	); 

SELECT * FROM titles;

DROP TABLE salaries;
CREATE TABLE salaries (
    emp_no      INT  NOT NULL,
    salary      INT  NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no)
    );

-- List the following details of each employee: employee number, last name, first name, sex, and salary.

SELECT 
Employees.emp_no,
Employees.last_name,
Employees.first_name,
Employees.sex,
salaries.salary
FROM Employees Employees 
JOIN salaries salaries
ON Employees.emp_no = Salaries.emp_no;

--List the first name, last name and hire date for employees who were hired in 1986

SELECT
Employees.first_name,
Employees.last_name,
hire_date
FROM Employees
WHERE extract(year from hire_date) = '1986';

--List the manager of each department with the following information:department number, department name, the manager's employee number, last name, first name

SELECT
dept_manager.dept_no,
departments.dept_name,
dept_manager.emp_no,
Employees.last_name,
Employees.first_name
FROM dept_manager dept_manager
LEFT JOIN Departments on dept_manager.dept_no = Departments.dept_no
LEFT JOIN Employees on dept_manager.emp_no = Employees.emp_no;


--List the department of each employee with the following information: employee number, last name, first name and department name.

SELECT
Employees.emp_no, 
first_name, 
last_name,
dept_name
FROM Employees Employees
LEFT JOIN dept_emp dept_emp
ON Employees.emp_no = dept_emp.emp_no
LEFT JOIN departments
ON dept_emp.dept_no = departments.dept_no;


--List the first name, last name and sex for employees whose first name is "Hercules" and the first name begins with 'B'

SELECT * FROM employees
WHERE(first_name LIKE 'Hercules' AND last_name LIKE '%B%');


--List all employees in the Sales Department, including their employee number, last name, first name, and department name.

SELECT
Employees.emp_no, 
first_name, 
last_name,
dept_name
FROM Employees Employees
LEFT JOIN dept_emp dept_emp
ON Employees.emp_no = dept_emp.emp_no
LEFT JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE(departments.dept_name lIKE 'Sales');


--List all employees in the Sales and Development Departments, including their employee number, last name, first name, and department name.

SELECT
Employees.emp_no, 
first_name, 
last_name,
dept_name
FROM Employees Employees
LEFT JOIN dept_emp dept_emp
ON Employees.emp_no = dept_emp.emp_no
LEFT JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE(departments.dept_name lIKE 'Sales')
OR (departments.dept_name lIKE 'Development');

--In desecending order list the frequency coun of employee last names, i.e. how many employees share each last name

SELECT
last_name,
COUNT(last_name) AS "name_count"
from employees
GROUP BY
last_name
ORDER BY name_count DESC;
