import 'package:chat_app_sockets/routes/routes.dart';
import 'package:chat_app_sockets/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        )
      ],
      child: MaterialApp(
        title: 'Chat App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: appRoutes,
      ),
    );
  }
}
