--
-- DML Queries for Jobs
--

-- Query for add a new character functionality with colon : character being used to
-- denote the variables that will have data from the backend programming language

-- DML for Jobs SELECT, INSERT, UPDATE, DELETE
SELECT * FROM Jobs;

INSERT INTO Jobs (job_id, customer_id, category_id, job_code, job_start_date, job_end_date,
                  job_description, job_status)
VALUES(:job_id, :customer_id, :category_id, :job_code, :job_start_date, :job_end_date, :job_description, :job_status);

UPDATE Jobs SET customer_id=:customer_id, category_id=:category_id, job_code=:job_code,
                job_start_date=:job_start_date, job_end_date=:job_end_date, job_description=:job_description,
                job_status=:job_status
WHERE job_id = :job_id;

DELETE FROM Jobs WHERE job_id = :job_id;

-- DML for Customers SELECT, INSERT, UPDATE, DELETE
SELECT * FROM Customers;

INSERT INTO Customers(customer_id, customer_first_name, customer_last_name, customer_email, customer_phone,
                      customer_address1, customer_city, customer_state, customer_zip_code, customer_company)
VALUES(:customer_id, :customer_first_name, :customer_last_name, :customer_email, :customer_phone,
        :customer_address1, :customer_city, :customer_state, :customer_zip_code, :customer_company);

UPDATE Customers SET customer_first_name=:customer_first_name, customer_last_name=:customer_last_name,
                     customer_email=:customer_email, customer_phone=:customer_phone, customer_address1=:customer_address,
                     customer_city=:customer_city, customer_state=:customer_state, customer_zip_code=:customer_zip_code,
                     customer_company=:customer_company
WHERE customer_id=:customer_id;

DELETE FROM Customers WHERE customer_id=:customer_id;


-- DML for Categories SELECT, INSERT, UPDATE, DELETE
SELECT * FROM Categories;

INSERT INTO Categories (category_id, category_name)
VALUES(:category_id, :category_name);

UPDATE Categories SET category_name=:category_name WHERE category_id=:category_id;

DELETE FROM Categories WHERE category_id=:category_id;

-- DML for Employees
SELECT * FROM Employees;

INSERT INTO Employees (employee_id, employee_code, employee_first_name, employee_last_name, employee_email,
                       employee_job_title)
VALUES(:employee_id, :employee_code, :employee_first_name, :employee_last_name, :employee_email, :employee_job_title);

UPDATE Employees SET employee_code=:employee_code, employee_first_name=:employee_first_name,
                     employee_last_name=:employee_last_name, employee_email=:employee_email,
                     employee_job_title=:employee_job_title
WHERE employee_id=:employee_id;

DELETE FROM Employees WHERE employee_id=:employee_id;

-- DML for Items
SELECT * FROM Items;

INSERT INTO Items(item_id, item_name, item_description, item_cost_per_unit)
VALUES(:item_id, :item_name, :item_description, :item_cost_per_unit);

UPDATE Items SET item_name=:item_name, item_description=:item_description, item_cost_per_unit=:item_cost_per_unit
WHERE item_id=:item_id;

DELETE FROM Items WHERE item_id=:item_id;

-- DML for Job_Employees


-- DML for Job_Items