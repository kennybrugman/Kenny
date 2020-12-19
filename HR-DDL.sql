/**

**/

ALTER TABLE HR.JOBS
 DROP PRIMARY KEY CASCADE;

DROP TABLE HR.JOBS CASCADE CONSTRAINTS;

--
-- JOBS  (Table) 
--
CREATE TABLE HR.JOBS
(
  JOB_ID      VARCHAR2(10 BYTE),
  JOB_TITLE   VARCHAR2(35 BYTE) CONSTRAINT JOB_TITLE_NN NOT NULL,
  MIN_SALARY  NUMBER(6),
  MAX_SALARY  NUMBER(6)
)
TABLESPACE USERS
RESULT_CACHE (MODE DEFAULT)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE HR.JOBS IS 'jobs table with job titles and salary ranges. Contains 19 rows.
References with employees and job_history table.';

COMMENT ON COLUMN HR.JOBS.JOB_ID IS 'Primary key of jobs table.';

COMMENT ON COLUMN HR.JOBS.JOB_TITLE IS 'A not null column that shows job title, e.g. AD_VP, FI_ACCOUNTANT';

COMMENT ON COLUMN HR.JOBS.MIN_SALARY IS 'Minimum salary for a job title.';

COMMENT ON COLUMN HR.JOBS.MAX_SALARY IS 'Maximum salary for a job title';



ALTER TABLE HR.REGIONS
 DROP PRIMARY KEY CASCADE;

DROP TABLE HR.REGIONS CASCADE CONSTRAINTS;

--
-- REGIONS  (Table) 
--
CREATE TABLE HR.REGIONS
(
  REGION_ID    NUMBER CONSTRAINT REGION_ID_NN   NOT NULL,
  REGION_NAME  VARCHAR2(25 BYTE)
)
TABLESPACE USERS
RESULT_CACHE (MODE DEFAULT)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE HR.REGIONS IS 'Regions table that contains region numbers and names. Contains 4 rows; references with the Countries table.';

COMMENT ON COLUMN HR.REGIONS.REGION_ID IS 'Primary key of regions table.';

COMMENT ON COLUMN HR.REGIONS.REGION_NAME IS 'Names of regions. Locations are in the countries of these regions.';



--
-- JOB_ID_PK  (Index) 
--
CREATE UNIQUE INDEX HR.JOB_ID_PK ON HR.JOBS
(JOB_ID)
LOGGING
TABLESPACE USERS
NOPARALLEL;


--
-- REG_ID_PK  (Index) 
--
CREATE UNIQUE INDEX HR.REG_ID_PK ON HR.REGIONS
(REGION_ID)
LOGGING
TABLESPACE USERS
NOPARALLEL;


DROP TABLE HR.COUNTRIES CASCADE CONSTRAINTS;

--
-- COUNTRIES  (Table) 
--
CREATE TABLE HR.COUNTRIES
(
  COUNTRY_ID    CHAR(2 BYTE) CONSTRAINT COUNTRY_ID_NN NOT NULL,
  COUNTRY_NAME  VARCHAR2(40 BYTE),
  REGION_ID     NUMBER, 
  CONSTRAINT COUNTRY_C_ID_PK
  PRIMARY KEY
  (COUNTRY_ID)
  ENABLE VALIDATE
)
ORGANIZATION INDEX
RESULT_CACHE (MODE DEFAULT)
LOGGING
TABLESPACE USERS
NOPARALLEL
MONITORING;

COMMENT ON TABLE HR.COUNTRIES IS 'country table. Contains 25 rows. References with locations table.';

COMMENT ON COLUMN HR.COUNTRIES.COUNTRY_ID IS 'Primary key of countries table.';

COMMENT ON COLUMN HR.COUNTRIES.COUNTRY_NAME IS 'Country name';

COMMENT ON COLUMN HR.COUNTRIES.REGION_ID IS 'Region ID for the country. Foreign key to region_id column in the departments table.';



ALTER TABLE HR.LOCATIONS
 DROP PRIMARY KEY CASCADE;

DROP TABLE HR.LOCATIONS CASCADE CONSTRAINTS;

--
-- LOCATIONS  (Table) 
--
CREATE TABLE HR.LOCATIONS
(
  LOCATION_ID     NUMBER(4),
  STREET_ADDRESS  VARCHAR2(40 BYTE),
  POSTAL_CODE     VARCHAR2(12 BYTE),
  CITY            VARCHAR2(30 BYTE) CONSTRAINT LOC_CITY_NN NOT NULL,
  STATE_PROVINCE  VARCHAR2(25 BYTE),
  COUNTRY_ID      CHAR(2 BYTE)
)
TABLESPACE USERS
RESULT_CACHE (MODE DEFAULT)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE HR.LOCATIONS IS 'Locations table that contains specific address of a specific office,
warehouse, and/or production site of a company. Does not store addresses /
locations of customers. Contains 23 rows; references with the
departments and countries tables. ';

COMMENT ON COLUMN HR.LOCATIONS.LOCATION_ID IS 'Primary key of locations table';

COMMENT ON COLUMN HR.LOCATIONS.STREET_ADDRESS IS 'Street address of an office, warehouse, or production site of a company.
Contains building number and street name';

COMMENT ON COLUMN HR.LOCATIONS.POSTAL_CODE IS 'Postal code of the location of an office, warehouse, or production site 
of a company. ';

COMMENT ON COLUMN HR.LOCATIONS.CITY IS 'A not null column that shows city where an office, warehouse, or 
production site of a company is located. ';

COMMENT ON COLUMN HR.LOCATIONS.STATE_PROVINCE IS 'State or Province where an office, warehouse, or production site of a 
company is located.';

COMMENT ON COLUMN HR.LOCATIONS.COUNTRY_ID IS 'Country where an office, warehouse, or production site of a company is
located. Foreign key to country_id column of the countries table.';





--
-- LOC_CITY_IX  (Index) 
--
CREATE INDEX HR.LOC_CITY_IX ON HR.LOCATIONS
(CITY)
LOGGING
TABLESPACE USERS
NOPARALLEL;


--
-- LOC_COUNTRY_IX  (Index) 
--
CREATE INDEX HR.LOC_COUNTRY_IX ON HR.LOCATIONS
(COUNTRY_ID)
LOGGING
TABLESPACE USERS
NOPARALLEL;


--
-- LOC_ID_PK  (Index) 
--
CREATE UNIQUE INDEX HR.LOC_ID_PK ON HR.LOCATIONS
(LOCATION_ID)
LOGGING
TABLESPACE USERS
NOPARALLEL;


--
-- LOC_STATE_PROVINCE_IX  (Index) 
--
CREATE INDEX HR.LOC_STATE_PROVINCE_IX ON HR.LOCATIONS
(STATE_PROVINCE)
LOGGING
TABLESPACE USERS
NOPARALLEL;


ALTER TABLE HR.DEPARTMENTS
 DROP PRIMARY KEY CASCADE;

DROP TABLE HR.DEPARTMENTS CASCADE CONSTRAINTS;

/* This object may not be sorted properly in the script due to cirular references */
--
-- DEPARTMENTS  (Table) 
--
CREATE TABLE HR.DEPARTMENTS
(
  DEPARTMENT_ID    NUMBER(4),
  DEPARTMENT_NAME  VARCHAR2(30 BYTE) CONSTRAINT DEPT_NAME_NN NOT NULL,
  MANAGER_ID       NUMBER(6),
  LOCATION_ID      NUMBER(4)
)
TABLESPACE USERS
RESULT_CACHE (MODE DEFAULT)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE HR.DEPARTMENTS IS 'Departments table that shows details of departments where employees 
work. Contains 27 rows; references with locations, employees, and job_history tables.';

COMMENT ON COLUMN HR.DEPARTMENTS.DEPARTMENT_ID IS 'Primary key column of departments table.';

COMMENT ON COLUMN HR.DEPARTMENTS.DEPARTMENT_NAME IS 'A not null column that shows name of a department. Administration, 
Marketing, Purchasing, Human Resources, Shipping, IT, Executive, Public 
Relations, Sales, Finance, and Accounting. ';

COMMENT ON COLUMN HR.DEPARTMENTS.MANAGER_ID IS 'Manager_id of a department. Foreign key to employee_id column of employees table. The manager_id column of the employee table references this column.';

COMMENT ON COLUMN HR.DEPARTMENTS.LOCATION_ID IS 'Location id where a department is located. Foreign key to location_id column of locations table.';



ALTER TABLE HR.EMPLOYEES
 DROP PRIMARY KEY CASCADE;

DROP TABLE HR.EMPLOYEES CASCADE CONSTRAINTS;

/* This object may not be sorted properly in the script due to cirular references */
--
-- EMPLOYEES  (Table) 
--
CREATE TABLE HR.EMPLOYEES
(
  EMPLOYEE_ID     NUMBER(6),
  FIRST_NAME      VARCHAR2(20 BYTE),
  LAST_NAME       VARCHAR2(25 BYTE) CONSTRAINT EMP_LAST_NAME_NN NOT NULL,
  EMAIL           VARCHAR2(25 BYTE) CONSTRAINT EMP_EMAIL_NN NOT NULL,
  PHONE_NUMBER    VARCHAR2(20 BYTE),
  HIRE_DATE       DATE CONSTRAINT EMP_HIRE_DATE_NN NOT NULL,
  JOB_ID          VARCHAR2(10 BYTE) CONSTRAINT EMP_JOB_NN NOT NULL,
  SALARY          NUMBER(8,2),
  COMMISSION_PCT  NUMBER(2,2),
  MANAGER_ID      NUMBER(6),
  DEPARTMENT_ID   NUMBER(4)
)
TABLESPACE USERS
RESULT_CACHE (MODE DEFAULT)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE HR.EMPLOYEES IS 'employees table. Contains 107 rows. References with departments, 
jobs, job_history tables. Contains a self reference.';

COMMENT ON COLUMN HR.EMPLOYEES.EMPLOYEE_ID IS 'Primary key of employees table.';

COMMENT ON COLUMN HR.EMPLOYEES.FIRST_NAME IS 'First name of the employee. A not null column.';

COMMENT ON COLUMN HR.EMPLOYEES.LAST_NAME IS 'Last name of the employee. A not null column.';

COMMENT ON COLUMN HR.EMPLOYEES.EMAIL IS 'Email id of the employee';

COMMENT ON COLUMN HR.EMPLOYEES.PHONE_NUMBER IS 'Phone number of the employee; includes country code and area code';

COMMENT ON COLUMN HR.EMPLOYEES.HIRE_DATE IS 'Date when the employee started on this job. A not null column.';

COMMENT ON COLUMN HR.EMPLOYEES.JOB_ID IS 'Current job of the employee; foreign key to job_id column of the 
jobs table. A not null column.';

COMMENT ON COLUMN HR.EMPLOYEES.SALARY IS 'Monthly salary of the employee. Must be greater 
than zero (enforced by constraint emp_salary_min)';

COMMENT ON COLUMN HR.EMPLOYEES.COMMISSION_PCT IS 'Commission percentage of the employee; Only employees in sales 
department elgible for commission percentage';

COMMENT ON COLUMN HR.EMPLOYEES.MANAGER_ID IS 'Manager id of the employee; has same domain as manager_id in 
departments table. Foreign key to employee_id column of employees table.
(useful for reflexive joins and CONNECT BY query)';

COMMENT ON COLUMN HR.EMPLOYEES.DEPARTMENT_ID IS 'Department id where employee works; foreign key to department_id 
column of the departments table';



ALTER TABLE HR.JOB_HISTORY
 DROP PRIMARY KEY CASCADE;

DROP TABLE HR.JOB_HISTORY CASCADE CONSTRAINTS;

/* This object may not be sorted properly in the script due to cirular references */
--
-- JOB_HISTORY  (Table) 
--
CREATE TABLE HR.JOB_HISTORY
(
  EMPLOYEE_ID    NUMBER(6) CONSTRAINT JHIST_EMPLOYEE_NN NOT NULL,
  START_DATE     DATE CONSTRAINT JHIST_START_DATE_NN NOT NULL,
  END_DATE       DATE CONSTRAINT JHIST_END_DATE_NN NOT NULL,
  JOB_ID         VARCHAR2(10 BYTE) CONSTRAINT JHIST_JOB_NN NOT NULL,
  DEPARTMENT_ID  NUMBER(4)
)
TABLESPACE USERS
RESULT_CACHE (MODE DEFAULT)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE HR.JOB_HISTORY IS 'Table that stores job history of the employees. If an employee 
changes departments within the job or changes jobs within the department, 
new rows get inserted into this table with old job information of the 
employee. Contains a complex primary key: employee_id+start_date.
Contains 25 rows. References with jobs, employees, and departments tables.';

COMMENT ON COLUMN HR.JOB_HISTORY.EMPLOYEE_ID IS 'A not null column in the complex primary key employee_id+start_date.
Foreign key to employee_id column of the employee table';

COMMENT ON COLUMN HR.JOB_HISTORY.START_DATE IS 'A not null column in the complex primary key employee_id+start_date. 
Must be less than the end_date of the job_history table. (enforced by 
constraint jhist_date_interval)';

COMMENT ON COLUMN HR.JOB_HISTORY.END_DATE IS 'Last day of the employee in this job role. A not null column. Must be 
greater than the start_date of the job_history table. 
(enforced by constraint jhist_date_interval)';

COMMENT ON COLUMN HR.JOB_HISTORY.JOB_ID IS 'Job role in which the employee worked in the past; foreign key to 
job_id column in the jobs table. A not null column.';

COMMENT ON COLUMN HR.JOB_HISTORY.DEPARTMENT_ID IS 'Department id in which the employee worked in the past; foreign key to deparment_id column in the departments table';



/* This object may not be sorted properly in the script due to cirular references */
--
-- DEPT_ID_PK  (Index) 
--
CREATE UNIQUE INDEX HR.DEPT_ID_PK ON HR.DEPARTMENTS
(DEPARTMENT_ID)
LOGGING
TABLESPACE USERS
NOPARALLEL;


/* This object may not be sorted properly in the script due to cirular references */
--
-- DEPT_LOCATION_IX  (Index) 
--
CREATE INDEX HR.DEPT_LOCATION_IX ON HR.DEPARTMENTS
(LOCATION_ID)
LOGGING
TABLESPACE USERS
NOPARALLEL;


/* This object may not be sorted properly in the script due to cirular references */
--
-- EMP_DEPARTMENT_IX  (Index) 
--
CREATE INDEX HR.EMP_DEPARTMENT_IX ON HR.EMPLOYEES
(DEPARTMENT_ID)
LOGGING
TABLESPACE USERS
NOPARALLEL;


/* This object may not be sorted properly in the script due to cirular references */
--
-- EMP_EMAIL_UK  (Index) 
--
CREATE UNIQUE INDEX HR.EMP_EMAIL_UK ON HR.EMPLOYEES
(EMAIL)
LOGGING
TABLESPACE USERS
NOPARALLEL;


/* This object may not be sorted properly in the script due to cirular references */
--
-- EMP_EMP_ID_PK  (Index) 
--
CREATE UNIQUE INDEX HR.EMP_EMP_ID_PK ON HR.EMPLOYEES
(EMPLOYEE_ID)
LOGGING
TABLESPACE USERS
NOPARALLEL;


/* This object may not be sorted properly in the script due to cirular references */
--
-- EMP_JOB_IX  (Index) 
--
CREATE INDEX HR.EMP_JOB_IX ON HR.EMPLOYEES
(JOB_ID)
LOGGING
TABLESPACE USERS
NOPARALLEL;


/* This object may not be sorted properly in the script due to cirular references */
--
-- EMP_MANAGER_IX  (Index) 
--
CREATE INDEX HR.EMP_MANAGER_IX ON HR.EMPLOYEES
(MANAGER_ID)
LOGGING
TABLESPACE USERS
NOPARALLEL;


/* This object may not be sorted properly in the script due to cirular references */
--
-- EMP_NAME_IX  (Index) 
--
CREATE INDEX HR.EMP_NAME_IX ON HR.EMPLOYEES
(LAST_NAME, FIRST_NAME)
LOGGING
TABLESPACE USERS
NOPARALLEL;


/* This object may not be sorted properly in the script due to cirular references */
--
-- JHIST_DEPARTMENT_IX  (Index) 
--
CREATE INDEX HR.JHIST_DEPARTMENT_IX ON HR.JOB_HISTORY
(DEPARTMENT_ID)
LOGGING
TABLESPACE USERS
NOPARALLEL;


/* This object may not be sorted properly in the script due to cirular references */
--
-- JHIST_EMP_ID_ST_DATE_PK  (Index) 
--
CREATE UNIQUE INDEX HR.JHIST_EMP_ID_ST_DATE_PK ON HR.JOB_HISTORY
(EMPLOYEE_ID, START_DATE)
LOGGING
TABLESPACE USERS
NOPARALLEL;


/* This object may not be sorted properly in the script due to cirular references */
--
-- JHIST_EMPLOYEE_IX  (Index) 
--
CREATE INDEX HR.JHIST_EMPLOYEE_IX ON HR.JOB_HISTORY
(EMPLOYEE_ID)
LOGGING
TABLESPACE USERS
NOPARALLEL;


/* This object may not be sorted properly in the script due to cirular references */
--
-- JHIST_JOB_IX  (Index) 
--
CREATE INDEX HR.JHIST_JOB_IX ON HR.JOB_HISTORY
(JOB_ID)
LOGGING
TABLESPACE USERS
NOPARALLEL;


/* This object may not be sorted properly in the script due to cirular references */
--
-- SECURE_EMPLOYEES  (Trigger) 
--
CREATE OR REPLACE TRIGGER HR.secure_employees
  BEFORE INSERT OR UPDATE OR DELETE ON HR.EMPLOYEES
BEGIN
  secure_dml;
END secure_employees;
/


/* This object may not be sorted properly in the script due to cirular references */
--
-- UPDATE_JOB_HISTORY  (Trigger) 
--
CREATE OR REPLACE TRIGGER HR.update_job_history
  AFTER UPDATE OF job_id, department_id ON HR.EMPLOYEES
  FOR EACH ROW
BEGIN
  add_job_history(:old.employee_id, :old.hire_date, sysdate, 
                  :old.job_id, :old.department_id);
END;
/


-- 
-- Non Foreign Key Constraints for Table JOBS 
-- 
ALTER TABLE HR.JOBS ADD (
  CONSTRAINT JOB_ID_PK
  PRIMARY KEY
  (JOB_ID)
  USING INDEX HR.JOB_ID_PK
  ENABLE VALIDATE);

-- 
-- Non Foreign Key Constraints for Table REGIONS 
-- 
ALTER TABLE HR.REGIONS ADD (
  CONSTRAINT REG_ID_PK
  PRIMARY KEY
  (REGION_ID)
  USING INDEX HR.REG_ID_PK
  ENABLE VALIDATE);

-- 
-- Non Foreign Key Constraints for Table LOCATIONS 
-- 
ALTER TABLE HR.LOCATIONS ADD (
  CONSTRAINT LOC_ID_PK
  PRIMARY KEY
  (LOCATION_ID)
  USING INDEX HR.LOC_ID_PK
  ENABLE VALIDATE);

-- 
-- Non Foreign Key Constraints for Table DEPARTMENTS 
-- 
ALTER TABLE HR.DEPARTMENTS ADD (
  CONSTRAINT DEPT_ID_PK
  PRIMARY KEY
  (DEPARTMENT_ID)
  USING INDEX HR.DEPT_ID_PK
  ENABLE VALIDATE);

-- 
-- Non Foreign Key Constraints for Table EMPLOYEES 
-- 
ALTER TABLE HR.EMPLOYEES ADD (
  CONSTRAINT EMP_SALARY_MIN
  CHECK (salary > 0)
  ENABLE VALIDATE,
  CONSTRAINT EMP_EMP_ID_PK
  PRIMARY KEY
  (EMPLOYEE_ID)
  USING INDEX HR.EMP_EMP_ID_PK
  ENABLE VALIDATE,
  CONSTRAINT EMP_EMAIL_UK
  UNIQUE (EMAIL)
  USING INDEX HR.EMP_EMAIL_UK
  ENABLE VALIDATE);

-- 
-- Non Foreign Key Constraints for Table JOB_HISTORY 
-- 
ALTER TABLE HR.JOB_HISTORY ADD (
  CONSTRAINT JHIST_DATE_INTERVAL
  CHECK (end_date > start_date)
  ENABLE VALIDATE,
  CONSTRAINT JHIST_EMP_ID_ST_DATE_PK
  PRIMARY KEY
  (EMPLOYEE_ID, START_DATE)
  USING INDEX HR.JHIST_EMP_ID_ST_DATE_PK
  ENABLE VALIDATE);

-- 
-- Foreign Key Constraints for Table COUNTRIES 
-- 
ALTER TABLE HR.COUNTRIES ADD (
  CONSTRAINT COUNTR_REG_FK 
  FOREIGN KEY (REGION_ID) 
  REFERENCES HR.REGIONS (REGION_ID)
  ENABLE VALIDATE);

-- 
-- Foreign Key Constraints for Table LOCATIONS 
-- 
ALTER TABLE HR.LOCATIONS ADD (
  CONSTRAINT LOC_C_ID_FK 
  FOREIGN KEY (COUNTRY_ID) 
  REFERENCES HR.COUNTRIES (COUNTRY_ID)
  ENABLE VALIDATE);

-- 
-- Foreign Key Constraints for Table DEPARTMENTS 
-- 
ALTER TABLE HR.DEPARTMENTS ADD (
  CONSTRAINT DEPT_LOC_FK 
  FOREIGN KEY (LOCATION_ID) 
  REFERENCES HR.LOCATIONS (LOCATION_ID)
  ENABLE VALIDATE,
  CONSTRAINT DEPT_MGR_FK 
  FOREIGN KEY (MANAGER_ID) 
  REFERENCES HR.EMPLOYEES (EMPLOYEE_ID)
  ENABLE VALIDATE);

-- 
-- Foreign Key Constraints for Table EMPLOYEES 
-- 
ALTER TABLE HR.EMPLOYEES ADD (
  CONSTRAINT EMP_DEPT_FK 
  FOREIGN KEY (DEPARTMENT_ID) 
  REFERENCES HR.DEPARTMENTS (DEPARTMENT_ID)
  ENABLE VALIDATE,
  CONSTRAINT EMP_JOB_FK 
  FOREIGN KEY (JOB_ID) 
  REFERENCES HR.JOBS (JOB_ID)
  ENABLE VALIDATE,
  CONSTRAINT EMP_MANAGER_FK 
  FOREIGN KEY (MANAGER_ID) 
  REFERENCES HR.EMPLOYEES (EMPLOYEE_ID)
  ENABLE VALIDATE);

-- 
-- Foreign Key Constraints for Table JOB_HISTORY 
-- 
ALTER TABLE HR.JOB_HISTORY ADD (
  CONSTRAINT JHIST_DEPT_FK 
  FOREIGN KEY (DEPARTMENT_ID) 
  REFERENCES HR.DEPARTMENTS (DEPARTMENT_ID)
  ENABLE VALIDATE,
  CONSTRAINT JHIST_EMP_FK 
  FOREIGN KEY (EMPLOYEE_ID) 
  REFERENCES HR.EMPLOYEES (EMPLOYEE_ID)
  ENABLE VALIDATE,
  CONSTRAINT JHIST_JOB_FK 
  FOREIGN KEY (JOB_ID) 
  REFERENCES HR.JOBS (JOB_ID)
  ENABLE VALIDATE);

--
-- Note: 
-- The following objects may not be sorted properly in the script due to cirular references
--
--  DEPARTMENTS  (Table) 
--  EMPLOYEES  (Table) 
--  JOB_HISTORY  (Table) 
--  DEPT_ID_PK  (Index) 
--  DEPT_LOCATION_IX  (Index) 
--  EMP_DEPARTMENT_IX  (Index) 
--  EMP_EMAIL_UK  (Index) 
--  EMP_EMP_ID_PK  (Index) 
--  EMP_JOB_IX  (Index) 
--  EMP_MANAGER_IX  (Index) 
--  EMP_NAME_IX  (Index) 
--  JHIST_DEPARTMENT_IX  (Index) 
--  JHIST_EMP_ID_ST_DATE_PK  (Index) 
--  JHIST_EMPLOYEE_IX  (Index) 
--  JHIST_JOB_IX  (Index) 
--  SECURE_EMPLOYEES  (Trigger) 
--  UPDATE_JOB_HISTORY  (Trigger)
Insert into HR.COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('AR', 'Argentina', 2);
Insert into HR.COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('AU', 'Australia', 3);
Insert into HR.COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('BE', 'Belgium', 1);
Insert into HR.COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('BR', 'Brazil', 2);
Insert into HR.COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('CA', 'Canada', 2);
Insert into HR.COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('CH', 'Switzerland', 1);
Insert into HR.COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('CN', 'China', 3);
Insert into HR.COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('DE', 'Germany', 1);
Insert into HR.COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('DK', 'Denmark', 1);
Insert into HR.COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('EG', 'Egypt', 4);
Insert into HR.COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('FR', 'France', 1);
Insert into HR.COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('HK', 'HongKong', 3);
Insert into HR.COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('IL', 'Israel', 4);
Insert into HR.COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('IN', 'India', 3);
Insert into HR.COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('IT', 'Italy', 1);
Insert into HR.COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('JP', 'Japan', 3);
Insert into HR.COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('KW', 'Kuwait', 4);
Insert into HR.COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('MX', 'Mexico', 2);
Insert into HR.COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('NG', 'Nigeria', 4);
Insert into HR.COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('NL', 'Netherlands', 1);
Insert into HR.COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('SG', 'Singapore', 3);
Insert into HR.COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('UK', 'United Kingdom', 1);
Insert into HR.COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('US', 'United States of America', 2);
Insert into HR.COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('ZM', 'Zambia', 4);
Insert into HR.COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('ZW', 'Zimbabwe', 4);
COMMIT;

Insert into HR.DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (10, 'Administration', 200, 1700);
Insert into HR.DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (20, 'Marketing', 201, 1800);
Insert into HR.DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (30, 'Purchasing', 114, 1700);
Insert into HR.DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (40, 'Human Resources', 203, 2400);
Insert into HR.DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (50, 'Shipping', 121, 1500);
Insert into HR.DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (60, 'IT', 103, 1400);
Insert into HR.DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (70, 'Public Relations', 204, 2700);
Insert into HR.DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (80, 'Sales', 145, 2500);
Insert into HR.DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (90, 'Executive', 100, 1700);
Insert into HR.DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (100, 'Finance', 108, 1700);
Insert into HR.DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (110, 'Accounting', 205, 1700);
Insert into HR.DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (120, 'Treasury', NULL, 1700);
Insert into HR.DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (130, 'Corporate Tax', NULL, 1700);
Insert into HR.DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (140, 'Control And Credit', NULL, 1700);
Insert into HR.DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (150, 'Shareholder Services', NULL, 1700);
Insert into HR.DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (160, 'Benefits', NULL, 1700);
Insert into HR.DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (170, 'Manufacturing', NULL, 1700);
Insert into HR.DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (180, 'Construction', NULL, 1700);
Insert into HR.DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (190, 'Contracting', NULL, 1700);
Insert into HR.DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (200, 'Operations', NULL, 1700);
Insert into HR.DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (210, 'IT Support', NULL, 1700);
Insert into HR.DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (220, 'NOC', NULL, 1700);
Insert into HR.DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (230, 'IT Helpdesk', NULL, 1700);
Insert into HR.DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (240, 'Government Sales', NULL, 1700);
Insert into HR.DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (250, 'Retail Sales', NULL, 1700);
Insert into HR.DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (260, 'Recruiting', NULL, 1700);
Insert into HR.DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (270, 'Payroll', NULL, 1700);
COMMIT;

Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (100, 'Steven', 'King', 'SKING', '515.123.4567', 
    TO_DATE('06/17/1987 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'AD_PRES', 24000, NULL, NULL, 
    90);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', 
    TO_DATE('09/21/1989 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'AD_VP', 17000, NULL, 100, 
    90);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', 
    TO_DATE('01/13/1993 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'AD_VP', 17000, NULL, 100, 
    90);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', 
    TO_DATE('01/03/1990 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'IT_PROG', 9000, NULL, 102, 
    60);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', 
    TO_DATE('05/21/1991 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'IT_PROG', 6000, NULL, 103, 
    60);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (105, 'David', 'Austin', 'DAUSTIN', '590.423.4569', 
    TO_DATE('06/25/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'IT_PROG', 4800, NULL, 103, 
    60);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (106, 'Valli', 'Pataballa', 'VPATABAL', '590.423.4560', 
    TO_DATE('02/05/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'IT_PROG', 4800, NULL, 103, 
    60);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (107, 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', 
    TO_DATE('02/07/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'IT_PROG', 4200, NULL, 103, 
    60);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (108, 'Nancy', 'Greenberg', 'NGREENBE', '515.124.4569', 
    TO_DATE('08/17/1994 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'FI_MGR', 12000, NULL, 101, 
    100);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (109, 'Daniel', 'Faviet', 'DFAVIET', '515.124.4169', 
    TO_DATE('08/16/1994 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'FI_ACCOUNT', 9000, NULL, 108, 
    100);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (110, 'John', 'Chen', 'JCHEN', '515.124.4269', 
    TO_DATE('09/28/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'FI_ACCOUNT', 8200, NULL, 108, 
    100);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (111, 'Ismael', 'Sciarra', 'ISCIARRA', '515.124.4369', 
    TO_DATE('09/30/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'FI_ACCOUNT', 7700, NULL, 108, 
    100);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (112, 'Jose Manuel', 'Urman', 'JMURMAN', '515.124.4469', 
    TO_DATE('03/07/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'FI_ACCOUNT', 7800, NULL, 108, 
    100);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (113, 'Luis', 'Popp', 'LPOPP', '515.124.4567', 
    TO_DATE('12/07/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'FI_ACCOUNT', 6900, NULL, 108, 
    100);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (114, 'Den', 'Raphaely', 'DRAPHEAL', '515.127.4561', 
    TO_DATE('12/07/1994 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'PU_MAN', 11000, NULL, 100, 
    30);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (115, 'Alexander', 'Khoo', 'AKHOO', '515.127.4562', 
    TO_DATE('05/18/1995 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'PU_CLERK', 3100, NULL, 114, 
    30);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (116, 'Shelli', 'Baida', 'SBAIDA', '515.127.4563', 
    TO_DATE('12/24/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'PU_CLERK', 2900, NULL, 114, 
    30);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (117, 'Sigal', 'Tobias', 'STOBIAS', '515.127.4564', 
    TO_DATE('07/24/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'PU_CLERK', 2800, NULL, 114, 
    30);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (118, 'Guy', 'Himuro', 'GHIMURO', '515.127.4565', 
    TO_DATE('11/15/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'PU_CLERK', 2600, NULL, 114, 
    30);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (119, 'Karen', 'Colmenares', 'KCOLMENA', '515.127.4566', 
    TO_DATE('08/10/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'PU_CLERK', 2500, NULL, 114, 
    30);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (120, 'Matthew', 'Weiss', 'MWEISS', '650.123.1234', 
    TO_DATE('07/18/1996 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_MAN', 8000, NULL, 100, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (121, 'Adam', 'Fripp', 'AFRIPP', '650.123.2234', 
    TO_DATE('04/10/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_MAN', 8200, NULL, 100, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (122, 'Payam', 'Kaufling', 'PKAUFLIN', '650.123.3234', 
    TO_DATE('05/01/1995 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_MAN', 7900, NULL, 100, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (123, 'Shanta', 'Vollman', 'SVOLLMAN', '650.123.4234', 
    TO_DATE('10/10/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_MAN', 6500, NULL, 100, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (124, 'Kevin', 'Mourgos', 'KMOURGOS', '650.123.5234', 
    TO_DATE('11/16/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_MAN', 5800, NULL, 100, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (125, 'Julia', 'Nayer', 'JNAYER', '650.124.1214', 
    TO_DATE('07/16/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 3200, NULL, 120, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (126, 'Irene', 'Mikkilineni', 'IMIKKILI', '650.124.1224', 
    TO_DATE('09/28/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 2700, NULL, 120, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (127, 'James', 'Landry', 'JLANDRY', '650.124.1334', 
    TO_DATE('01/14/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 2400, NULL, 120, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (128, 'Steven', 'Markle', 'SMARKLE', '650.124.1434', 
    TO_DATE('03/08/2000 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 2200, NULL, 120, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (129, 'Laura', 'Bissot', 'LBISSOT', '650.124.5234', 
    TO_DATE('08/20/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 3300, NULL, 121, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (130, 'Mozhe', 'Atkinson', 'MATKINSO', '650.124.6234', 
    TO_DATE('10/30/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 2800, NULL, 121, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (131, 'James', 'Marlow', 'JAMRLOW', '650.124.7234', 
    TO_DATE('02/16/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 2500, NULL, 121, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (132, 'TJ', 'Olson', 'TJOLSON', '650.124.8234', 
    TO_DATE('04/10/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 2100, NULL, 121, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (133, 'Jason', 'Mallin', 'JMALLIN', '650.127.1934', 
    TO_DATE('06/14/1996 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 3300, NULL, 122, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (134, 'Michael', 'Rogers', 'MROGERS', '650.127.1834', 
    TO_DATE('08/26/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 2900, NULL, 122, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (135, 'Ki', 'Gee', 'KGEE', '650.127.1734', 
    TO_DATE('12/12/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 2400, NULL, 122, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (136, 'Hazel', 'Philtanker', 'HPHILTAN', '650.127.1634', 
    TO_DATE('02/06/2000 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 2200, NULL, 122, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (137, 'Renske', 'Ladwig', 'RLADWIG', '650.121.1234', 
    TO_DATE('07/14/1995 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 3600, NULL, 123, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (138, 'Stephen', 'Stiles', 'SSTILES', '650.121.2034', 
    TO_DATE('10/26/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 3200, NULL, 123, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (139, 'John', 'Seo', 'JSEO', '650.121.2019', 
    TO_DATE('02/12/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 2700, NULL, 123, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (140, 'Joshua', 'Patel', 'JPATEL', '650.121.1834', 
    TO_DATE('04/06/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 2500, NULL, 123, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (141, 'Trenna', 'Rajs', 'TRAJS', '650.121.8009', 
    TO_DATE('10/17/1995 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 3500, NULL, 124, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (142, 'Curtis', 'Davies', 'CDAVIES', '650.121.2994', 
    TO_DATE('01/29/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 3100, NULL, 124, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (143, 'Randall', 'Matos', 'RMATOS', '650.121.2874', 
    TO_DATE('03/15/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 2600, NULL, 124, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (144, 'Peter', 'Vargas', 'PVARGAS', '650.121.2004', 
    TO_DATE('07/09/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 2500, NULL, 124, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (145, 'John', 'Russell', 'JRUSSEL', '011.44.1344.429268', 
    TO_DATE('10/01/1996 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_MAN', 14000, 0.4, 100, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (146, 'Karen', 'Partners', 'KPARTNER', '011.44.1344.467268', 
    TO_DATE('01/05/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_MAN', 13500, 0.3, 100, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (147, 'Alberto', 'Errazuriz', 'AERRAZUR', '011.44.1344.429278', 
    TO_DATE('03/10/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_MAN', 12000, 0.3, 100, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (148, 'Gerald', 'Cambrault', 'GCAMBRAU', '011.44.1344.619268', 
    TO_DATE('10/15/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_MAN', 11000, 0.3, 100, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (149, 'Eleni', 'Zlotkey', 'EZLOTKEY', '011.44.1344.429018', 
    TO_DATE('01/29/2000 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_MAN', 10500, 0.2, 100, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (150, 'Peter', 'Tucker', 'PTUCKER', '011.44.1344.129268', 
    TO_DATE('01/30/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 10000, 0.3, 145, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (151, 'David', 'Bernstein', 'DBERNSTE', '011.44.1344.345268', 
    TO_DATE('03/24/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 9500, 0.25, 145, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (152, 'Peter', 'Hall', 'PHALL', '011.44.1344.478968', 
    TO_DATE('08/20/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 9000, 0.25, 145, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (153, 'Christopher', 'Olsen', 'COLSEN', '011.44.1344.498718', 
    TO_DATE('03/30/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 8000, 0.2, 145, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (154, 'Nanette', 'Cambrault', 'NCAMBRAU', '011.44.1344.987668', 
    TO_DATE('12/09/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 7500, 0.2, 145, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (155, 'Oliver', 'Tuvault', 'OTUVAULT', '011.44.1344.486508', 
    TO_DATE('11/23/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 7000, 0.15, 145, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (156, 'Janette', 'King', 'JKING', '011.44.1345.429268', 
    TO_DATE('01/30/1996 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 10000, 0.35, 146, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (157, 'Patrick', 'Sully', 'PSULLY', '011.44.1345.929268', 
    TO_DATE('03/04/1996 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 9500, 0.35, 146, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (158, 'Allan', 'McEwen', 'AMCEWEN', '011.44.1345.829268', 
    TO_DATE('08/01/1996 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 9000, 0.35, 146, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (159, 'Lindsey', 'Smith', 'LSMITH', '011.44.1345.729268', 
    TO_DATE('03/10/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 8000, 0.3, 146, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (160, 'Louise', 'Doran', 'LDORAN', '011.44.1345.629268', 
    TO_DATE('12/15/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 7500, 0.3, 146, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (161, 'Sarath', 'Sewall', 'SSEWALL', '011.44.1345.529268', 
    TO_DATE('11/03/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 7000, 0.25, 146, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (162, 'Clara', 'Vishney', 'CVISHNEY', '011.44.1346.129268', 
    TO_DATE('11/11/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 10500, 0.25, 147, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (163, 'Danielle', 'Greene', 'DGREENE', '011.44.1346.229268', 
    TO_DATE('03/19/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 9500, 0.15, 147, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (164, 'Mattea', 'Marvins', 'MMARVINS', '011.44.1346.329268', 
    TO_DATE('01/24/2000 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 7200, 0.1, 147, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (165, 'David', 'Lee', 'DLEE', '011.44.1346.529268', 
    TO_DATE('02/23/2000 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 6800, 0.1, 147, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (166, 'Sundar', 'Ande', 'SANDE', '011.44.1346.629268', 
    TO_DATE('03/24/2000 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 6400, 0.1, 147, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (167, 'Amit', 'Banda', 'ABANDA', '011.44.1346.729268', 
    TO_DATE('04/21/2000 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 6200, 0.1, 147, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (168, 'Lisa', 'Ozer', 'LOZER', '011.44.1343.929268', 
    TO_DATE('03/11/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 11500, 0.25, 148, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (169, 'Harrison', 'Bloom', 'HBLOOM', '011.44.1343.829268', 
    TO_DATE('03/23/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 10000, 0.2, 148, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (170, 'Tayler', 'Fox', 'TFOX', '011.44.1343.729268', 
    TO_DATE('01/24/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 9600, 0.2, 148, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (171, 'William', 'Smith', 'WSMITH', '011.44.1343.629268', 
    TO_DATE('02/23/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 7400, 0.15, 148, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (172, 'Elizabeth', 'Bates', 'EBATES', '011.44.1343.529268', 
    TO_DATE('03/24/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 7300, 0.15, 148, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (173, 'Sundita', 'Kumar', 'SKUMAR', '011.44.1343.329268', 
    TO_DATE('04/21/2000 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 6100, 0.1, 148, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (174, 'Ellen', 'Abel', 'EABEL', '011.44.1644.429267', 
    TO_DATE('05/11/1996 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 11000, 0.3, 149, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (175, 'Alyssa', 'Hutton', 'AHUTTON', '011.44.1644.429266', 
    TO_DATE('03/19/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 8800, 0.25, 149, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (176, 'Jonathon', 'Taylor', 'JTAYLOR', '011.44.1644.429265', 
    TO_DATE('03/24/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 8600, 0.2, 149, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (177, 'Jack', 'Livingston', 'JLIVINGS', '011.44.1644.429264', 
    TO_DATE('04/23/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 8400, 0.2, 149, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (178, 'Kimberely', 'Grant', 'KGRANT', '011.44.1644.429263', 
    TO_DATE('05/24/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 7000, 0.15, 149, 
    NULL);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (179, 'Charles', 'Johnson', 'CJOHNSON', '011.44.1644.429262', 
    TO_DATE('01/04/2000 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 6200, 0.1, 149, 
    80);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (180, 'Winston', 'Taylor', 'WTAYLOR', '650.507.9876', 
    TO_DATE('01/24/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SH_CLERK', 3200, NULL, 120, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (181, 'Jean', 'Fleaur', 'JFLEAUR', '650.507.9877', 
    TO_DATE('02/23/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SH_CLERK', 3100, NULL, 120, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (182, 'Martha', 'Sullivan', 'MSULLIVA', '650.507.9878', 
    TO_DATE('06/21/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SH_CLERK', 2500, NULL, 120, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (183, 'Girard', 'Geoni', 'GGEONI', '650.507.9879', 
    TO_DATE('02/03/2000 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SH_CLERK', 2800, NULL, 120, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (184, 'Nandita', 'Sarchand', 'NSARCHAN', '650.509.1876', 
    TO_DATE('01/27/1996 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SH_CLERK', 4200, NULL, 121, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (185, 'Alexis', 'Bull', 'ABULL', '650.509.2876', 
    TO_DATE('02/20/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SH_CLERK', 4100, NULL, 121, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (186, 'Julia', 'Dellinger', 'JDELLING', '650.509.3876', 
    TO_DATE('06/24/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SH_CLERK', 3400, NULL, 121, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (187, 'Anthony', 'Cabrio', 'ACABRIO', '650.509.4876', 
    TO_DATE('02/07/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SH_CLERK', 3000, NULL, 121, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (188, 'Kelly', 'Chung', 'KCHUNG', '650.505.1876', 
    TO_DATE('06/14/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SH_CLERK', 3800, NULL, 122, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (189, 'Jennifer', 'Dilly', 'JDILLY', '650.505.2876', 
    TO_DATE('08/13/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SH_CLERK', 3600, NULL, 122, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (190, 'Timothy', 'Gates', 'TGATES', '650.505.3876', 
    TO_DATE('07/11/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SH_CLERK', 2900, NULL, 122, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (191, 'Randall', 'Perkins', 'RPERKINS', '650.505.4876', 
    TO_DATE('12/19/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SH_CLERK', 2500, NULL, 122, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (192, 'Sarah', 'Bell', 'SBELL', '650.501.1876', 
    TO_DATE('02/04/1996 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SH_CLERK', 4000, NULL, 123, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (193, 'Britney', 'Everett', 'BEVERETT', '650.501.2876', 
    TO_DATE('03/03/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SH_CLERK', 3900, NULL, 123, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (194, 'Samuel', 'McCain', 'SMCCAIN', '650.501.3876', 
    TO_DATE('07/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SH_CLERK', 3200, NULL, 123, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (195, 'Vance', 'Jones', 'VJONES', '650.501.4876', 
    TO_DATE('03/17/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SH_CLERK', 2800, NULL, 123, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (196, 'Alana', 'Walsh', 'AWALSH', '650.507.9811', 
    TO_DATE('04/24/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SH_CLERK', 3100, NULL, 124, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (197, 'Kevin', 'Feeney', 'KFEENEY', '650.507.9822', 
    TO_DATE('05/23/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SH_CLERK', 3000, NULL, 124, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (198, 'Donald', 'OConnell', 'DOCONNEL', '650.507.9833', 
    TO_DATE('06/21/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SH_CLERK', 2600, NULL, 124, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (199, 'Douglas', 'Grant', 'DGRANT', '650.507.9844', 
    TO_DATE('01/13/2000 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SH_CLERK', 2600, NULL, 124, 
    50);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (200, 'Jennifer', 'Whalen', 'JWHALEN', '515.123.4444', 
    TO_DATE('09/17/1987 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'AD_ASST', 4400, NULL, 101, 
    10);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (201, 'Michael', 'Hartstein', 'MHARTSTE', '515.123.5555', 
    TO_DATE('02/17/1996 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'MK_MAN', 13000, NULL, 100, 
    20);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (202, 'Pat', 'Fay', 'PFAY', '603.123.6666', 
    TO_DATE('08/17/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'MK_REP', 6000, NULL, 201, 
    20);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (203, 'Susan', 'Mavris', 'SMAVRIS', '515.123.7777', 
    TO_DATE('06/07/1994 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'HR_REP', 6500, NULL, 101, 
    40);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (204, 'Hermann', 'Baer', 'HBAER', '515.123.8888', 
    TO_DATE('06/07/1994 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'PR_REP', 10000, NULL, 101, 
    70);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (205, 'Shelley', 'Higgins', 'SHIGGINS', '515.123.8080', 
    TO_DATE('06/07/1994 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'AC_MGR', 12000, NULL, 101, 
    110);
Insert into HR.EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, 
    DEPARTMENT_ID)
 Values
   (206, 'William', 'Gietz', 'WGIETZ', '515.123.8181', 
    TO_DATE('06/07/1994 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'AC_ACCOUNT', 8300, NULL, 205, 
    110);
COMMIT;

Insert into HR.JOB_HISTORY
   (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
 Values
   (102, TO_DATE('01/13/1993 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('07/24/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'IT_PROG', 60);
Insert into HR.JOB_HISTORY
   (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
 Values
   (101, TO_DATE('09/21/1989 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('10/27/1993 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'AC_ACCOUNT', 110);
Insert into HR.JOB_HISTORY
   (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
 Values
   (101, TO_DATE('10/28/1993 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('03/15/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'AC_MGR', 110);
Insert into HR.JOB_HISTORY
   (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
 Values
   (201, TO_DATE('02/17/1996 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('12/19/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'MK_REP', 20);
Insert into HR.JOB_HISTORY
   (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
 Values
   (114, TO_DATE('03/24/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('12/31/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 50);
Insert into HR.JOB_HISTORY
   (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
 Values
   (122, TO_DATE('01/01/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('12/31/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 50);
Insert into HR.JOB_HISTORY
   (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
 Values
   (200, TO_DATE('09/17/1987 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('06/17/1993 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'AD_ASST', 90);
Insert into HR.JOB_HISTORY
   (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
 Values
   (176, TO_DATE('03/24/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('12/31/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 80);
Insert into HR.JOB_HISTORY
   (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
 Values
   (176, TO_DATE('01/01/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('12/31/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_MAN', 80);
Insert into HR.JOB_HISTORY
   (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
 Values
   (200, TO_DATE('07/01/1994 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('12/31/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'AC_ACCOUNT', 90);
COMMIT;

Insert into HR.JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('AD_PRES', 'President', 20000, 40000);
Insert into HR.JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('AD_VP', 'Administration Vice President', 15000, 30000);
Insert into HR.JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('AD_ASST', 'Administration Assistant', 3000, 6000);
Insert into HR.JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('FI_MGR', 'Finance Manager', 8200, 16000);
Insert into HR.JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('FI_ACCOUNT', 'Accountant', 4200, 9000);
Insert into HR.JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('AC_MGR', 'Accounting Manager', 8200, 16000);
Insert into HR.JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('AC_ACCOUNT', 'Public Accountant', 4200, 9000);
Insert into HR.JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('SA_MAN', 'Sales Manager', 10000, 20000);
Insert into HR.JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('SA_REP', 'Sales Representative', 6000, 12000);
Insert into HR.JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('PU_MAN', 'Purchasing Manager', 8000, 15000);
Insert into HR.JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('PU_CLERK', 'Purchasing Clerk', 2500, 5500);
Insert into HR.JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('ST_MAN', 'Stock Manager', 5500, 8500);
Insert into HR.JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('ST_CLERK', 'Stock Clerk', 2000, 5000);
Insert into HR.JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('SH_CLERK', 'Shipping Clerk', 2500, 5500);
Insert into HR.JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('IT_PROG', 'Programmer', 4000, 10000);
Insert into HR.JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('MK_MAN', 'Marketing Manager', 9000, 15000);
Insert into HR.JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('MK_REP', 'Marketing Representative', 4000, 9000);
Insert into HR.JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('HR_REP', 'Human Resources Representative', 4000, 9000);
Insert into HR.JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('PR_REP', 'Public Relations Representative', 4500, 10500);
COMMIT;

Insert into HR.LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, 
    COUNTRY_ID)
 Values
   (1000, '1297 Via Cola di Rie', '00989', 'Roma', NULL, 
    'IT');
Insert into HR.LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, 
    COUNTRY_ID)
 Values
   (1100, '93091 Calle della Testa', '10934', 'Venice', NULL, 
    'IT');
Insert into HR.LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, 
    COUNTRY_ID)
 Values
   (1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 
    'JP');
Insert into HR.LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, 
    COUNTRY_ID)
 Values
   (1300, '9450 Kamiya-cho', '6823', 'Hiroshima', NULL, 
    'JP');
Insert into HR.LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, 
    COUNTRY_ID)
 Values
   (1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 
    'US');
Insert into HR.LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, 
    COUNTRY_ID)
 Values
   (1500, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 
    'US');
Insert into HR.LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, 
    COUNTRY_ID)
 Values
   (1600, '2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 
    'US');
Insert into HR.LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, 
    COUNTRY_ID)
 Values
   (1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 
    'US');
Insert into HR.LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, 
    COUNTRY_ID)
 Values
   (1800, '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 
    'CA');
Insert into HR.LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, 
    COUNTRY_ID)
 Values
   (1900, '6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 
    'CA');
Insert into HR.LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, 
    COUNTRY_ID)
 Values
   (2000, '40-5-12 Laogianggen', '190518', 'Beijing', NULL, 
    'CN');
Insert into HR.LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, 
    COUNTRY_ID)
 Values
   (2100, '1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', 
    'IN');
Insert into HR.LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, 
    COUNTRY_ID)
 Values
   (2200, '12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', 
    'AU');
Insert into HR.LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, 
    COUNTRY_ID)
 Values
   (2300, '198 Clementi North', '540198', 'Singapore', NULL, 
    'SG');
Insert into HR.LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, 
    COUNTRY_ID)
 Values
   (2400, '8204 Arthur St', NULL, 'London', NULL, 
    'UK');
Insert into HR.LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, 
    COUNTRY_ID)
 Values
   (2500, 'Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford', 
    'UK');
Insert into HR.LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, 
    COUNTRY_ID)
 Values
   (2600, '9702 Chester Road', '09629850293', 'Stretford', 'Manchester', 
    'UK');
Insert into HR.LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, 
    COUNTRY_ID)
 Values
   (2700, 'Schwanthalerstr. 7031', '80925', 'Munich', 'Bavaria', 
    'DE');
Insert into HR.LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, 
    COUNTRY_ID)
 Values
   (2800, 'Rua Frei Caneca 1360 ', '01307-002', 'Sao Paulo', 'Sao Paulo', 
    'BR');
Insert into HR.LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, 
    COUNTRY_ID)
 Values
   (2900, '20 Rue des Corps-Saints', '1730', 'Geneva', 'Geneve', 
    'CH');
Insert into HR.LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, 
    COUNTRY_ID)
 Values
   (3000, 'Murtenstrasse 921', '3095', 'Bern', 'BE', 
    'CH');
Insert into HR.LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, 
    COUNTRY_ID)
 Values
   (3100, 'Pieter Breughelstraat 837', '3029SK', 'Utrecht', 'Utrecht', 
    'NL');
Insert into HR.LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, 
    COUNTRY_ID)
 Values
   (3200, 'Mariano Escobedo 9991', '11932', 'Mexico City', 'Distrito Federal,', 
    'MX');
COMMIT;

Insert into HR.REGIONS
   (REGION_ID, REGION_NAME)
 Values
   (1, 'Europe');
Insert into HR.REGIONS
   (REGION_ID, REGION_NAME)
 Values
   (2, 'Americas');
Insert into HR.REGIONS
   (REGION_ID, REGION_NAME)
 Values
   (3, 'Asia');
Insert into HR.REGIONS
   (REGION_ID, REGION_NAME)
 Values
   (4, 'Middle East and Africa');
COMMIT;
