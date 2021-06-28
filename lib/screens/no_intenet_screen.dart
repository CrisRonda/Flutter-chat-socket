import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoInternetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column( 
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/offline.json',
            options: LottieOptions(enableMergePaths: true),
            repeat: false,
          ),
          SizedBox(
            height: 16,
          ),
          Text("No internet", style: TextStyle(fontSize: 32))
        ],
      ),
    );
  }
}
