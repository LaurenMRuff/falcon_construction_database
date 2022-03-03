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
    let queryAllJobs = "SELECT * FROM Jobs;";

    db.pool.query(queryAllJobs, function(err, rows, fields){
        res.render('jobs', {title: "Jobs Page", active: {Register: true}, data:rows});
    })
});

app.get('/customers', function(req, res)
{
    let queryAllCustomers = "SELECT * FROM Customers;";

    db.pool.query(queryAllCustomers, function(err, rows, fields) {
        res.render('customers', {title: "Customers Page", active: {Register: true}, data:rows});
    })
});
app.get('/categories', function(req, res)
{
    res.render('categories', {title: "Categories Page", active: {Register: true}});
});
app.get('/employees', function(req, res)
{
    res.render('employees', {title: "Employees Page", active: {Register: true}});
});
app.get('/job_employees', function(req, res)
{
    res.render('job_employees', {title: "Job_Employees Page", active: {Register: true}});
});
app.get('/job_employees_search', function(req, res)
{
    res.render('job_employees_search', {title: "Job_Employees Search Page", active: {Register: true}});
});

/*
    LISTENER
*/
app.listen(PORT, function(){
    console.log('Express started on http://localhost:' + PORT + '; press Ctrl-C to terminate.')
});