$(document).ready(function() {
   changeHeading();
});

function changeHeading() {
   let activeClass = "header__utility-nav--active";
   let currElement = document.querySelector('.' + activeClass);
   var query = new URLSearchParams(window.location.search)

   query.forEach(function (value, key) {
      if (key === 'filter') {
         if(value == "mypolls") {
            currElement.classList.remove(activeClass)
            document.getElementById('poll-mypolls').classList.add(activeClass)
         } else {
            currElement.classList.remove(activeClass)
            document.getElementById('poll-following').classList.add(activeClass)
         }
      }
   });
}