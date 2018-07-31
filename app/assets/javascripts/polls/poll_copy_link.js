$(document).ready(function() {
  $('.copy-link-poll').click( function(e) {
    
    var target = document.createElement("textarea");
    
    target.style.position = "absolute";
    target.style.left = "-9999px";
    target.style.top = "0";
    target.id = e.currentTarget.id;
    
    document.body.appendChild(target);
    location.href = '#' + e.currentTarget.id
    target.textContent = e.currentTarget.getAttribute("value");
    
    // select the content
    target.focus();
    target.setSelectionRange(0, target.value.length);
    document.execCommand("copy");
    
    document.body.removeChild(target)
    e.currentTarget.focus()
    
    document.querySelector('#' + e.currentTarget.id.replace('link', 'span')).innerHTML = 'copied'
  });
});