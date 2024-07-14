import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scanago/templates/caption_style.dart';
import 'package:scanago/templates/grid_account.dart';
import 'package:scanago/templates/top_dashboard_account.dart';
import 'package:scanago/utils/time_left.dart';
import 'package:scanago/utils/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  final String email;
  final String name;
  final String branch;
  final String rollNo;
  final dynamic token;
  const Account(
      {super.key,
      required this.email,
      required this.name,
      required this.branch,
      required this.rollNo,
      required this.token});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late SharedPreferences prefs;
  late Duration timeLeft;
  late DateTime now;

  @override
  void initState() {
    now = DateTime.now();
    timeLeft = calculateTimeLeft(now);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                      ),
                      TopDashboardAccount(screenWidth: screenWidth),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      const Divider(
                        endIndent: 15,
                        indent: 15,
                        color: Color(0xffcfcfcf),
                        thickness: 1,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CaptionStyle(
                              textColor: const Color(0xff5C5C5C),
                              text: 'Hi $name,',
                              fontSize: screenWidth * 0.045),
                          CaptionStyle(
                              textColor: const Color(0xff8C8C8C),
                              text: 'Here are your account details',
                              fontSize: screenWidth * 0.037),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CaptionStyle(
                                      textColor: const Color(0xff8C8C8C),
                                      text: 'Room number: ',
                                      fontSize: screenWidth * 0.035),
                                  Text(
                                    '$room',
                                    style: TextStyle(
                                        fontFamily: 'inter',
                                        fontSize: screenWidth * 0.037,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xff555555)),
                                  )
                                ],
                              ),
                              CaptionStyle(
                                  textColor: const Color(0xff727272),
                                  text: '$rollNo',
                                  fontSize: screenWidth * 0.035),
                            ],
                          ),
                          Text(
                            '$branch',
                            style: TextStyle(
                                fontFamily: 'inter',
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff353535),
                                fontSize: screenWidth * 0.062),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Grid(
                        screenWidth: screenWidth,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      CaptionStyle(
                          textColor: const Color(0xff8c8c8c),
                          text: 'Unlock\ncampus with\na scan :D',
                          fontSize: screenWidth * 0.035),
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
        ),
      ),
    );
  }
}
