 import 'package:chat_app_sockets/routes/routes.dart';
import 'package:flutter/material.dart';
import './routes/routes.dart';

 void main() => runApp(MyApp());
  
 class MyApp extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       title: 'Chat App',
       debugShowCheckedModeBanner: false,
       initialRoute: 'loading',
       routes: appRoutes,
     );
   }
 }