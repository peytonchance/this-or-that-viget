$(document).ready(function() {
   $("#poll-form").on('ajax:success', function(evt, data, status, xhr){
      response = evt["detail"][0]
      console.log(response)
      dataLayer.push({'event': 'pollCreateSuccess'})
      location.reload()
   }).on('ajax:error', function(evt, xhr, status, error) {
      response = evt["detail"][0]
      $('#poll-error-messages').html(response["message"])
   });
});