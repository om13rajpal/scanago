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
          backgroundColor: const Color(0xff202020),
          foregroundColor: const Color.fromARGB(255, 197, 197, 197),
          textStyle: TextStyle(
              fontFamily: 'inter',
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 197, 197, 197)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius))),
      child: Text(text),
    );
  }
}
