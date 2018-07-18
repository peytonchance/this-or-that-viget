$(document).ready(function() {
   var $polls = $(".follow-poll")
   $polls.bind('ajax:success', function(evt, data, status, xhr) {
      updateFollow(evt, data, status, xhr);
   }).bind('ajax:error', function(evt, xhr, status, error){
      console.log(evt)
   });
});

function updateFollow(evt, data, status, xhr) {
   response = evt["detail"][0]
   console.log(response);
   pollId = response["pollId"]
   
   pollFollowElement = document.getElementById("poll-follow-" + pollId)
   console.log("poll-follow-" + pollId)
   pollFollowElement.innerHTML = response["content"]
   
   pollFollowLink = document.getElementById("poll-follow-path-" + pollId)
   pollFollowLink.setAttribute('href', response["path"])
   pollFollowLink.setAttribute('data-method', response["method"])
   
   console.log(pollFollowLink)
}


//elButtonUps[i].setAttribute('href', response['path_up']);
//elButtonUps[i].setAttribute('data-method', 'put');