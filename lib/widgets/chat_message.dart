import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String message;
  final String uuid;
  final AnimationController animationController;

  const ChatMessage(
      {Key? key,
      required this.message,
      required this.uuid,
      required this.animationController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.easeInExpo),
          child: FadeTransition(
        opacity: animationController,
        child: Container(
          child: this.uuid == '1234' ? _myMessage() : _notMyMessage(),
        ),
      ),
    );
  }

  Widget _myMessage() {
    return Container(
      child: Align(
          alignment: Alignment.centerRight,
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              margin: EdgeInsets.only(bottom: 8, left: 56, right: 8),
              decoration: BoxDecoration(
                  color: Colors.cyan.shade600,
                  borderRadius: BorderRadius.circular(12)),
              child: Text(
                this.message,
                style: TextStyle(color: Colors.white),
              ))),
    );
  }

  Widget _notMyMessage() {
    return Container(
      child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              margin: EdgeInsets.only(bottom: 8, right: 56, left: 8),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12)),
              child: Text(
                this.message,
              ))),
    );
  }
}
