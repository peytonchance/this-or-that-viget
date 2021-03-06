var optionA
var optionB

$(document).ready(vote);

$('#all-polls').on('updated', function(event) {
  vote()
});

function vote() {
  var $options = $(".option-poll")
  $options.bind('ajax:success', function(evt, data, status, xhr) {
    updateOptions(evt, data, status, xhr);
  }).bind('ajax:error', function(evt, xhr, status, error){
    console.log("Unauthorized user")
  });
}

function updateOptions(evt, data, status, xhr) {
  response = evt.detail[0]
  optionA = document.getElementById('option-a-' + response.poll)
  optionB = document.getElementById('option-b-' + response.poll)

  if (response.pathA && response.pathB) {
    optionA.setAttribute('href', response.pathA)
    optionA.setAttribute('data-method', response.methodA)

    optionB.setAttribute('href', response.pathB)
    optionB.setAttribute('data-method', response.methodB)

    document.querySelector('#poll-vote-count-' + response.poll).innerHTML = response.count
  }

  displayPercentages(response, optionA, optionB)
}

function displayPercentages(response, optionA, optionB) {
  selectedOption = response.option
  optionABox = document.querySelector('#option-a-' + response.poll)
  optionBBox = document.querySelector('#option-b-' + response.poll)
  optionAPercentage = document.querySelector('#option-a__percentage-' + response.poll)
  optionBPercentage = document.querySelector('#option-b__percentage-' + response.poll)
  optionAText = document.querySelector('#option-a-text-' + response.poll)
  optionBText = document.querySelector('#option-b-text-' + response.poll)

  optionAText.innerHTML = response.optionAText
  optionBText.innerHTML = response.optionBText

  if (response.option == 0) {
    optionBBox.classList.remove('poll__options__option--selected')
    optionABox.classList.add('poll__options__option--selected')
  } else {
    optionABox.classList.remove('poll__options__option--selected')
    optionBBox.classList.add('poll__options__option--selected')
  }

  if (!response.delete) {
    optionAPercentage.innerHTML = Math.round(response.optionA * 100) + '%'
    optionBPercentage.innerHTML = Math.round(response.optionB * 100) + '%'
  } else {
    optionABox.classList.remove('poll__options__option--selected')
    optionBBox.classList.remove('poll__options__option--selected')
    optionAPercentage.innerHTML = ''
    optionBPercentage.innerHTML = ''
  }

  optionA.style.width = (response.optionA * 100) + '%'
  optionB.style.width = (response.optionB * 100) + '%'

  if (response.optionA === 0) {
    optionAText.innerHTML = ''
    optionAPercentage.innerHTML = ''
    optionA.classList.add('poll__options__option--no-votes')
  } else {
    optionA.classList.remove('poll__options__option--no-votes')
  }

  if (response.optionB === 0) {
    optionBText.innerHTML = ''
    optionBPercentage.innerHTML = ''
    optionB.classList.add('poll__options__option--no-votes')
  } else {
    optionB.classList.remove('poll__options__option--no-votes')
  }
}
