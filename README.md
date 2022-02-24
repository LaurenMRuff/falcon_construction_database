# **Falcon Construction Database**

##**Project Proposal**
Falcon Construction company is a large heavy construction and residential construction company with over 100 customers and more than 500 employees. Falcon Construction provides services to their customers, completing over 100 jobs per year. The company does a wide range of construction, including new builds and repairs. With all of this in mind, Falcon Construction would benefit from a central database containing information on jobs performed, more accurate employee tracking, and a central location for customer information. More specifically, the purpose of this database-driven website is to record and track the Jobs performed by Employees of different Categories for Falcon Construction Customers. The company aims to better understand their current customer base and log which employees worked on which jobs.

##Database Outline <br>
####Jobs: table that records all of the details of Jobs that are carried out by Falcon Construction Company.<br>
- job_id: int(10), PK, NOT NULL, AUTO_INCREMENT, UNIQUE
- customer_id: FK,  NOT NULL
- category_id: FK,  NOT NULL
- job_code: varchar(255), NOT NULL
- job_start_date: date, NOT NULL
- job_end_date: date
- job_description: varchar(255)
- job_status: varchar(255), NOT NULL<br>
- **Relationship**: A Many:Many relationship between Jobs and Employees that is implemented as two 1:M relationships with a third join table Job_Employees. Therefore, a 1:M relationship between Jobs and Job_Employees is implemented with job_id as a Foreign Key (FK) inside Job_Employees.<br>
- **Relationship**: A Many:Many relationship between Jobs and Items that is implemented as two 1:M relationships with a third join table Job_Items. Therefore, a 1:M relationship between Jobs and Job_Items is implemented with job_id as a Foreign Key (FK) inside Job_Items.

####Customers: table that records all the details of Customers that Falcon Construction Company conducts business with.
- customer_id: int(10), PK, NOT NULL, AUTO_INCREMENT, UNIQUE
- customer_first_name: varchar(255), NOT NULL
- customer_last_name: varchar(255), NOT NULL
- customer_email: varchar(255), NOT NULL
- customer_phone: varchar(255), NOT NULL
- customer_company: varchar(255)
- customer_address1: varchar(255), NOT NULL
- customer_address2: varchar(5)
- customer_city: varchar(255), NOT NULL
- customer_state: varchar(2), NOT NULL
- customer_zipcode: int(5), NOT NULL
- Relationship: a 1:M relationship between Customers and Jobs is implemented with customer_id as a Foreign Key (FK) inside Jobs.

####Categories: table that records all of the details of Categories that correspond to Jobs carried out at Falcon Construction Company.
- category_id: int(10), PK, NOT NULL, AUTO_INCREMENT, UNIQUE
- category_name: varchar(255), NOT NULL
- Relationship: a 1:M relationship between Categories and Jobs is implemented with category_id as a Foreign Key (FK) inside Jobs.

####Employees: table that records data of Falcon Construction’s on-staff Employees.
- employee_id: int(10), PK, NOT NULL, AUT_INCREMENT, UNIQUE
- employee_code: varchar(10), NOT NULL
- employee_first_name: varchar(255), NOT NULL
- employee_last_name: varchar(255), NOT NULL
- employee_email: varchar(255), NOT NULL
- employee_job_title: varchar(50), NOT NULL
- Relationship: a 1:M relationship between Employees and Jobs_Employees is implemented with employee_id as a Foreign Key (FK) inside Jobs.

####Job_Employees: table that serves as a join table for Jobs and Employees tables.
- job_employee_id:int(10), PK, NOT NULL, AUTO_INCREMENT, UNIQUE
- employee_id: FK, NOT NULL
- job_id: FK, NOT NULL
- Relationship: As mentioned within Jobs, a Many:Many relationship between Jobs and Employees is implemented as two 1:M relationships with  Job_Employees. The two 1:M relationships are between: 1) Jobs and Job_Employees and between 2) Employees and Job_Employees. 

##**ER Diagram**
![CS 340 ERD - Update for Project Step 4](https://user-images.githubusercontent.com/48524322/155455963-f48aa165-ff82-4500-b951-fc421e61c0c5.png)

##**Schema**
![CS 340 Schema  - Update for Project Step 4](https://user-images.githubusercontent.com/48524322/155455823-e6f06b95-eb7a-48b2-8702-e937182a28c1.png)
