$(document).ready(function() {
   var $options = $(".option-poll")
   $options.bind('ajax:success', function(evt, data, status, xhr) {
      updateOptions(evt, data, status, xhr);
   }).bind('ajax:error', function(evt, xhr, status, error){
      console.log(evt)
   });
});

function updateOptions(evt, data, status, xhr) {
   response = evt["detail"][0]
   if (response["pathA"] && response["pathB"]) {
      console.log("path change")
      optionA = document.getElementById('option-a-' + response["poll"])
      optionA.setAttribute('href', response["pathA"])
      optionA.setAttribute('data-method', response["method"])
      
      optionB = document.getElementById('option-b-' + response["poll"])
      optionB.setAttribute('href', response["pathB"])
      optionB.setAttribute('data-method', response["method"])
   }
   
   console.log(response)

}