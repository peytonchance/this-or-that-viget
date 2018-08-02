$(document).ready(function() {
  document.addEventListener('ajax:before', function(e) {
    var inputs = e.target.querySelectorAll('input[type="file"]:not([disabled])')
    inputs.forEach(function(input) {
      if (input.files.length > 0) return
      input.setAttribute('data-safari-temp-disabled', 'true')
      input.setAttribute('disabled', '')
    })
  })

  // You should call this by yourself when you aborted an ajax request by stopping a event in ajax:before hook.
  document.addEventListener('ajax:beforeSend', function(e) {
    var inputs = e.target.querySelectorAll('input[type="file"][data-safari-temp-disabled]')
    inputs.forEach(function(input) {
      input.removeAttribute('data-safari-temp-disabled')
      input.removeAttribute('disabled')
    })
  })

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