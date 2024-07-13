import 'package:flutter/material.dart';
import 'package:scanago/templates/caption_style.dart';

class Textfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final double screenWidth;
  final bool obscure;
  const Textfield(
      {super.key,
      required this.controller,
      required this.hintText,
      this.prefixIcon,
      required this.screenWidth,
      required this.obscure});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform.translate(
          offset: const Offset(3, 0),
          child: CaptionStyle(
              textColor: const Color(0xff747474),
              text: hintText,
              fontSize: screenWidth * 0.034),
        ),
        const SizedBox(
          height: 2,
        ),
        TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(
              prefixIcon,
              color: Colors.white54,
              size: 16,
            ),
            filled: true,
            fillColor: const Color.fromARGB(217, 0, 0, 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            hintStyle: TextStyle(
                color: Colors.white60,
                fontFamily: 'inter',
                fontWeight: FontWeight.w500,
                fontSize: screenWidth * 0.036),
          ),
          style: TextStyle(
              color: const Color.fromARGB(209, 255, 255, 255),
              fontFamily: 'inter',
              fontWeight: FontWeight.w500,
              fontSize: screenWidth * 0.039),
        ),
      ],
    );
  }
}
