
-- Create the database first.

CREATE DATABASE employees;

\c employees; -- PostgreSQL

-- 按照实验报告要求编写SQL语句

-- DROP TABLE employees CASCADE;
-- DROP TABLE titles CASCADE;
-- DROP TABLE salaries CASCADE;
-- DROP TABLE departments CASCADE;
-- DROP TABLE dept_manager CASCADE;
-- DROP TABLE dept_emp CASCADE;
-- --员工数据
-- CREATE TABLE employees(
-- 	emp_no		INT		,
-- 	birth_date	DATE,
-- 	first_name	VARCHAR(15),
-- 	last_name	VARCHAR(20),
-- 	gender		CHAR(1),
-- 	hire_date 	DATE,
-- 	constraint pk_employees primary key(emp_no)
-- );
-- --职称数据
-- CREATE TABLE titles(
-- 	emp_no 		INT ,
-- 	title		VARCHAR(50),
-- 	from_date	DATE,
-- 	to_date		DATE,
-- 	constraint pk_title primary key(emp_no,title,from_date),
-- 	constraint fk_titles_employees foreign key (emp_no) references employees(emp_no)
-- );
-- --工资数据
-- CREATE TABLE salaries(
-- 	emp_no INT ,
-- 	salary		INT,
-- 	from_date	CHAR(10),
-- 	to_date		CHAR(10),
-- 	constraint pk_salaries primary key(emp_no,from_date),
-- 	constraint fk_salaries_employees foreign key (emp_no) references employees(emp_no)
-- );

-- --部门数据（）
-- CREATE TABLE departments(
-- 	dept_no		CHAR(4),
-- 	dept_name	VARCHAR(20),
-- 	constraint pk_departments primary key(dept_no)
-- );
-- CREATE TABLE dept_manager (
-- 		dept_no      CHAR(4),
--   	emp_no       INT,
--   	from_date    DATE,
--   	to_date      DATE,
-- 	constraint fk_dept_manager_employees foreign key (emp_no) references employees(emp_no)ON DELETE CASCADE,
-- 	constraint fk_dept_manager_departments foreign key (dept_no) references departments(dept_no)ON DELETE CASCADE,
-- 	constraint pk_dept_manager primary key (emp_no,dept_no)
-- ); 

-- CREATE TABLE dept_emp (
--     emp_no      INT,
--     dept_no     CHAR(4),
--     from_date   DATE,
--     to_date     DATE,
-- 	constraint fk_dept_emp_employees foreign key (emp_no) references employees(emp_no)ON DELETE CASCADE,
-- 	constraint fk_dept_emp_departments foreign key (dept_no) references departments(dept_no)ON DELETE CASCADE,
-- 	constraint pk_dept_emp primary key (emp_no,dept_no)
-- );

-- select * from titles;
-- select * from employees;
-- select * from departments;
-- --INSERT INTO employees VALUES (10001,'1953-09-02','Georgi','Facello','M','1986-06-26');

-- COPY employees
-- FROM E'D:\\PostgreSQL\\demo\\data_employees.txt' 
-- with(format text,delimiter ',',encoding 'UTF-8');
-- --FROM E'C:\\Users\\dell\\Desktop\\大二下\\数据库原理\\上机实验\\lab01_student\\data_employees.txt' 

-- COPY departments
-- FROM E'D:\\PostgreSQL\\demo\\data_departments.txt' 
-- with(format text,delimiter ',',encoding 'UTF-8');

-- COPY dept_emp
-- FROM E'D:\\PostgreSQL\\demo\\data_dept_emp.txt' 
-- with(format text,delimiter ',',encoding 'UTF-8');

-- COPY dept_manager
-- FROM E'D:\\PostgreSQL\\demo\\data_dept_manager.txt' 
-- with(format text,delimiter ',',encoding 'UTF-8');

-- COPY salaries
-- FROM E'D:\\PostgreSQL\\demo\\data_salaries.txt' 
-- with(format text,delimiter ',',encoding 'UTF-8');

-- COPY titles
-- FROM E'D:\\PostgreSQL\\demo\\data_titles.txt' 
-- with(format text,delimiter ',',encoding 'UTF-8');

--5.1
-- SELECT * FROM employees LIMIT 10;
--5.2
-- SELECT emp_no,birth_date,gender,hire_date
-- FROM employees
-- WHERE first_name='Peternela' AND last_name='Anick';
--5.3
-- SELECT emp_no,first_name,last_name,birth_date
-- FROM employees
-- WHERE birth_date>='1961-7-15' AND birth_date<='1961-7-20';
--5.4
-- SELECT *
-- FROM employees
-- WHERE first_name LIKE 'Peter%' OR last_name LIKE 'Peter%';
--5.5
-- SELECT max(salary) as max_salary
-- FROM salaries;
--5.6
SELECT departments.dept_no,count(emp_no) AS dept_emp_count
FROM departments,dept_emp WHERE departments.dept_no=dept_emp.dept_no
GROUP BY departments.dept_no
HAVING COUNT(*)>0
ORDER BY dept_no --ASC
-- SELECT COUNT(*) FROM departments;
-- SELECT COUNT(*) FROM dept_emp;
-- SELECT COUNT(*) FROM dept_manager;
-- SELECT COUNT(*) FROM titles;
-- SELECT COUNT(*) FROM salaries;













-- 3
-- 用SQL创建关系表

-- 测试创建的空表
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM titles;
SELECT * FROM salaries;

-- 4


-- 测试导入数据之后的表
SELECT COUNT(*) FROM employees;
SELECT COUNT(*) FROM departments;
SELECT COUNT(*) FROM dept_emp;
SELECT COUNT(*) FROM dept_manager;
SELECT COUNT(*) FROM titles;
SELECT COUNT(*) FROM salaries;

-- 5.1


-- 5.2


-- 5.3


-- 5.4


-- 5.5


-- 5.6


-- 5.7


-- 5.8


-- 5.9


-- 5.10

		
-- 5.11


-- 5.12


-- 5.13


-- 5.14


-- 5.15


-- 5.16


-- 5.17


-- 5.18

