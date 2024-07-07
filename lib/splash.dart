import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scanago/dashboard.dart';
import 'package:scanago/login.dart';
import 'package:scanago/scan.dart';

class Splash extends StatefulWidget {
  final String isLoggedIn;
  final String? token;
  const Splash({super.key, required this.isLoggedIn, this.token});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  _navigateToHome(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 6), () {});
    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        if (widget.isLoggedIn == 'admin') {
          return const Scan();
        } else if (widget.isLoggedIn == 'yes') {
          return Dashboard(token: widget.token);
        } else {
          return const Login();
        }
      }),
    );
  }

  @override
  void initState() {
    _navigateToHome(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color(0xff0e0e0e),
        child: Center(
          child: Lottie.network(
              'https://lottie.host/5f1136d0-d88a-4045-beda-b52efea0a1de/6nhB6joL9N.json'),
        ),
      ),
    );
  }
}
