-- Data Engineering Part 1
-- Drop Tables if Existing
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;

-- Create all tables and import CSVs
CREATE TABLE departments (
	dept_no VARCHAR PRIMARY KEY NOT NULL,
	dept_name VARCHAR NOT NULL);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL, 
	dept_no VARCHAR NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no));

CREATE TABLE dept_manager (
	dept_no VARCHAR NOT NULL,
	emp_no INT NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no));
	
CREATE TABLE employees (
	emp_no INT PRIMARY KEY NOT NULL,
	emp_title_id VARCHAR NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	sex VARCHAR NOT NULL,
	hire_date DATE NOT NULL);
	
CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no));
	
CREATE TABLE titles (
	title_id VARCHAR NOT NULL,
	title VARCHAR NOT NULL);

-----------------------------------------------
-- Data Analysis Part 2
-- List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
JOIN salaries
ON employees.emp_no=salaries.emp_no
;

--List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE  hire_date BETWEEN '1986-01-01' AND '1987-01-01'
;

--List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name.
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM departments
JOIN dept_manager
ON departments.dept_no=dept_manager.dept_no
JOIN employees
ON dept_manager.emp_no=employees.emp_no
;

--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no=employees.emp_no
JOIN departments
ON dept_emp.dept_no=departments.dept_no
;

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name= 'Hercules'
AND last_name LIKE 'B%'
;

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees 
ON dept_emp.emp_no=employees.emp_no
JOIN departments
ON dept_emp.dept_no=departments.dept_no
WHERE departments.dept_name= 'Sales'
;

--List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees 
ON dept_emp.emp_no=employees.emp_no
JOIN departments
ON dept_emp.dept_no=departments.dept_no
WHERE departments.dept_name= 'Sales' 
OR departments.dept_name= 'Development'
;

-- In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.
SELECT COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY 
COUNT(last_name) DESC
;


