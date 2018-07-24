$(document).ready(() => {
   let $polls = $(".follow-poll")
   $polls.bind('ajax:success', function(evt, data, status, xhr) {
      updateFollow(evt, data, status, xhr)
   }).bind('ajax:error', function(evt, xhr, status, error){
      handleFollowError(evt, xhr, status, error)
   });
});

let updateFollow = (evt, data, status, xhr) => {
   let { pollId, content, icon, path, method } = evt.detail[0]
   let pollFollowElement = document.getElementById("poll-follow-" + pollId)
   let pollFollowIcon = document.querySelector('#follower-' + pollId)
   pollFollowElement.innerHTML = content
   pollFollowIcon.classList = icon;
   let pollFollowLink = document.getElementById("poll-follow-path-" + pollId)
   pollFollowLink.setAttribute('href', path)
   pollFollowLink.setAttribute('data-method', method)
}

let handleFollowError = (evt, xhr, status, error) => {
   let { pollId, content } = evt.detail[0]
   let pollFollowElement = document.getElementById("poll-follow-" + pollId)
   pollFollowElement.innerHTML = content
}
