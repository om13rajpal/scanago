import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:scanago/templates/button.dart';
import 'package:scanago/signup.dart';
import 'package:scanago/templates/caption_style.dart';
import 'package:scanago/templates/textfield.dart';
import 'package:scanago/utils/login_signup.dart';
import 'package:scanago/utils/route_animation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late SharedPreferences prefs;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    initSharedPrefs();
    super.initState();
  }

  void initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(left: 25),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xfff3f3f3), Color(0xffd8d8d8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.20,
                    child: Center(
                      child: Text(
                        'Scanago',
                        style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: screenWidth * 0.08,
                            color: const Color(0xff262626),
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        child: Transform.translate(
                          offset: Offset(screenWidth * 0.25, 0),
                          child: Lottie.asset(
                            'assets/lottie/man.json',
                            renderCache: RenderCache.raster
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CaptionStyle(
                                  textColor: const Color(0xff707070),
                                  text: 'Unlock\ncampus with\na scan :D',
                                  fontSize: screenWidth * 0.037),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Textfield(
                                    controller: email,
                                    hintText: 'Email',
                                    screenWidth: screenWidth,
                                    obscure: false,
                                    prefixIcon: Icons.email,
                                  ),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  Textfield(
                                    controller: password,
                                    hintText: 'Password',
                                    screenWidth: screenWidth,
                                    obscure: true,
                                    prefixIcon: Icons.lock,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 32,
                                    width: screenWidth * 0.24,
                                    child: Button(
                                        text: 'Login',
                                        onPressed: () {
                                          loginOrSignupUser(context, prefs,
                                              email, password, 'login');
                                        },
                                        radius: 14,
                                        fontSize: screenWidth * 0.034),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'New to this app?',
                                        style: TextStyle(
                                            fontFamily: 'inter',
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff747474),
                                            fontSize: screenWidth * 0.032),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              createFadeRoute(const SignUp()));
                                        },
                                        child: Text(
                                          'Sign up',
                                          style: TextStyle(
                                              fontFamily: 'inter',
                                              fontWeight: FontWeight.w700,
                                              fontSize: screenWidth * 0.037,
                                              color: const Color(0xff262626)),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Stack(
                    children: [
                      Positioned(
                          bottom: 25,
                          left: 0,
                          child: SvgPicture.asset(
                            'assets/images/fast_transparent.svg',
                            width: screenWidth * 0.25,
                          )),
                      Positioned(
                          bottom: 0,
                          right: 15,
                          child: SvgPicture.asset(
                            'assets/images/arrow.svg',
                            width: screenWidth * 0.5,
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
