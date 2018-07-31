$(document).ready(function() {
  let toggled = "feed-filter__item--toggled"
  let currElement = document.querySelector(`.${toggled}`)
  var query = new URLSearchParams(window.location.search)
  var popular = document.querySelector('#poll-popular')
  var recent = document.querySelector('#poll-recent')

  if (currElement != null) {
    if (window.location.search === '') {
      currElement.classList.remove(toggled)
      document.querySelector('#poll-recent').classList.add(toggled)
    } else {
      query.forEach(function (value, key) {
        if (key === 'feed' && value === 'popular') {
          currElement.classList.remove(toggled)
          document.querySelector('#poll-popular').classList.add(toggled)
        }
      });
    }
  }

  var attachAnimations = () => {
    popular.addEventListener('click', () => {
      recent.classList.add('toggle--animating')
    })

    recent.addEventListener('click', () => {
      popular.classList.add('toggle--animating')
    })
  }

  attachAnimations();
});
