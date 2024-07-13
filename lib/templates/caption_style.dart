
import 'package:flutter/material.dart';

class CaptionStyle extends StatelessWidget {
  final Color textColor;
  final String text;
  final double fontSize;

  const CaptionStyle({super.key, required this.textColor, required this.text, required this.fontSize});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'inter',
          fontSize: fontSize,
          color: textColor,
          fontWeight: FontWeight.w500),
    );
  }
}
