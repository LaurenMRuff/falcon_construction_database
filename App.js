/*
    SETUP
*/

// Express
var express = require('express');
var app = express();
PORT = 9125;

// Database
var db = require('./database/db-connector')

// Handlebars
const { engine } = require('express-handlebars');
var exphbs = require('express-handlebars');     // Import express-handlebars
app.engine('.hbs', engine({extname: ".hbs"}));  // Create an instance of the handlebars engine to process templates
app.set('view engine', '.hbs');                  // Tell express to use the handlebars engine whenever it encounters a *.hbs file.
const hbs = require('hbs');
hbs.registerPartials(__dirname + '/partials');

var bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: false }))

/*
    ROUTES
*/
// WORKS!
app.get('/', function(req, res)
{
    res.render('index', {title: "Home Page", active: {Register: true}});
});

// WORKS!
app.get('/jobs', function(req, res)
{
    // dropdown populating lists
    let customers = [];
    let categories = [];
    let jobStatus = ['New', 'In Progress', 'Complete', 'Abandoned'];

    // queries
    let queryAllJobs = "SELECT * FROM Jobs ORDER BY job_id;";
    let queryCustomerID = "SELECT customer_id FROM Customers ORDER BY customer_id";
    let queryCategoryID = "SELECT category_id FROM Categories ORDER BY category_id";

    db.pool.query(queryCustomerID, function (err, rows, fields){
        for ( let i = 0; i < rows.length; i++)
        {
            customers.push(rows[i]["customer_id"]);
        }
    })

    db.pool.query(queryCategoryID, function (err, rows, fields){
        for ( let i = 0; i < rows.length; i++)
        {
            categories.push(rows[i]["category_id"]);
        }
    })

    db.pool.query(queryAllJobs, function(err, rows, fields){
        res.render('jobs', {title: "Jobs Page", active: {Register: true}, data:rows,
            customers : customers, categories : categories, jobStatus : jobStatus});
    })
});

// WORKS!
app.post('/add-job', function(req, res){
    let data = req.body;

    let end_date = data.job_end_date;
    if (isNaN(end_date) || typeof(end_date) == "undefined"){
        end_date = null;
    }

    let queryAddJob = `INSERT INTO Jobs (fk_customer_id, fk_category_id, job_code, job_start_date, job_end_date, job_description, job_status) VALUES (${data['customer_ID_Select']}, ${data['category_ID_Select']}, '${data['job_code']}', '${data['job_start_date']}', ${end_date}, '${data['job_description']}', '${data['job_status']}')`;

    db.pool.query(queryAddJob, function(error, rows, fields) {

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

// WORKS!
app.get('/customers', function(req, res)
{
    //NEED TO ADD DROPDOWN FORM INFO

    let queryAllCustomers = "SELECT * FROM Customers ORDER BY customer_id;";

    db.pool.query(queryAllCustomers, function(err, rows, fields) {
        res.render('customers', {title: "Customers Page", active: {Register: true}, data:rows});
    })
});

// WORKS!
app.get('/categories', function(req, res)
{
    //NEED TO ADD DROPDOWN FORM INFO

    let queryAllCategories = "SELECT * FROM Categories ORDER BY category_id;";

    db.pool.query(queryAllCategories, function(err, rows, fields) {
        res.render('categories', {title: "Categories Page", active: {Register: true}, data:rows});
    })
});

// WORKS!
app.get('/employees', function(req, res)
{
    //NEED TO ADD DROPDOWN FORM INFO

    let queryAllEmployees = "SELECT * FROM Employees ORDER BY employee_id;";

    db.pool.query(queryAllEmployees, function(err, rows, fields) {
        res.render('employees', {title: "Employees Page", active: {Register: true}, data:rows});
    })
});

// WORKS!
app.get('/job_employees', function(req, res)
{
    //NEED TO ADD DROPDOWN FORM INFO

    //SELECTS ALL JOB_EMPLOYEES FROM JOB_EMPLOYEES TABLE AND ADDS THEM TO HTML TABLE
    let queryJobEmployees = "SELECT * FROM Job_Employees ORDER BY job_employee_id;";
    db.pool.query(queryJobEmployees, function(err, rows, fields){
        res.render('job_employees', {title: "Job_Employees Page", active: {Register: true}, data:rows});
    })
});

// DOES NOT WORK
app.get('/job_employees_search', function(req, res)
{

    let job_id = []

    let queryJobID = "SELECT job_id FROM Jobs;";

    db.pool.query(queryJobID, function (err, rows, fields){
        for ( let i = 0; i < rows.length; i++)
        {
            job_id.push(rows[i]["job_id"]);
        }
    })


    let queryJobEmployeesSearch = "SELECT je.job_employee_id AS job_employee_id, e.employee_id AS employee_id, CONCAT(e.employee_first_name, ' ', e.employee_last_name) AS name, e.employee_job_title AS title, j.job_id AS job_id, j.job_description AS job_description, c.category_id AS category_id, c.category_name AS category_name FROM Employees AS e INNER JOIN Job_Employees AS je ON e.employee_id = je.employee_id INNER JOIN Jobs AS j ON j.job_id = je.job_id INNER JOIN Categories AS c ON c.category_id = j.category_id ORDER BY je.job_employee_id;";

    db.pool.query(queryJobEmployeesSearch, function(err, rows, fields) {
        console.log(rows);
        res.render('job_employees_search', {title: "Job_Employees Search Page", active: {Register: true}, job_id : job_id});
    })
});

/*
    LISTENER
*/
app.listen(PORT, function(){
    console.log('Express started on http://localhost:' + PORT + '; press Ctrl-C to terminate.')
});