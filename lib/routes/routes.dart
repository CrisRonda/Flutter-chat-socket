import 'package:chat_app_sockets/screens/chat_pages.dart';
import 'package:chat_app_sockets/screens/loading_pages.dart';
import 'package:chat_app_sockets/screens/login_pages.dart';
import 'package:chat_app_sockets/screens/register_pages.dart';
import 'package:chat_app_sockets/screens/users_pages.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  "users": (_) => UsersPage(),
  "chat": (_) => ChatPage(),
  "login": (_) => LoginPage(),
  "loading": (_) => LoadingPage(),
  "register": (_) => RegisterPage(),
};
