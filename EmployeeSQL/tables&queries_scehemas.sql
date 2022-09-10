CREATE TABLE titles(
    title_id VARCHAR PRIMARY KEY,
    title VARCHAR
);

CREATE TABLE employees(
    emp_no INTEGER PRIMARY KEY,
    emp_title_id VARCHAR,
    birth_data DATE, 
    first_name VARCHAR, 
    last_name VARCHAR,
    sex CHAR(1),
    hire_date DATE,
    UNIQUE (emp_no),
    FOREIGN KEY (emp_title_id)REFERENCES titles(title_id)
);

CREATE TABLE departments(
    dept_no VARCHAR PRIMARY KEY,
    dept_name VARCHAR
);

CREATE TABLE dept_manager(
    dept_no VARCHAR,
    FOREIGN KEY (dept_no)REFERENCES departments(dept_no),
    emp_no INTEGER,
    FOREIGN KEY (emp_no)REFERENCES employees(emp_no)
);

CREATE TABLE dept_emp(
    emp_no INTEGER,
    FOREIGN KEY (emp_no)REFERENCES employees(emp_no),
    dept_no VARCHAR,
    FOREIGN KEY (dept_no)REFERENCES departments(dept_no)
);

CREATE TABLE salaries(
    emp_no INTEGER,
    salary INTEGER,
    FOREIGN KEY (emp_no)REFERENCES employees(emp_no)
);

--1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT employees.emp_no,employees.last_name,employees.first_name,employees.sex,salaries.salary
FROM employees 
INNER JOIN salaries 
ON salaries.emp_no = employees.emp_no
ORDER BY last_name ASC;

--2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT e.first_name, e.last_name, e.hire_date
FROM employees AS e
WHERE hire_date BETWEEN '1/1/1986' AND '12/31/1986'
ORDER BY hire_date;

--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM departments
	JOIN dept_manager
	ON (departments.dept_no=dept_manager.dept_no)
		JOIN employees
		ON (dept_manager.emp_no=employees.emp_no);

--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
	JOIN dept_emp 
	ON (employees.emp_no=dept_emp.emp_no)
		JOIN departments
		ON (dept_emp.dept_no=departments.dept_no);

--5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name like 'B%';

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
	JOIN dept_emp
	ON (employees.emp_no=dept_emp.emp_no)
		JOIN departments
		ON (dept_emp.dept_no=departments.dept_no)
		WHERE departments.dept_name = 'Sales';

--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees 
	JOIN dept_emp 
	ON (employees.emp_no=dept_emp.emp_no)
		JOIN departments 
		ON (dept_emp.dept_no=departments.dept_no)
		WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development';

--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, count(last_name) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency desc;