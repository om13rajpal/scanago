import 'package:flutter/material.dart';
import 'package:scanago/login.dart';
import 'package:scanago/utils/route_animation.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
  await prefs.remove('dataSaved');

  if (!context.mounted) return;

  Navigator.pushReplacement(context, createFadeRoute(const Login()));
}
