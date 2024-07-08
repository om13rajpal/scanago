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
    await Future.delayed(const Duration(seconds: 2), () {});
    if (!context.mounted) return;

    Widget nextPage;
    if (widget.isLoggedIn == 'admin') {
      nextPage = const Scan();
    } else if (widget.isLoggedIn == 'yes') {
      nextPage = Dashboard(token: widget.token);
    } else {
      nextPage = const Login();
    }

    Navigator.pushReplacement(context, _createFadeRoute(nextPage));
  }

  Route _createFadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
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
        color: const Color(0xff000000),
        child: Center(
          child: Lottie.network(
              'https://lottie.host/10a006af-a634-4a67-bc34-71c83f4879d9/EZa8qiBtqF.json'),
        ),
      ),
    );
  }
}
