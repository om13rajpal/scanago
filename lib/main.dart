import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:scanago/dashboard.dart';
import 'package:scanago/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  runApp(Scanago(
    token: token,
  ));
}

class Scanago extends StatefulWidget {
  final dynamic token;
  const Scanago({super.key, this.token});

  @override
  State<Scanago> createState() => _ScanagoState();
}

class _ScanagoState extends State<Scanago> {
  late bool loggedIn = false;

  @override
  void initState() {
    checkToken();
    super.initState();
  }

  void checkToken() {
    if (widget.token != null) {
      if (!JwtDecoder.isExpired(widget.token)) {
        loggedIn = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: const Color(0xFFF8F4EA),
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: (loggedIn) ? Dashboard(token: widget.token) : const Login(),
    );
  }
}
