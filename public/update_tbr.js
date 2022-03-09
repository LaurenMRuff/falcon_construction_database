function updateJob(id){
    $.ajax({
        url: '/jobs/' + id,
        type: 'PUT',
        data: $('#update-job').serialize(),
        success: function(result){
            window.location.replace("./");
        }
    })
};

function updateEmployee(id){
    $.ajax({
        url: '/employees/' + id,
        type: 'PUT',
        data: $('#update-employee').serialize(),
        success: function(result){
            window.location.replace("./");
        }
    })
};

function updateCustomer(id){
    $.ajax({
        url: '/customers/' + id,
        type: 'PUT',
        data: $('#update-customer').serialize(),
        success: function(result){
            window.location.replace("./");
        }
    })
};

function updateCategory(id){
    $.ajax({
        url: '/categories/' + id,
        type: 'PUT',
        data: $('#update-category').serialize(),
        success: function(result){
            window.location.replace("./");
        }
    })
};

function updateJobEmployee(id){
    $.ajax({
        url: '/job_employees/' + id,
        type: 'PUT',
        data: $('#update-job-employee').serialize(),
        success: function(result){
            window.location.replace("./");
        }
    })
};
