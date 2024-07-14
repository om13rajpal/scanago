import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:scanago/templates/button.dart';
import 'package:http/http.dart' as http;
import 'package:scanago/utils/logout.dart';

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
    if (jsonRes['status']) {
      Fluttertoast.showToast(
        msg: "Sent the email",
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xfff3f3f3), Color(0xffd8d8d8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 50,
                      right: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              logout(context);
                            },
                            child: SvgPicture.asset(
                              width: MediaQuery.of(context).size.width * 0.05,
                              'assets/images/logout-light.svg',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 100,
                        child: Text(
                      'Scanago',
                      style: TextStyle(
                          fontFamily: 'inter',
                          fontWeight: FontWeight.w700,
                          fontSize: MediaQuery.of(context).size.width * 0.08,
                          color: const Color(0xff202020)),
                    )),
                    LottieBuilder.asset('assets/lottie/man.json'),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Your email is not verified Please verify your mail',
                          style: TextStyle(
                              fontFamily: 'inter',
                              color: const Color(0xff202020),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Button(
                            text: 'Resend Verification Mail',
                            onPressed: () {
                              sendVerificationMail();
                            },
                            radius: 12,
                            fontSize: MediaQuery.of(context).size.width * 0.032)
                      ],
                    ),
                    Positioned(
                        bottom: 0,
                        right: 15,
                        child: SvgPicture.asset(
                          'assets/images/arrow.svg',
                          width: MediaQuery.of(context).size.width * 0.6,
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
