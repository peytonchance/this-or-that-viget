$(document).ready(() => {
   let $polls = $(".follow-poll")
   $polls.bind('ajax:success', function(evt, data, status, xhr) {
      updateFollow(evt, data, status, xhr)
   }).bind('ajax:error', function(evt, xhr, status, error){
      handleFollowError(evt, xhr, status, error)
   });
});

let updateFollow = (evt, data, status, xhr) => {
   let response = evt["detail"][0]
   let pollId = response["pollId"]
   let pollFollowElement = document.getElementById("poll-follow-" + pollId)
   let pollFollowIcon = document.querySelector('#follower-' + pollId)
   pollFollowElement.innerHTML = response["content"]
   pollFollowIcon.classList = response["icon"];
   let pollFollowLink = document.getElementById("poll-follow-path-" + pollId)
   pollFollowLink.setAttribute('href', response["path"])
   pollFollowLink.setAttribute('data-method', response["method"])
}

let handleFollowError = (evt, xhr, status, error) => {
   let response = evt["detail"][0]
   let pollId = response["pollId"]
   let pollFollowElement = document.getElementById("poll-follow-" + pollId)
   pollFollowElement.innerHTML = response["content"]
}
