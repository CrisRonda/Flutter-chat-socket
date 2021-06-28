import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';

import 'package:chat_app_sockets/screens/login_pages.dart';
import 'package:chat_app_sockets/screens/users_pages.dart';
import 'package:chat_app_sockets/services/socket_service.dart';
import 'package:chat_app_sockets/services/auth_service.dart';

class LoadingPage extends StatelessWidget {
  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);
    final isAuthenticated = await authService.isUserLogged();
    if (isAuthenticated.ok) {
      socketService.connect();
      return Navigator.pushReplacement(context, customNavigation(UsersPage()));
    }
    return Navigator.pushReplacement(context, customNavigation(LoginPage()));
  }

  PageRouteBuilder<Object> customNavigation(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: Duration(milliseconds: 440),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (contex, snapshot) {
          return Center(
            child: Lottie.asset(
              'assets/loading.json',
            ),
          );
        },
      ),
    );
  }
}
