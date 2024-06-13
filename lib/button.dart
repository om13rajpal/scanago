import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double radius;
  final double fontSize;

  const Button(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.radius,
      required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          textStyle: TextStyle(
              fontFamily: 'monkey', fontSize: fontSize, color: Colors.white),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius))),
      child: Text(text),
    );
  }
}
