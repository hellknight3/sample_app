
$function () {
    if ($('#messages').length > 0) {
          setTimeout(updateComments, 10000);
            }
});

function updateMessages() {
    $.getScript('/messages/new.js?messageable_id='+ current_user.id +'&messageable_type=User');
      setTimeout(updateComments, 10000);
}
