$(document).ready(function() {
    var commentEdits = document.getElementsByClassName('edit-comment')
    //console.log(commentEdits)
    if (commentEdits.length > 0) {
      for (i = 0; i < commentEdits.length; i++) {
        commentEdits[i].addEventListener('click', handleEditComment)
      }
    }
});

function handleEditComment(e) {
  console.log(e)
}