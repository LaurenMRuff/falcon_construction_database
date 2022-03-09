function deleteJob(id){
    $.ajax({
        url: '/jobs/' + id,
        type: 'DELETE',
        success: function(result){
            window.location.reload(true);
        }
    })
};

function deleteProfile(id){
    $.ajax({
        url: '/profiles/' + id,
        type: 'DELETE',
        success: function(result){
            window.location.reload(true);
        }
    })
};

function deletePurchase(id){
    $.ajax({
        url: '/purchases/' + id,
        type: 'DELETE',
        success: function(result){
            window.location.reload(true);
        }
    })
};
