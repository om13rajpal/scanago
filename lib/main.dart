import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:scanago/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  bool? dataSaved = prefs.getBool('dataSaved');
  runApp(Scanago(
    token: token,
    dataSaved: dataSaved,
  ));
}

class Scanago extends StatefulWidget {
  final dynamic token;
  final bool? dataSaved;
  const Scanago({super.key, this.token, required this.dataSaved});

  @override
  State<Scanago> createState() => _ScanagoState();
}

class _ScanagoState extends State<Scanago> {
  late bool loggedIn = false;
  late String? email;

  @override
  void initState() {
    checkToken();
    super.initState();
  }

  void checkToken() {
    if (widget.token != null) {
      if (!JwtDecoder.isExpired(widget.token)) {
        loggedIn = true;
        Map<String, dynamic> decodedToken = JwtDecoder.decode(widget.token);
        email = decodedToken['email'];
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
      home: (loggedIn)
          ? (email == 'admin@gmail.com')
              ? Splash(isLoggedIn: 'admin', token: widget.token)
              : Splash(
                  isLoggedIn: 'yes',
                  token: widget.token,
                  dataSaved: widget.dataSaved,
                )
          : const Splash(
              isLoggedIn: 'no',
            ),
    );
  }
}
