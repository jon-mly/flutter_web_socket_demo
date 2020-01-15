import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:socket_client/model/message.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AppController extends ChangeNotifier {
  IO.Socket socket;

  List<Message> _messages = [];
  List<Message> get messages => _messages;

  String _username;
  String get username => _username;

  //
  // ########## LIFECYCLE
  //

  void prepare() {
    print("Preparation");

    if (socket != null) {
      socket.destroy();
      socket = null;
    }

    if (kIsWeb)
      socket = IO.io("http://192.168.1.18:8080", <String, dynamic>{
        'transports': ['websocket'],
      });
    else
      socket = IO.io("http://192.168.1.18:8080");

    socket.on('connect', (_) {
      print("Socket ${socket.id} is connected");
    });

    socket.on('disconnect', (_) {
      socket.destroy();
      socket
       = null;
    });
    
    socket.on('message', _onMessage);

    // socket.connect();
  }

  @override
  void dispose() {
    socket.destroy();
    socket = null;
    super.dispose();
  }

  //
  // ########## ACTIONS
  //

  void setUsername(String newUsername) {
    _username = newUsername;
  }

  //
  // ########## SOCKET
  //

  void sendUsername(String username) {
    setUsername(username);
    socket?.emit('username', username);
  }

  void sendMessage(String content) {
    final Message message = Message(
        type: MessageType.message,
        content: content,
        username: this.username);
    _messages.add(message);
    final String serialized = jsonEncode(message.toMap());
    socket?.emit('message', serialized);
    notifyListeners();
  }

  //
  // ########## SOCKET CALLBACKS
  //

  void _onMessage(dynamic message) {
    print("Received message : ${message.toString()}");
    try {
      // The JSON string to parse may not contain quotes around keys and string values.
      // This, it is needed to encode the string before decoding it so that quotes are
      // added and the content parsable.
      if (!(message is String))
        message = json.encode(message);
      final Map<String, dynamic> decodedMessage = json.decode(message);
      final Message messageObject = Message.fromMap(decodedMessage);
      _messages.add(messageObject);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
