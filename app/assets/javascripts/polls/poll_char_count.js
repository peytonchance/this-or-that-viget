$(document).ready(function() {
  var titleField = document.querySelector('#poll-title')
  var titleChar = document.querySelector('#poll-char-count-title')
  const titleMinChar = 10
  const titleMaxChar = 30
  if (titleField) {
    titleField.addEventListener('keyup', function(event) {
      changeCharCount(titleChar, titleMinChar, titleMaxChar, titleField.value.length)
    });
  }

  var optionAField = document.querySelector('#poll-option-a')
  var optionAChar = document.querySelector('#poll-char-count-opta')
  const optionMinChar = 1
  const optionMaxChar = 25
  if (optionAField) {
    optionAField.addEventListener('keyup', function(event) {
      changeCharCount(optionAChar, optionMinChar, optionMaxChar, optionAField.value.length)
    });
  }

  var optionBField = document.querySelector('#poll-option-b')
  var optionBChar = document.querySelector('#poll-char-count-optb')
  if (optionBField) {
    optionBField.addEventListener('keyup', function(event) {
      changeCharCount(optionBChar, optionMinChar, optionMaxChar, optionBField.value.length)
    });
  }
});

function pluralize(number, word) {
  if (number == 1) {
    return `${number} ${word}`
  } else {
    return `${number} ${word}s`
  }
}

function changeCharCount(element, min, max, count) {
  if (count < min) {
    element.innerHTML = "(must have " + pluralize(min - count, "more character") + ")"
    element.style["color"] = "red"
  } else if (count <= max) {
    element.innerHTML = "(" + pluralize(max - count, "character") + "  remaining)"
    element.style["color"] = "black"
  } else {
    element.innerHTML = "(must remove " + pluralize(count - max, "character") + ")"
    element.style["color"] = "red"
  }
}