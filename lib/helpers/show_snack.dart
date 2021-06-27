import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

showSnackBar(
    {required BuildContext context,
    required String title,
    Color color = Colors.green}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      title,
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: color,
  ));
}
