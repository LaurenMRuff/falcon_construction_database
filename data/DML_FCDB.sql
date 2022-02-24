--
-- DML Queries for Jobs
--
-- Query for add a new character functionality with colon : character being used to
-- denote the variables that will have data from the backend programming language

-- ------------------Jobs DML------------------

-- Jobs -- SELECT --
-- Get all information to populate Jobs table page
SELECT *
FROM Jobs
ORDER BY job_id;

-- Get category names to populate Dropdown list within "Add new Job"
SELECT category_name
FROM Categories
ORDER BY category_id;

-- Get Customer ID-names to populate Dropdown list within "Add new Job"
SELECT CONCAT(
                customer_id,
                '-',
                customer_first_name,
                ' ',
                customer_last_name
        ) AS id_name
FROM Customers
ORDER BY customer_id;

-- Jobs -- INSERT --
INSERT INTO Jobs (
                  customer_id,
                  category_id,
                  job_code,
                  job_start_date,
                  job_end_date,
                  job_description,
                  job_status
                  )
VALUES(
                  :customer_id,
                  :category_id,
                  :job_code,
                  :job_start_date,
                  :job_end_date,
                  :job_description,
                  :job_status
                  );

-- Jobs -- UPDATE --
UPDATE Jobs
SET customer_id = :customer_id,
    category_id = :category_id,
    job_code = :job_code,
    job_start_date = :job_start_date,
    job_end_date = :job_end_date,
    job_description = :job_description,
    job_status = :job_status
WHERE job_id = :job_id;

-- Jobs -- DELETE --
# DELETE FROM Jobs
# WHERE job_id = :job_id;


--
-- ------------------Customers DML------------------
--

-- Customers -- SELECT --
-- Get all data to populate data tables within Customers Page
SELECT *
FROM Customers
order by customer_id;

-- Customers -- INSERT --
INSERT INTO Customers(
                      customer_first_name,
                      customer_last_name,
                      customer_email,
                      customer_phone,
                      customer_address1,
                      customer_city,
                      customer_state,
                      customer_zip_code,
                      customer_company
                      )
VALUES(
                      :customer_first_name,
                      :customer_last_name,
                      :customer_email,
                      :customer_phone,
                      :customer_address1,
                      :customer_city,
                      :customer_state,
                      :customer_zip_code,
                      :customer_company
                      );

-- Customers -- UPDATE --
UPDATE Customers
SET customer_first_name = :customer_first_name,
    customer_last_name = :customer_last_name,
    customer_email = :customer_email,
    customer_phone = :customer_phone,
    customer_address1 = :customer_address,
    customer_city = :customer_city,
    customer_state = :customer_state,
    customer_zip_code = :customer_zip_code,
    customer_company = :customer_company
WHERE customer_id = :customer_id;

-- Customers -- DELETE --
# DELETE FROM Customers
# WHERE customer_id = :customer_id;

--
-- ------------------Categories DML------------------
--

-- Categories -- SELECT --
SELECT *
FROM Categories
ORDER BY category_id;

-- Categories -- INSERT --
INSERT INTO Categories (category_name)
VALUES(:category_name);

-- Categories -- UPDATE --
UPDATE Categories
SET category_name = :category_name
WHERE category_id = :category_id;

-- Categories -- DELETE --
# DELETE FROM Categories
# WHERE category_id = :category_id;

--
-- ------------------Employees DML------------------
--

-- Employees -- SELECT --
-- Get all data to populate data tables within Employees Page
SELECT *
FROM Employees
ORDER BY employee_id;

-- Employees -- INSERT --
INSERT INTO Employees (
                       employee_code,
                       employee_first_name,
                       employee_last_name,
                       employee_email,
                       employee_job_title
                       )
VALUES(                :employee_code,
                       :employee_first_name,
                       :employee_last_name,
                       :employee_email,
                       :employee_job_title
                       );

-- Employees -- UPDATE --
UPDATE Employees
SET employee_code = :employee_code,
    employee_first_name = :employee_first_name,
    employee_last_name = :employee_last_name,
    employee_email = :employee_email,
    employee_job_title = :employee_job_title
WHERE employee_id = :employee_id;

-- Employees -- DELETE --
# DELETE FROM Employees
# WHERE employee_id = :employee_id;

--
-- ------------------Job_Employees DML------------------
--

-- Job_Employees -- SELECT --
-- Get all data to populate data tables within Job_Employees Page
SELECT job_employee_id,
       job_id,
       employee_id
FROM Job_Employees
ORDER BY job_employee_id;

-- Get Existing Employee ID-names to populate Dropdown list within "Add a New Job_Employee Relationship"
SELECT CONCAT(
                employee_id,
                '-',
                employee_first_name,
                ' ',
                employee_last_name
        ) AS eid_name
FROM Employees
ORDER BY employee_id;

-- Get Job ID-description to populate Dropdown list within "Add a New Job_Employee Relationship"
SELECT CONCAT(
                job_id,
                '-',
                job_description
        ) AS jid_desc
FROM Jobs
ORDER BY job_id;

-- Job_Employees -- INSERT --
INSERT INTO Job_Employee(job_id, employee_id)
VALUES(job_id = :job_id,
       employee_id = :employee_id);

-- Job_Employees -- UPDATE --
UPDATE Job_Employees
SET employee_id = :employee_id,
    job_id = :job_id
WHERE job_employee_id = :job_employee_id;

-- Job_Employees -- DELETE --
DELETE FROM Job_Employees
WHERE job_employee_id = :job_employee_id;

--
-- ------------------Job_Employee Relationship DML------------------
--

-- DML for Job_Employee_Search SELECT
-- Display available data to populate data tables within Job_Employees_Search.HTML landing Page
SELECT je.job_employee_id,
        e.employee_id,
        CONCAT(e.employee_first_name, ' ', e.employee_last_name) AS name,
        e.employee_job_title AS title,
        j.job_id,
        e.job_description,
        c.category_id,
        c.category_name
FROM Employees AS e
        INNER JOIN Job_Employees AS je ON e.employee_id = je.employee_id
        INNER JOIN Jobs AS j ON j.job_id = je.job_id
        INNER JOIN Categories AS c ON c.category_id = j.category_id
ORDER BY je.job_employee_id;

-- Display Employees working on specific jobs based on Job_ID selection
SELECT je.job_employee_id,
        e.employee_id,
        CONCAT(e.employee_first_name, ' ', e.employee_last_name) AS name,
        e.employee_job_title AS title,
        j.job_id,
        j.job_description,
        c.category_id,
        c.category_name
FROM Employees AS e
        INNER JOIN Job_Employees AS je ON e.employee_id = je.employee_id
        INNER JOIN Jobs AS j ON j.job_id = je.job_id
        INNER JOIN Categories AS c ON c.category_id = j.category_id
WHERE j.job_id =:selected_job_id
ORDER BY je.job_employee_id;

-- Get Job ID-description to populate Dropdown list within "Search for Job"
SELECT CONCAT(
                job_id,
                '-',
                job_description
        ) AS jid_desc
FROM Jobs
ORDER BY job_id;
