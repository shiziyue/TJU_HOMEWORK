drop database employees;
create database employees;
use employees;
CREATE TABLE employees (
    emp_no      INT             NOT NULL,
    birth_date  DATE            NOT NULL,
    first_name  VARCHAR(14)     NOT NULL,
    last_name   VARCHAR(16)     NOT NULL,
    gender      CHAR(1)			NOT NULL,    
    hire_date   DATE            NOT NULL,
    CONSTRAINT pk_employees PRIMARY KEY (emp_no)
);

CREATE TABLE departments (
    dept_no     CHAR(4)         NOT NULL,
    dept_name   VARCHAR(40)     NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (dept_no)
);

CREATE TABLE dept_emp (
    emp_no      INT             NOT NULL,
    dept_no     CHAR(4)         NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE            NOT NULL,
    CONSTRAINT pk_dept_emp PRIMARY KEY (emp_no, dept_no),
    CONSTRAINT fk_dept_emp_employees FOREIGN KEY (emp_no)  REFERENCES employees(emp_no),
    CONSTRAINT fk_dept_emp_departments FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE dept_manager (
   dept_no		CHAR(4)         NOT NULL,
   emp_no       INT             NOT NULL,
   from_date    DATE            NOT NULL,
   to_date      DATE            NOT NULL,
   CONSTRAINT pk_dept_manager PRIMARY KEY (emp_no, dept_no),
   CONSTRAINT fk_dept_manager_employees FOREIGN KEY (emp_no)  REFERENCES employees(emp_no),
   CONSTRAINT fk_dept_manager_departments FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
); 

CREATE TABLE titles (
    emp_no      INT             NOT NULL,
    title       VARCHAR(50)     NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE,
    CONSTRAINT pk_titles PRIMARY KEY (emp_no, title, from_date),
    CONSTRAINT fk_titles_employees FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
); 

CREATE TABLE salaries (
    emp_no      INT             NOT NULL,
    salary      INT             NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE            NOT NULL,
    CONSTRAINT pk_salaries PRIMARY KEY (emp_no, from_date),
    CONSTRAINT fk_salaries_employees FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/data_employees.txt' INTO TABLE employees CHARACTER SET utf8 FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n'  (`emp_no`,`birth_date`,`first_name`,`last_name`,`gender`,`hire_date`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/data_departments.txt' INTO TABLE departments CHARACTER SET utf8 FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n'  (`dept_no`,`dept_name`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/data_dept_emp.txt' INTO TABLE dept_emp CHARACTER SET utf8 FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n'  (`emp_no`,`dept_no`,`from_date`,`to_date`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/data_dept_manager.txt' INTO TABLE dept_manager CHARACTER SET utf8 FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n'  (`dept_no`,`emp_no`,`from_date`,`to_date`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/data_titles.txt' INTO TABLE titles CHARACTER SET utf8 FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n'  (`emp_no`,`title`,`from_date`,`to_date`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/data_salaries.txt' INTO TABLE salaries CHARACTER SET utf8 FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n'  (`emp_no`,`salary`,`from_date`,`to_date`);
CREATE TABLE departments_copy SELECT * FROM departments;
CREATE TABLE departments_copy_log
(
    log_id		INT	AUTO_INCREMENT,   -- 日志流水编号（自增）
    login_name	VARCHAR(256),		    -- 登录名
    update_date	DATETIME,		    -- 修改时间
    dept_no     CHAR(4),	        -- 部门编号
    dept_name_old	VARCHAR(40),		    -- 部门名称的旧值
    dept_name_new	VARCHAR(40),		    -- 部门名称的新值
    CONSTRAINT departments_copy_log_pk PRIMARY KEY(log_id)
);
DELIMITER $
CREATE TRIGGER updatedepartments
AFTER UPDATE ON departments_copy for EACH ROW
BEGIN
	IF new.dept_name<>old.dept_name THEN
    INSERT into departments_copy_log VALUES (null,user(),now(),old.dept_no,old.dept_name,new.dept_name);
    END IF;
END $
DELIMITER ;
update departments_copy set dept_name=concat(dept_name,' Dept')where dept_no='d005';
select *from departments_copy;
select *from departments_copy_log;
drop view finance_employees_view;
CREATE VIEW finance_employees_view AS
SELECT employees.emp_no,first_name,last_name,gender,birth_date,hire_date
FROM employees,(select emp_no,departments.dept_no from dept_emp,departments where dept_emp.dept_no=departments.dept_no AND dept_name='Finance\r')d
WHERE (employees.emp_no=d.emp_no);
SELECT * FROM finance_employees_view LIMIT 10;
SET profiling = 1;
SELECT d.dept_no, d.dept_name, e.emp_no, e.first_name, e.last_name, s.salary
FROM departments AS d
		INNER JOIN dept_emp AS de ON d.dept_no=de.dept_no
		INNER JOIN employees AS e ON de.emp_no=e.emp_no
		INNER JOIN salaries AS s ON e.emp_no=s.emp_no
WHERE e.first_name='Peternela' AND e.last_name='Anick';
SHOW PROFILES;
SET profiling = 0;
create index P on employees(first_name,last_name);
ALTER TABLE salaries DROP FOREIGN KEY fk_salaries_employees;
ALTER TABLE titles DROP FOREIGN KEY fk_titles_employees;
ALTER TABLE dept_emp DROP FOREIGN KEY fk_dept_emp_employees;
ALTER TABLE dept_emp DROP FOREIGN KEY fk_dept_emp_departments;
ALTER TABLE dept_manager DROP FOREIGN KEY fk_dept_manager_employees;
ALTER TABLE dept_manager DROP FOREIGN KEY fk_dept_manager_departments;
ALTER TABLE employees DROP PRIMARY KEY;
ALTER TABLE departments DROP PRIMARY KEY;
ALTER TABLE dept_emp DROP PRIMARY KEY;
ALTER TABLE salaries DROP PRIMARY KEY;
DROP INDEX P ON employees;
ALTER TABLE employees ADD CONSTRAINT pk_employees PRIMARY KEY(emp_no);
ALTER TABLE departments ADD CONSTRAINT pk_departments PRIMARY KEY(dept_no);
ALTER TABLE dept_emp ADD CONSTRAINT pk_dept_emp PRIMARY KEY(emp_no, dept_no);
ALTER TABLE salaries ADD CONSTRAINT pk_salaries PRIMARY KEY(emp_no, from_date);

ALTER TABLE salaries ADD CONSTRAINT fk_salaries_employees FOREIGN KEY (emp_no) REFERENCES employees(emp_no);
ALTER TABLE titles ADD CONSTRAINT fk_titles_employees FOREIGN KEY (emp_no) REFERENCES employees (emp_no);
ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_employees FOREIGN KEY (emp_no)  REFERENCES employees(emp_no);
ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_departments FOREIGN KEY (dept_no) REFERENCES departments(dept_no);
ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_employees FOREIGN KEY (emp_no)  REFERENCES employees(emp_no);
ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_departments FOREIGN KEY (dept_no) REFERENCES departments(dept_no);
create index P on employees(first_name,last_name);
DELIMITER //
CREATE PROCEDURE calc_avg_salary_for_emp_no(in emp_no_in int,out avg_ float)
BEGIN
SELECT avg(salary) into avg_ FROM salaries where emp_no=emp_no_in;
END //
DELIMITER ;
CALL calc_avg_salary_for_emp_no(10002, @avg_salary);
SELECT @avg_salary;
DROP PROCEDURE calc_avg_salary_for_emp_no;
SET GLOBAL log_bin_trust_function_creators = 1;
DELIMITER //
CREATE FUNCTION is_manager(emp_no_in int) RETURNS bool
BEGIN
	if (select emp_no from dept_manager where emp_no=emp_no_in)then
    return 1;
    else return 0;
    end if;
END //
DELIMITER ;
SELECT is_manager(110022) AS is_manager;
SELECT is_manager(100002) AS is_manager;
drop function is_manager;
use employees
DELIMITER //
CREATE PROCEDURE calc_avg_and_var_salary_for_emp_no(in emp_no_in int,out avg_ real,out var real)
BEGIN
DECLARE no INT;
DECLARE tem real;
DECLARE te real;
declare cur cursor for SELECT salary FROM salaries where emp_no=emp_no_in;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET no=1;
SELECT avg(salary) into avg_ FROM salaries where emp_no=emp_no_in;
SELECT count(salary) into tem FROM salaries where emp_no=emp_no_in;

SET no=0;
set var=0;
OPEN cur;
WHILE no=0 do
	FETCH cur into te;
	set var=var+(avg_-te)*(avg_-te);
END WHILE;
set var=(var-(avg_-te)*(avg_-te))/tem;
END //
 DELIMITER ;
 CALL calc_avg_and_var_salary_for_emp_no(10002 , @avg_salary, @var_salary);
SELECT @avg_salary AS avg_salary, @var_salary AS var_salary;
drop PROCEDURE calc_avg_and_var_salary_for_emp_no