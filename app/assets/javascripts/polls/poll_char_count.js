$(document).ready(function() {
  var titleField = document.querySelector('#poll-title')
  var titleChar = document.querySelector('#poll-char-count-title')
  if (titleField != null) {
    titleField.addEventListener('keyup', function(event) {
      changeCharCount(titleChar, 10, 45, titleField.value.length)
    });
  }

  var optionAField = document.querySelector('#poll-option-a')
  var optionAChar = document.querySelector('#poll-char-count-opta')
  if (optionAField != null) {
    optionAField.addEventListener('keyup', function(event) {
      changeCharCount(optionAChar, 1, 25, optionAField.value.length)
    });
  }

  var optionBField = document.querySelector('#poll-option-b')
  var optionBChar = document.querySelector('#poll-char-count-optb')
  if (optionBField != null) {
    optionBField.addEventListener('keyup', function(event) {
      changeCharCount(optionBChar, 1, 25, optionBField.value.length)
    });
  }
});

function pluralize(number, word) {
  if (number == 1) {
    return number + " " + word
  } else {
    return number + " " + word + "s"
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