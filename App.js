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

/*
    ROUTES
*/
app.get('/', function(req, res)
{
    res.render('index', {title: "Home Page", active: {Register: true}});
});

app.get('/jobs', function(req, res)
{
    let queryAllJobs = "SELECT * FROM Jobs ORDER BY job_id;";

    db.pool.query(queryAllJobs, function(err, rows, fields){
        res.render('jobs', {title: "Jobs Page", active: {Register: true}, data:rows});
    })
});

app.get('/customers', function(req, res)
{
    let queryAllCustomers = "SELECT * FROM Customers ORDER BY customer_id;";

    db.pool.query(queryAllCustomers, function(err, rows, fields) {
        res.render('customers', {title: "Customers Page", active: {Register: true}, data:rows});
    })
});

app.get('/categories', function(req, res)
{
    let queryAllCategories = "SELECT * FROM Categories ORDER BY category_id;";

    db.pool.query(queryAllCategories, function(err, rows, fields) {
        res.render('categories', {title: "Categories Page", active: {Register: true}, data:rows});
    })
});

app.get('/employees', function(req, res)
{
    let queryAllEmployees = "SELECT * FROM Employees ORDER BY employee_id;";

    db.pool.query(queryAllEmployees, function(err, rows, fields) {
        res.render('employees', {title: "Employees Page", active: {Register: true}, data:rows});
    })
});

app.get('/job_employees', function(req, res)
{
    let queryJobEmployees = "SELECT * FROM Job_Employees ORDER BY job_employee_id;";

    db.pool.query(queryJobEmployees, function(err, rows, fields){
        res.render('job_employees', {title: "Job_Employees Page", active: {Register: true}, data:rows});
    })
});

app.get('/job_employees_search', function(req, res)
{
    // let queryJobEmployeesSearch = "SELECT je.job_employee_id, e.employee_id, CONCAT(e.employee_first_name, ' ', e.employee_last_name) AS name, e.employee_job_title AS title, j.job_id, j.job_description, c.category_id, c.category_name FROM Employees AS e INNER JOIN Job_Employees AS je ON e.employee_id = je.employee_id INNER JOIN Jobs AS j ON j.job_id = je.job_id INNER JOIN Categories AS c ON c.category_id = j.category_id ORDER BY je.job_employee_id;";

    // db.pool.query(queryJobEmployeesSearch, function(err, rows, fields) {
        res.render('job_employees_search', {title: "Job_Employees Search Page", active: {Register: true}});
    // })
});

/*
    LISTENER
*/
app.listen(PORT, function(){
    console.log('Express started on http://localhost:' + PORT + '; press Ctrl-C to terminate.')
});