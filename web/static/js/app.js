var socket = null;
var channel = null;
var join = function(url, auth){
  if(socket) {
    socket.disconnect();
  }
  socket = new Phoenix.Socket("/proxy");
  socket.connect();
  channel = socket.chan("proxy:" + url, {session_id: auth, shared: true});

  channel.on("data:update", function(message) {
    $("#data-container").text(JSON.stringify(message, null, 2));
  });

  channel.join().receive("ok", function(messages){
    console.log("JOINED! Messages: " + JSON.stringify(messages));
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
