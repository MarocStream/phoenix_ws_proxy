# Phoenix Websocket Proxy

## Making Websockets Work

### Phoenix

[Phoenix Web Framework](http://www.phoenixframework.org/) was written by a Rails developer who had troubles getting web sockets working with faye and event machine.

[Elixir](http://elixir-lang.org/) is specifically well suited to handle web sockets because of its process model of concurrency.

This app was written to help take an existing Rails app and extend it with websockets without having to port the app over to phoenix.

## Setup

### Development

Take the `web/static/vendor/phoenix.js` and include in your application.

#### Rails modifications

Add the following routes: (call them whatever you want)

    get '/session/auth', controller: SessionController, action: :auth
    get '/sessions/reauth/:token', controller: SessionController, action: :reauth

Add the following to your Rails application in an authorized route:

    def auth
      render json: {token: Rails.application.message_verifier(:session_auth).generate(session.id)}
    end

And then in an *unauthorized* route:

    def reauth
      render json: {session_id: Rails.application.message_verifier(:session_auth).verify(params[:token])}
    end

*Note: This will not work with a cookie store. Suggest using active record store instead.*

In `config/#{Mix.env}.exs` configure according to your application.

#### Start up Phoenix

Run the following from this directory:

    mix deps.get
    mix phoenix.server

#### Connect to the websocket

    // Get a token for a logged in user
    $.getJSON('/session/auth', function(auth){
      var url = '/somethings/5.json'

      // Create a new socket and connect
      socket = new Phoenix.Socket("http://localhost:4000/ws"); // Change for production
      socket.connect();
      socket.join(url, auth.token).receive("ok", function(channel) {

        channel.on("data:update", function(data) {
          // Here is where your data comes in when it has changed!
        });

      });
    })
