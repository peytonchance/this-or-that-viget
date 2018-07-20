$(document).ready(function() {
    $('#comment-submit').click(function() {
        $('form#comment-form').submit(function(event) {
            var valuesToSubmit = $(this).serialize();
            
            $.ajax({
                type: "POST",
                url: $(this).attr('action'),
                data: valuesToSubmit
                
            }).success(function(json){
                $('#comment-field').append(json["content"]);
                
            }).error(function(json){
                response = json["responseJSON"]
                $("#comment-error-messages").html(response["message"])
                
            });
            return false; // prevents 
        });
    });
});