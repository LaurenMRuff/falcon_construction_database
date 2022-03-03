// Get an instance of mysql we can use in the app
let mysql = require('mysql')

// Create a 'connection pool' using the provided credentials
let pool = mysql.createPool({
    connectionLimit : 10,
    host            : 'classmysql.engr.oregonstate.edu',
    user            : 'cs340_ruffl',
    password        : '3148',
    database        : 'cs340_ruffl'
})

// Export it for use in our application
module.exports.pool = pool;