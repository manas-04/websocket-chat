import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketChannel? _socketChannel;
  //Based on the enviornment this string can move to configs files as well
  final String _url = "wss://echo.websocket.org";

  // Connects to the WebSocket server if not already connected.
  void connectWss() {
    final Uri webSocketUrl = Uri.parse(_url);
    if (_socketChannel == null || _socketChannel!.closeCode != null) {
      _socketChannel = WebSocketChannel.connect(webSocketUrl);
    }
  }

  // Sends a message over the WebSocket connection.
  void sendMessage(String message) {
    if (_socketChannel != null) {
      _socketChannel!.sink.add(message);
    } else {
      debugPrint("WebSocket not connected.");
    }
  }

  // Returns a broadcast stream of messages received from the WebSocket server.
  Stream get messageStream {
    connectWss();
    return _socketChannel!.stream.asBroadcastStream();
  }

  // Closes the WebSocket connection.
  void closeConnection() {
    if (_socketChannel != null) {
      _socketChannel!.sink.close();
      _socketChannel = null;
    } else {
      debugPrint("WebSocket already closed.");
    }
  }
}
