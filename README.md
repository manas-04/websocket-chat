# websocket_chat_app

A flutter project which provides the functionality of real time chat using websockets.

This project uses bloc for state management and hive for storing data in the localstorage of the application.

Chat Respository has been created to provide the common instance of the websocket throughout the application, which is the connected and disconnected only when user starts a chat.

It also contains the basic functionality of sign up, login and logout and the routes are protected. For routing, initially i used auto_route library but was unable to achieve the solution that was thinking of, so then used the go_router package to get the desired functionality.

Link to the deployed web app - <a href="https://web-socket-chat-app.web.app/">Click here</a>
