$(document).ready(function() {
   var $options = $(".option-poll")
   $options.bind('ajax:success', function(evt, data, status, xhr) {
      updateOptions(evt, data, status, xhr);
   }).bind('ajax:error', function(evt, xhr, status, error){
      console.log(evt)
   });
});

function updateOptions(evt, data, status, xhr) {
  response = evt.detail[0]
  optionA = document.getElementById('option-a-' + response.poll)
  optionB = document.getElementById('option-b-' + response.poll)

  if (response.pathA && response.pathB) {
    optionA.setAttribute('href', response.pathA)
    optionA.setAttribute('data-method', response.method)

    optionB.setAttribute('href', response.pathB)
    optionB.setAttribute('data-method', response.method)
  }

  displayPercentages(response, optionA, optionB)
}

function displayPercentages(response, optionA, optionB) {
  optionAPercentage = document.querySelector('#option-a__percentage-' + response.poll)
  optionBPercentage = document.querySelector('#option-b__percentage-' + response.poll)
  optionAText = document.querySelector('#option-a-text-' + response.poll)
  optionBText = document.querySelector('#option-b-text-' + response.poll)

  optionAText.innerHTML = response.optionAText
  optionBText.innerHTML = response.optionBText
  optionAPercentage.innerHTML = response.optionA * 100 + '%'
  optionBPercentage.innerHTML = response.optionB * 100 + '%'
  optionA.style = 'width: ' + (response.optionA * 100) + '%'
  optionB.style = 'width: ' + (response.optionB * 100) + '%'

  if (response.optionA === 0) {
    optionAText.innerHTML = ''
    optionAPercentage.innerHTML = ''
  }

  if (response.optionB === 0) {
    optionBText.innerHTML = ''
    optionBPercentage.innerHTML = ''
  }
}
