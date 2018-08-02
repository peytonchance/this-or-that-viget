$(document).ready(function() {
  var commentEdits = document.getElementsByClassName('edit-comment')
  //console.log(commentEdits)
  if (commentEdits.length > 0) {
    for (i = 0; i < commentEdits.length; i++) {
      commentEdits[i].addEventListener('click', handleEditComment)
    }
  }

  $('.comment-edit-form').bind('ajax:success', function(evt, data, status, xhr) {
    response = evt.detail[0]

    form = document.getElementById(`edit-comment-form-${response.id}`)
    form.removeChild(document.getElementById(`edit-comment-${response.id}`))
    form.removeChild(document.getElementById(`edit-comment-submit-${response.id}`))

    commentWrapper.appendChild(commentBody)
    commentBody.innerHTML = response.body
    commentWrapper.appendChild(editCommentButton)
    commentWrapper.appendChild(deleteCommentButton)
    $("#comment-error-messages").html('')

    editCommentButton = null
    deleteCommentButton = null
    commentBody = null
    commentWrapper = null
  }).bind('ajax:error', function(evt, xhr, status, error){
    console.log(evt)
    response = evt.detail[0]
    $("#comment-error-messages").html(response.message)
  });
});

var editCommentButton = null
var deleteCommentButton = null
var commentBody = null
var commentWrapper = null


function handleEditComment(e) {
  if (!editCommentButton && !deleteCommentButton) {
    commentElement = e.srcElement
    commentID = commentElement.getAttribute("commentID")
    commentWrapper = document.getElementById(`comment-${commentID}`)

    editCommentButton = document.getElementById(`comment-edit-${commentID}`)
    deleteCommentButton = document.getElementById(`comment-delete-${commentID}`)

    commentBody = document.getElementById(`comment-body-${commentID}`)
    document.getElementById(`edit-comment-form-${commentID}`).innerHTML += getForm(commentID, commentBody.innerHTML)
    commentWrapper.removeChild(commentBody)
    commentWrapper.removeChild(editCommentButton)
    commentWrapper.removeChild(deleteCommentButton)
  }
}

function getForm(id, value) {
  return `<input type="text" name="body" id="edit-comment-${id}" value="${value}" autocomplete="off" />
<button name="button" type="submit" for="edit-comment-${id}" id="edit-comment-submit-${id}" class="comments__submit">update</button>`
} 

