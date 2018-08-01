$(document).ready(function() {
    var commentEdits = document.getElementsByClassName('edit-comment')
    console.log(commentEdits)
    if (commentEdits.length > 0) {
      for (commentEdit in commentEdits) {
         console.log(commentEdit)
      }
    }
});