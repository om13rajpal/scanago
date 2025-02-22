import 'package:flutter/material.dart';
import 'package:scanago/screens/dashboard.dart';

void main() {
  runApp(Scanago());
}

class Scanago extends StatelessWidget {
  const Scanago({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: const Dashboard(),
    );
  }
}
