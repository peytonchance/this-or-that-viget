$(document).ready(function() {
    changeHeading();
});

function changeHeading() {
    let activeClass = "header__utility-nav--active";
    let currElement = document.getElementsByClassName(activeClass)[0];
    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
        if (key == "filter") {
            if(value == "mypolls") {
                currElement.className = currElement.className.replace(activeClass, '');
                document.getElementById('poll-mypolls').className += (' ' + activeClass);
            } else {
                currElement.className = currElement.className.replace(activeClass, '');
                document.getElementById('poll-following').className += (' ' + activeClass);
            }
        }
    });
}