DROP TABLE departments;
DROP TABLE dept_emp;
DROP TABLE dept_manager;
DROP TABLE employees;
DROP TABLE salaries;
DROP TABLE titles;


CREATE TABLE departments (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE dept_emp (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL
);

CREATE TABLE dept_manager (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL
);

CREATE TABLE employees (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" VARCHAR   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" VARCHAR   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

-- List the following details of each employee: employee number, last name, first name, sex, and salary.

SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
	FROM employees AS e
	JOIN salaries AS s
	ON e.emp_no = s.emp_no;
	
-- List first name, last name, and hire date for employees who were hired in 1986.

SELECT first_name, last_name, hire_date
	FROM employees
	WHERE hire_date LIKE '%1986';
	
-- List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name.

SELECT d.dept_no, d.dept_name, dm.emp_no AS manager_no, e.last_name, e.first_name
	FROM departments AS d
	JOIN dept_manager AS dm
	ON (d.dept_no = dm.dept_no)
		JOIN employees AS e
		ON (dm.emp_no = e.emp_no);
		
-- List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
	FROM employees AS e
	JOIN dept_emp AS de
	ON (e.emp_no = de.emp_no)
		JOIN departments AS d
		ON (de.dept_no = d.dept_no);

-- List first name, last name, and sex for employees 
-- whose first name is "Hercules" and last names begin with "B."

SELECT first_name, last_name, sex
	FROM employees
	WHERE first_name = 'Hercules'
	AND last_name LIKE 'B%';
	
--List all employees in the Sales department, 
--including their employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
	FROM employees AS e
	JOIN dept_emp AS de
	ON (e.emp_no = de.emp_no)
		JOIN departments AS d
		ON (de.dept_no = d.dept_no)
		WHERE d.dept_no = 'd007';
		
-- List all employees in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
	FROM employees AS e
	JOIN dept_emp AS de
	ON (e.emp_no = de.emp_no)
		JOIN departments AS d
		ON (de.dept_no = d.dept_no)
		WHERE d.dept_no = 'd007' OR d.dept_no = 'd005';
		
--In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.

SELECT COUNT(emp_no), last_name
	FROM employees
	GROUP BY last_name
	ORDER BY COUNT(emp_no) DESC;