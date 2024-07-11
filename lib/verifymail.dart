import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scanago/button.dart';
import 'package:http/http.dart' as http;

class VerifyMail extends StatefulWidget {
  final String email;
  const VerifyMail({super.key, required this.email});

  @override
  State<VerifyMail> createState() => _VerifyMailState();
}

class _VerifyMailState extends State<VerifyMail> {
  Future<void> sendVerificationMail() async {
    var body = {"email": widget.email};

    var response = await http.post(
        Uri.parse('https://scanago.onrender.com/sendVerificationMail'),
        headers: {"Content-type": "application/json"},
        body: jsonEncode(body));

    var jsonRes = jsonDecode(response.body);
    if(jsonRes['status']){
      Fluttertoast.showToast(
          msg: "Entry Saved",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(20),
        color: const Color(0xFFF8F4EA),
        child: Center(
          child: Column(
            children: [
              const Text('your email is not verified Please verify your mail'),
              Button(
                  text: 'Resend Verification Mail',
                  onPressed: () {},
                  radius: 12,
                  fontSize: 12)
            ],
          ),
        ),
      ),
    );
  }
}
