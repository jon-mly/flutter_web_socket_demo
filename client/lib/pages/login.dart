import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_client/controllers/app_controller.dart';
import 'package:socket_client/pages/conversation.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _textController = TextEditingController();

  void _sendUsername(String username) {
    Provider.of<AppController>(context, listen: false).sendUsername(username);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => ConversationPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quel est votre nom d'utilisateur ?"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _textController,
                  onSubmitted: _sendUsername,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24.0),
                ),
                RaisedButton(
                  child: Text("Valider"),
                  onPressed: () => _sendUsername(_textController.text),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
