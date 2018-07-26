$(document).ready(function() {
  let toggled = "feed-filter__item--toggled";
  let currElement = document.querySelector('.' + toggled);
  var query = new URLSearchParams(window.location.search)

  if (currElement != null) {
    if (window.location.search === '') {
      currElement.classList.remove(toggled)
      document.getElementById('poll-recent').classList.add(toggled)
    } else {
      query.forEach(function (value, key) {
        if (key === 'feed' && value === 'popular') {
          currElement.classList.remove(toggled)
          document.getElementById('poll-popular').classList.add(toggled)
        }
      });
    }
  }
});