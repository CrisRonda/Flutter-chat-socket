import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isPassword;

  const CustomInput(
      {Key? key,
      required this.icon,
      required this.placeholder,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.isPassword = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.only(top: 4, left: 4, bottom: 4, right: 16),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  offset: Offset(0, 5),
                  blurRadius: 6)
            ],
            borderRadius: BorderRadius.circular(16)),
        child: TextField(
          controller: this.controller,
          autocorrect: false,
          keyboardType: this.keyboardType,
          textAlignVertical: TextAlignVertical.center,
          obscureText: this.isPassword,
          decoration: InputDecoration(
              prefixIcon: Icon(this.icon),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: this.placeholder),
        ));
  }
}
