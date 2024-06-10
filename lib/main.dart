import 'package:flutter/material.dart';
import 'package:scanago/login.dart';

void main() {
  runApp(const Scanago());
}

class Scanago extends StatelessWidget {
  const Scanago({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFF8F4EA),
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: const Login(),
    );
  }
}
