$(document).ready(copyLink);

$('#all-polls').on('updated', function(event) {
  copyLink()
});

function copyLink() {
  $('.copy-link-poll').click( function(e) {
    
    var copyValue = document.createElement("textarea");
    
    copyValue.style.position = "absolute";
    copyValue.style.left = "-9999px";
    copyValue.style.top = "0";
    copyValue.id = e.currentTarget.id;
    
    document.body.appendChild(copyValue);
    location.href = '#' + e.currentTarget.id
    copyValue.textContent = e.currentTarget.getAttribute("value");
    
    // select the content
    copyValue.focus();
    copyValue.setSelectionRange(0, copyValue.value.length);
    document.execCommand("copy");
    
    document.body.removeChild(copyValue)
    e.currentTarget.focus()
    
    document.querySelector('#' + e.currentTarget.id.replace('link', 'span')).innerHTML = 'copied'
  });
}