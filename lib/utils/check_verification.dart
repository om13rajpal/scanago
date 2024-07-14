import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scanago/utils/route_animation.dart';
import 'package:scanago/utils/user_data.dart';
import 'package:scanago/verify_mail.dart';
import 'package:http/http.dart' as http;

void checkVerification(String token, BuildContext context) async {
    var body = {"email": email};
    var response = await http.post(
        Uri.parse('https://scanago.onrender.com/checkVerification'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body));

    var jsonRes = await jsonDecode(response.body);
    if (jsonRes['status']) {
      bool isVerified = jsonRes['isVerified'];
      if (!isVerified) {
        if (!context.mounted) return;
        Navigator.pushReplacement(
            context, createFadeRoute(VerifyMail(token: token)));
      }
    }
  }