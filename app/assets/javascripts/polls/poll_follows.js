$(document).ready(function() {
   var $polls = $(".follow-poll")
   $polls.bind('ajax:success', function(evt, data, status, xhr) {
      updateFollow(evt, data, status, xhr);
   });
});

function updateFollow(evt, data, status, xhr) {
   console.log(evt)
   console.log(data)
   console.log(status)
   console.log(xhr)
}
