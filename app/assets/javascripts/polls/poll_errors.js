$(document).ready(function() {
   $("#poll-form").on('ajax:success', function(evt, data, status, xhr){
      response = evt["detail"][0]
      console.log(response)
      if (response["status"] == "error") {
         console.log("pass")
         $('#poll-error-messages').html(response["message"]);
      } else if (response["status"] == "success") {
         location.reload()
      }
   });
});