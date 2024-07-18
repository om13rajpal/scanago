import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lottie/lottie.dart';
import 'package:scanago/dashboard.dart';
import 'package:scanago/details.dart';
import 'package:scanago/login.dart';
import 'package:scanago/scan.dart';
import 'package:scanago/utils/route_animation.dart';
import 'package:scanago/utils/user_data.dart';

class Splash extends StatefulWidget {
  final String isLoggedIn;
  final String? token;
  final bool? dataSaved;
  const Splash(
      {super.key, required this.isLoggedIn, this.token, this.dataSaved});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  _navigateToHome(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3), () {});
    if (!context.mounted) return;

    Widget nextPage;
    if (widget.isLoggedIn == 'admin') {
      nextPage = const Scan();
    } else if (widget.isLoggedIn == 'yes' && widget.dataSaved == true) {
      setUserInfo(JwtDecoder.decode(widget.token!), widget.token!);
      nextPage = Dashboard(token: widget.token);
    } else if (widget.isLoggedIn == 'yes' && widget.dataSaved != true) {
      nextPage = Details(
        token: widget.token!,
        saveType: 'save',
      );
    } else {
      nextPage = const Login();
    }

    Navigator.pushReplacement(context, createFadeRoute(nextPage));
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
        color: const Color(0xff070707),
        child: Center(
          child: Lottie.asset('assets/lottie/splash.json', renderCache: RenderCache.raster),
        ),
      ),
    );
  }
}
