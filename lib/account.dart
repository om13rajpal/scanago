import 'package:flutter/material.dart';
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
  final String token;
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
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                TopDashboardAccount(screenWidth: screenWidth),
                const SizedBox(
                  height: 12,
                ),
                const Divider(
                  endIndent: 15,
                  indent: 15,
                  color: Color(0xffcfcfcf),
                  thickness: 1,
                ),
                const SizedBox(
                  height: 12,
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
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: screenWidth,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: const Color(0xff222222),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$branch',
                                style: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: screenWidth * 0.08,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff434343)),
                              ),
                              CaptionStyle(
                                  textColor: const Color(0xff656565),
                                  text: 'Unlock campus with a scan :D',
                                  fontSize: screenWidth * 0.032)
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CaptionStyle(
                                  textColor: const Color(0xffBABABA),
                                  text: '# $rollNo',
                                  fontSize: screenWidth * 0.045),
                              CaptionStyle(
                                  textColor: const Color(0xff8c8c8c),
                                  text: 'Room number: $room',
                                  fontSize: screenWidth * 0.033),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Grid(
                      screenWidth: screenWidth,
                      token: widget.token,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
