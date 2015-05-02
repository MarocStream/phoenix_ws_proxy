var socket = null;
var join = function(url, auth){
  if(socket) {
    socket.disconnect();
  }
  socket = new Phoenix.Socket("/ws");
  socket.connect();
  socket.join(url, auth).receive("ok", function(channel) {

    channel.on("data:update", function(message) {
      $("#data-container").text(JSON.stringify(message, null, 2));
    });

  });
};

var url = null; // Start out in a "is a change" state
var auth = null;
$('#connect').click(function(){
  // Prevent opening up more than one connection.
  if(url != $('#url').val() || auth != $('#auth').val()){
    url = $('#url').val();
    auth = $('#auth').val();
    join(url, auth);
    $('#data-container').show();
  }
});

$('#stop').click(function(){
  socket.disconnect();
  url = null;
  auth = null;
});

$("#url-container input[type='text']").keyup(function(event){
  if(event.keyCode == 13){
    $("#join").click();
  }
});
