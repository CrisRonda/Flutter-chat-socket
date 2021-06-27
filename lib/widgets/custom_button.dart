import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function? onPressed;
  final String label;
  const CustomButton({Key? key, this.onPressed, required this.label})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final existOnPressed = this.onPressed != null;

    return ElevatedButton(
      
      onPressed: !existOnPressed ? null : () => this.onPressed!(),
      style: ElevatedButton.styleFrom(
        primary: Colors.cyan,
        onSurface: Colors.grey,
        shape: StadiumBorder(),
      ),
      child: Container(
          height: 30,
          width: double.infinity,
          child: Center(
              child: Text(
            this.label,
            style: TextStyle(
              fontSize: 17,
              color: existOnPressed ? Colors.white : Colors.grey.shade600,
            ),
          ))),
    );
  }
}
