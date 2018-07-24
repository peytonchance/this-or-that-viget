$(document).ready(function() {
   var $polls = $(".follow-poll")
   $polls.bind('ajax:success', function(evt, data, status, xhr) {
      updateFollow(evt, data, status, xhr);
   }).bind('ajax:error', function(evt, xhr, status, error){
      handleFollowError(evt, xhr, status, error)
   });
});

function updateFollow(evt, data, status, xhr) {
   response = evt["detail"][0]
   pollId = response["pollId"]
   pollFollowElement = document.getElementById("poll-follow-" + pollId)
   var pollFollowIcon = document.querySelector('#follower-' + pollId)
   pollFollowElement.innerHTML = response["content"]
   pollFollowIcon.classList = response["icon"];
   console.log(pollFollowIcon.classList)
   pollFollowLink = document.getElementById("poll-follow-path-" + pollId)
   pollFollowLink.setAttribute('href', response["path"])
   pollFollowLink.setAttribute('data-method', response["method"])

}

function handleFollowError(evt, xhr, status, error) {
   response = evt["detail"][0]
   pollId = response["pollId"]
   console.log(response)
   pollFollowElement = document.getElementById("poll-follow-" + pollId)
   console.log(pollFollowElement)
   pollFollowElement.innerHTML = response["content"]
}
