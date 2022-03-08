// ---------- SETUP ----------
// Express
var express = require('express');
var app = express();
var router = express.Router();
var mysql = require('./database/db-connector.js');
var db = require('./database/db-connector.js');
//PORT = 5975;
PORT = 5979;

// Database


// Handlebars
const { engine } = require('express-handlebars');
var exphbs = require('express-handlebars');     // Import express-handlebars
app.engine('.hbs', engine({ extname: ".hbs" }));  // Create an instance of the handlebars engine to process templates
app.set('view engine', '.hbs');                  // Tell express to use the handlebars engine whenever it encounters a *.hbs file.
const hbs = require('hbs');
app.set('mysql', mysql);
hbs.registerPartials(__dirname + '/partials');

var bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: true }))
// ---------- END SETUP ----------

// ---------- ROUTES ----------
// WORKS - Home Page
app.get('/', function (req, res) {
    res.render('index', { title: "Home Page", active: { Register: true } });
});

// WORKS - READ Jobs

app.get('/jobs', function (req, res) {
    // dropdown populating lists
    let customers = [];
    let categories = [];
    let jobStatus = ['New', 'In Progress', 'Complete', 'Abandoned'];

    // queries
    let queryAllJobs = `SELECT * FROM Jobs ORDER BY job_id;`;
    let queryCustomerID = `SELECT customer_id, CONCAT(customer_first_name, ' ', customer_last_name) AS name FROM Customers ORDER BY customer_id`;
    let queryCategoryID = `SELECT category_id, category_name FROM Categories ORDER BY category_id`;

    db.pool.query(queryCustomerID, function (err, rows, fields) {
        for (let i = 0; i < rows.length; i++) {
            customers.push([rows[i]["customer_id"], rows[i]["name"]]);
        }
    })
    db.pool.query(queryCategoryID, function (err, rows, fields) {
        for (let i = 0; i < rows.length; i++) {
            categories.push([rows[i]["category_id"], rows[i]["category_name"]]);
        }
    })

    db.pool.query(queryAllJobs, function (err, rows, fields) {
        res.render('jobs', {
            title: "Jobs Page", active: { Register: true }, data: rows,
            customers: customers, categories: categories, jobStatus: jobStatus
        });
    })
});

// WORKS - CREATE/INSERT Jobs
app.post('/add-job', function (req, res) {
    let data = req.body;

    let end_date = data.job_end_date;
    if (isNaN(end_date) || typeof (end_date) == "undefined") {
        end_date = null;
    }

    let queryAddJob =
        `INSERT INTO Jobs (
        fk_customer_id, 
        fk_category_id, 
        job_code, 
        job_start_date, 
        job_end_date, 
        job_description, 
        job_status) 
    
    VALUES (
        '${data['customer_ID_Select']}', 
        '${data['category_ID_Select']}', 
        '${data['job_code']}', 
        '${data['job_start_date']}', 
        '${end_date}', 
        '${data['job_description']}', 
        '${data['job_status']}')`;

    db.pool.query(queryAddJob, function (error, rows, fields) {

        // Check to see if there was an error
        if (error) {

            // Log the error to the terminal, so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error)
            res.sendStatus(400);
        }

        // If there was no error, we redirect back to our root route, which automatically runs the SELECT * FROM bsg_people and
        // presents it on the screen
        else {
            res.redirect('/jobs');
        }
    })
});



// NOT WORKING - UPDATE Jobs
// Get Job to Update
function getJob(res, mysql, context, job_id, complete) {
    var sql = `SELECT job_id as job_id, fk_customer_id, fk_category_id, job_code, job_start_date, job_end_date, job_description, job_status FROM Jobs WHERE Jobs.job_id = ?;`;
    var inserts = [job_id];
    mysql.pool.query(sql, inserts, function (error, results, fields) {
        if (error) {
            res.write(JSON.stringify(error));
            res.end();
        }
        context.job = results[0];
        complete();
    });
}

/* Defines the sql that diplays the category id */
function getCategory_ID(res, mysql, context, complete) {
    mysql.pool.query("SELECT category_id from Categories",
        function (error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end();  //this is the reason that getCategory_ID is passed a 'res'
            }
            context.category_id = results; //if no error then we updated context.people with the results.
            complete();
        });
}

function getCustomer_ID(res, mysql, context, complete) {
    mysql.pool.query("SELECT customer_id from Customers",
        function (error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end();  //this is the reason that getCustomer_ID is passed a 'res'
            }
            context.customer_id = results; //if no error then we updated context.people with the results.
            complete();
        });
}
router.get('/jobs/:id', function (req, res) {
    callbackCount = 0;
    var context = {};
    context.jsscripts = ["update_tbr.js"];
    var mysql = req.app.get('mysql');
    getJob(res, mysql, context, req.params.job_id, complete);
    getCategory_ID(res, mysql, context, complete);
    //getCustomer_ID(res, mysql, context, complete);
    function complete() {
        callbackCount++;
        if (callbackCount >= 2) {
            res.render('update-job', context);
        }
    }
});



app.put('/jobs/:id', function (req, res) {
    let queryUpdateJob =
        `UPDATE Jobs SET fk_customer_id = ?, fk_category_id = ?, job_code = ?, job_start_date = ?, job_end_date = ?, job_description = ?,  job_status = ?, WHERE Jobs.job_id = ?;`;

    var inserts =
    {
        fk_customer_id: req.body.fk_customer_id,
        fk_category_id: req.body.fk_category_id,
        job_code: req.body.job_code,
        job_start_date: req.body.job_start_date,
        job_end_date: req.body.job_end_date,
        job_description: req.body.job_description,
    }

    db.pool.query(queryUpdateJob, inserts, function (error, rows, fields) {
        //if(err) throw err
        if (error) {
            console.log(error)
            res.sendStatus(400);
        }

        // If there was no error, we redirect back to our root route, which automatically runs the SELECT * FROM bsg_people and
        // presents it on the screen
        else {
            res.send(rows);
        }
    })
});


// WORKS - READ Customers
app.get('/customers', function (req, res) {
    // dropdown populating lists

    let cusStates =
        ['AL', 'AK', 'AL', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'DC', 'FL', 'GA', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'ME',
            'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'PR',
            'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY'];

    let queryAllCustomers = `SELECT * FROM Customers ORDER BY customer_id;`;


    db.pool.query(queryAllCustomers, function (err, rows, fields) {
        res.render('customers', {
            title: "Customers Page", active: { Register: true }, data: rows,
            cusStates: cusStates
        });
    })
});

// WORKS - CREATE/INSERT Customers
app.post('/add-customer', function (req, res) {
    let data = req.body;

    let customer_company = data.customer_company;
    if (isNaN(customer_company) || customer_company === 'undefined') {
        customer_company = null;
    }

    let queryAddCustomer =
        `INSERT INTO Customers (
        customer_first_name,
        customer_last_name,
        customer_email,
        customer_phone,
        customer_company,
        customer_address,
        customer_city,
        customer_state,
        customer_zip_code)

    VALUES (
    '${data['customer_first_name']}',
    '${data['customer_last_name']}',
    '${data['customer_email']}',
    '${data['customer_phone']}',
    '${customer_company}',
    '${data['customer_address']}',
    '${data['customer_city']}',
    '${data['customer_state_Select']}',
    '${data['customer_zip_code']}')`;

    db.pool.query(queryAddCustomer, function (error, rows, fields) {

        // Check to see if there was an error
        if (error) {

            // Log the error to the terminal, so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error)
            res.sendStatus(400);
        }

        // If there was no error, we redirect back to our root route, which automatically runs the SELECT * FROM bsg_people and
        // presents it on the screen
        else {
            res.redirect('/customers');
        }
    })
});

// WORKS - READ Categories
app.get('/categories', function (req, res) {
    //NEED TO ADD DROPDOWN FORM INFO

    let queryAllCategories = "SELECT * FROM Categories ORDER BY category_id;";

    db.pool.query(queryAllCategories, function (err, rows, fields) {
        res.render('categories', { title: "Categories Page", active: { Register: true }, data: rows });
    })
});

// WORKS - CREATE/INSERT Categories
app.post('/add-category', function (req, res) {
    let data = req.body;

    let queryAddCategory =
        `INSERT INTO Categories (category_name) 
    VALUES('${data['category_name']}')`;


    db.pool.query(queryAddCategory, function (error, rows, fields) {

        // Check to see if there was an error
        if (error) {

            // Log the error to the terminal, so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error)
            res.sendStatus(400);
        }

        // If there was no error, we redirect back to our root route, which automatically runs the SELECT * FROM bsg_people and
        // presents it on the screen
        else {
            res.redirect('/categories');
        }
    })
});

// WORKS - READ Employees
app.get('/employees', function (req, res) {
    // dropdown populating lists

    let employeeTitles = ['Foreman', 'Lead Foreman', 'Supervisor', 'Manager'];
    let queryAllEmployees = "SELECT * FROM Employees ORDER BY employee_id;";


    db.pool.query(queryAllEmployees, function (err, rows, fields) {
        res.render('employees', {
            title: "Employees Page", active: { Register: true }, data: rows,
            employeeTitles: employeeTitles
        });
    })

});

//  WORKS - CREATE/INSERT Employee
app.post('/add-employee', function (req, res) {
    let data = req.body;

    let queryAddEmployee =
        `INSERT INTO Employees (
        employee_code,
        employee_first_name,
        employee_last_name,
        employee_email,
        employee_job_title
        )
        
    VALUES(
        '${data['employee_code']}',
        '${data['employee_first_name']}',
        '${data['employee_last_name']}',
        '${data['employee_email']}',
        '${data['employee_title']}')`;


    db.pool.query(queryAddEmployee, function (error, rows, fields) {

        // Check to see if there was an error
        if (error) {

            // Log the error to the terminal, so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error)
            res.sendStatus(400);
        }

        // If there was no error, we redirect back to our root route, which automatically runs the SELECT * FROM bsg_people and
        // presents it on the screen
        else {
            res.redirect('/employees');
        }
    })
});

// WORKS - READ Job_Employees
app.get('/job_employees', function (req, res) {

    let employee_id = [];
    let job_id = [];

    let queryEmployeeID = `SELECT employee_id, CONCAT(employee_first_name, ' ', employee_last_name) AS employee_name FROM Employees ORDER BY employee_id`;
    let queryJobID = `SELECT job_id, CONCAT(job_code, ' - ', job_description) AS job_info FROM Jobs ORDER BY job_id`;

    db.pool.query(queryEmployeeID, function (err, rows, fields) {
        for (let i = 0; i < rows.length; i++) {
            employee_id.push([rows[i]["employee_id"], rows[i]["employee_name"]]);
        }
    })

    db.pool.query(queryJobID, function (err, rows, fields) {
        for (let i = 0; i < rows.length; i++) {
            job_id.push([rows[i]["job_id"], rows[i]["job_info"]]);
        }
    })


    //SELECTS ALL JOB_EMPLOYEES FROM JOB_EMPLOYEES TABLE AND ADDS THEM TO HTML TABLE
    let queryJobEmployees = `SELECT * FROM Job_Employees ORDER BY job_employee_id;`;
    db.pool.query(queryJobEmployees, function (err, rows, fields) {
        res.render('job_employees', {
            title: "Job_Employees Page", active: { Register: true }, data: rows,
            employee_id: employee_id, job_id: job_id
        }
        );
    })
});

//  WORKS - CREATE/INSERT Job_Employee
app.post('/add-job-employee', function (req, res) {
    let data = req.body;

    let queryAddJobEmployee =
        `INSERT INTO Job_Employees (
        fk_employee_id,
        fk_job_id)
    VALUES(
        ${data['employee_id']},
        ${data['job_id']})`;


    db.pool.query(queryAddJobEmployee, function (error, rows, fields) {

        // Check to see if there was an error
        if (error) {

            // Log the error to the terminal, so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error)
            res.sendStatus(400);
        }

        // If there was no error, we redirect back to our root route, which automatically runs the SELECT * FROM bsg_people and
        // presents it on the screen
        else {
            res.redirect('/job_employees');
        }
    })
});

// WORKS
app.get('/job_employees_search', function (req, res) {

    let job_id = []

    let queryJobID = `SELECT job_id, CONCAT(job_code, ' - ', job_description) AS job_info FROM Jobs ORDER BY job_id`;

    db.pool.query(queryJobID, function (err, rows, fields) {
        for (let i = 0; i < rows.length; i++) {
            job_id.push(rows[i]["job_id"]);
        }
    })

    db.pool.query(queryJobID, function (err, rows, fields) {
        for (let i = 0; i < rows.length; i++) {
            job_id.push([rows[i]["job_id"], rows[i]["job_info"]]);
        }
    })

    let queryJobEmployeesSearch =
        `SELECT Job_Employees.job_employee_id AS job_employee_id, 
                Jobs.job_id AS job_id, 
                Jobs.job_description AS job_description, 
                Employees.employee_id AS employee_id, 
                CONCAT(Employees.employee_first_name, ' ', Employees.employee_last_name) AS name, 
                Employees.employee_job_title AS title, 
                Categories.category_id AS category_id, 
                Categories.category_name AS category_name 
        FROM Employees 
            INNER JOIN Job_Employees ON Employees.employee_id = Job_Employees.fk_employee_id 
            INNER JOIN Jobs ON Jobs.job_id = Job_Employees.fk_job_id 
            INNER JOIN Categories ON Categories.category_id = Jobs.fk_category_id 
        ORDER BY Job_Employees.job_employee_id;`;

    db.pool.query(queryJobEmployeesSearch, function (err, rows, fields) {
        res.render('job_employees_search', { title: "Job_Employees Search Page", active: { Register: true }, data: rows, job_id: job_id });
    })
});
// ---------- END ROUTES ----------

// ---------- LISTENER ----------
app.listen(PORT, function () {
    console.log('Express started on http://localhost:' + PORT + '; press Ctrl-C to terminate.')
});
// ---------- END LISTENER ----------