import 'package:meta/meta.dart';

class Message {
  final String content;
  final String username;
  final MessageType type;
  final InfoType info;

  Message(
      {@required this.type, @required this.username, this.content, this.info});

  factory Message.fromMap(Map<String, dynamic> message) {
    return Message(
        type: (message["type"] != null)
            ? MessageType.values[message["type"]]
            : null,
        username: message["username"],
        content: message["content"],
        info: (message["info"] != null)
            ? InfoType.values[message["info"]]
            : null);
  }

  Map<String, dynamic> toMap() {
    return {
      "type": type?.index,
      "username": username,
      "content": content,
      "info": info?.index
    };
  }
}

enum MessageType { message, info }

enum InfoType { join, left }
