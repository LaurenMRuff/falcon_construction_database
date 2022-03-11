// code for deletePerson function using jQuery
function deleteJobEmployee(job_employee_id) {
    console.log("in delete_job_employee.js");
    let link = '/delete-job-employee';
    let data = {
        id: job_employee_id
    };

    $.ajax({
        url: link,
        type: 'DELETE',
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        success: function(result) {
            deleteRow(job_employee_id);
        }
    });
}

function deleteRow(job_employee_id) {

    let table = document.getElementById("job-employee-table");
    for (let i = 0, row; row === table.rows[i]; i++) {
        //iterate through the table rows accessed using the "row" variable assigned in the for loop
        if (table.rows[i].getAttribute("data-value") === job_employee_id) {
            table.deleteRow(i);
            break;
        }
    }
}