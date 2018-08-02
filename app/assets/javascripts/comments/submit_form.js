$(document).ready(function() {
    $('#comment-submit').click(function() {
        $('form#comment-form').unbind('submit').submit(function(event) {
            var valuesToSubmit = $(this).serialize();

            $.ajax({
                type: "POST",
                url: $(this).attr('action'),
                data: valuesToSubmit

            }).success(function(json){
                $('#comment-field').append(json["content"]);
                el = document.querySelector('#comment-form')
                el.reset()

            }).error(function(json){
                response = json["responseJSON"]
                $("#comment-error-messages").html(response["message"])

            });
            return false; // prevents
        });
    });
});
