import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  const CustomButton({Key? key, required this.onPressed, required this.label})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: ()=> this.onPressed(),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.amber),
        backgroundColor: MaterialStateProperty.all(Colors.cyan),
        shape: MaterialStateProperty.all(StadiumBorder()),
        elevation: MaterialStateProperty.all(3),
      ),
      child: Container(
          height: 30,
          width: double.infinity,
          child: Center(
              child: Text(
            this.label,
            style: TextStyle(fontSize: 17, color: Colors.white),
          ))),
    );
  }
}
