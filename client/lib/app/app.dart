import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_client/controllers/app_controller.dart';
import 'package:socket_client/pages/login.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final AppController controller = AppController();

  @override
  void initState() {
    super.initState();
    controller.prepare();
  }

  @override
  void dispose() { 
    controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppController>(
      create: (_) => controller,
      child: MaterialApp(
        home: LoginPage(),
      ),
    );
  }
}
