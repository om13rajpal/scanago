import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:scanago/account.dart';
import 'package:scanago/login.dart';
import 'package:scanago/qrcode.dart';
import 'package:scanago/verifymail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  final dynamic token;
  const Dashboard({super.key, @required this.token});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late String email;
  late String name;
  late String rollNo;
  late String phoneNo;
  late String room;
  late String branch;
  late String? image;

  @override
  void initState() {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(widget.token);
    email = decodedToken['email'];
    name = decodedToken['name'];
    rollNo = decodedToken['rollNo'];
    phoneNo = decodedToken['phoneNo'];
    room = decodedToken['room'];
    branch = decodedToken['branch'];
    image = decodedToken['image'];

    checkVerification(email, context);

    super.initState();
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('dataSaved');

    if (!context.mounted) return;

    Navigator.pushReplacement(context, _createFadeRoute(const Login()));
  }

  void checkVerification(String email, BuildContext context) async {
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
            context, _createFadeRoute(VerifyMail(email: email)));
      }
    }
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color(0xFFF8F4EA),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
                child: Stack(
                  children: [
                    Positioned(
                      top: 30,
                      right: 20,
                      child: InkWell(
                          onTap: () {
                            logout(context);
                          },
                          child: const Icon(Icons.arrow_forward_ios)),
                    ),
                    const Center(
                      child: Text(
                        'Scanago',
                        style: TextStyle(
                          fontFamily: 'monkey',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.60,
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      child: Image.asset('assets/images/man.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 25),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Image.asset('assets/images/side_design.png'),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 50, left: 30, bottom: 80),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              color: const Color.fromARGB(215, 0, 0, 0),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  _createFadeRoute(QrCodeView(
                                    email: email,
                                    name: name,
                                    rollNo: rollNo,
                                    phoneNo: phoneNo,
                                    room: room,
                                    branch: branch,
                                    type: 'local',
                                    image: image,
                                  )),
                                );
                              },
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.local_activity,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                  Text(
                                    'Local Entry',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'monkey',
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              color: const Color.fromARGB(215, 0, 0, 0),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  _createFadeRoute(QrCodeView(
                                    email: email,
                                    name: name,
                                    rollNo: rollNo,
                                    phoneNo: phoneNo,
                                    room: room,
                                    branch: branch,
                                    type: 'home',
                                    image: image,
                                  )),
                                );
                              },
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Home Entry',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'monkey',
                                      fontSize: 15,
                                    ),
                                  ),
                                  Icon(
                                    Icons.home_rounded,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              color: const Color.fromARGB(215, 0, 0, 0),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  _createFadeRoute(Account(
                                    email: email,
                                    name: name,
                                    branch: branch,
                                    rollNo: rollNo,
                                  )),
                                );
                              },
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  Text(
                                    'Account',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'monkey',
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
                child: Stack(
                  children: [
                    Positioned(
                        bottom: 35,
                        left: 16,
                        child: Image.asset(
                          'assets/images/bottom.png',
                          width: 120,
                        )),
                    Positioned(
                        bottom: 0,
                        right: 15,
                        child: Image.asset(
                          'assets/images/arrow.png',
                          width: 220,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
