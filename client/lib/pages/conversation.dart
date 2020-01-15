import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_client/controllers/app_controller.dart';
import 'package:socket_client/model/message.dart';

class ConversationPage extends StatefulWidget {
  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final TextEditingController _textController = TextEditingController();

  void _sendMessage(String message) {
    if (message != null && message.isNotEmpty)
      Provider.of<AppController>(context, listen: false).sendMessage(message);
  }

  Widget _buildMessagesList() {
    return ListView.builder(
      itemCount: Provider.of<AppController>(context).messages.length,
      itemBuilder: (BuildContext context, int index) {
        final Message message =
            Provider.of<AppController>(context).messages[index];
        if (message.type == MessageType.message)
          return ListTile(
            subtitle: Text(message.username),
            title: Text(message.content),
          );
        else
          return ListTile(
            title: Text(
                message.username +
                    (message.info == InfoType.join
                        ? " a rejoint le chat"
                        : " a quitté le chat"),
                style: TextStyle(fontStyle: FontStyle.italic)),
          );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Conversation"),
        ),
        body: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Text("Votre nom est " +
                  Provider.of<AppController>(context).username),
              Padding(
                padding: EdgeInsets.only(top: 12.0),
              ),
              Expanded(
                child: _buildMessagesList(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12.0),
              ),
              TextField(
                controller: _textController,
                onSubmitted: _sendMessage,
              ),
              Padding(
                padding: EdgeInsets.only(top: 24.0),
              ),
              RaisedButton(
                child: Text("Envoyer"),
                onPressed: () => _sendMessage(_textController.text),
              )
            ],
          ),
        ),
      ),
    );
  }
}
