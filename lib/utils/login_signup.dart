import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:scanago/dashboard.dart';
import 'package:scanago/details.dart';
import 'package:scanago/scan.dart';
import 'package:scanago/utils/route_animation.dart';
import 'package:scanago/utils/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart" as http;

Future<void> loginOrSignupUser(
    BuildContext context,
    SharedPreferences prefs,
    TextEditingController email,
    TextEditingController password,
    String route) async {
  if (email.text.isNotEmpty && password.text.isNotEmpty) {
    var body = {
      "email": email.text.trim(),
      "password": password.text.trim(),
    };

    var response = await http.post(
        Uri.parse('https://scanago.onrender.com/$route'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body));

    var jsonRes = jsonDecode(response.body);
    if (jsonRes['status']) {
      var myToken = jsonRes['token'];
      await prefs.setString('token', myToken);
      await prefs.setBool('dataSaved', true);
      setUserInfo(JwtDecoder.decode(myToken), myToken);

      if (!context.mounted) return;
      bool admin = false;
      if (email.text == 'admin@gmail.com') {
        admin = true;
      }

      Navigator.pushReplacement(
        context,
        createFadeRoute(admin
            ? const Scan()
            : (route == 'login')
                ? Dashboard(token: myToken)
                : Details(token: myToken, saveType: 'save')),
      );
    }
  }
}
