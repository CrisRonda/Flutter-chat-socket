import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Logo extends StatelessWidget {
  final String title;
  const Logo({Key? key, this.title = "Chat App"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          width: 380,
          child: Column(
            children: [
              Lottie.asset(
                'assets/chat.json',
              ),
              SizedBox(
                height: 16,
              ),
              Text(this.title, style: TextStyle(fontSize: 32))
            ],
          ),
        ),
      ),
    );
  }
}
