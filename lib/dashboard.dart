import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:scanago/account.dart';
import 'package:scanago/templates/caption_style.dart';
import 'package:scanago/templates/grid.dart';
import 'package:scanago/templates/time_left.dart';
import 'package:scanago/templates/top_dashboard.dart';
import 'package:scanago/utils/route_animation.dart';
import 'package:scanago/utils/time_left.dart';
import 'package:scanago/utils/check_verification.dart';
import 'package:scanago/utils/user_data.dart';

class Dashboard extends StatefulWidget {
  final dynamic token;
  const Dashboard({super.key, this.token});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late DateTime now;
  late Duration timeLeft;

  @override
  void initState() {
    now = DateTime.now();
    timeLeft = calculateTimeLeft(now);

    checkVerification(email!, context);
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
                TopDashboard(name: name!, screenWidth: screenWidth),
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
                        textColor: const Color(0xff8c8c8c),
                        text: 'Here are some things you can do',
                        fontSize: screenWidth * 0.03),
                    const SizedBox(
                      height: 20,
                    ),
                    Grid(screenWidth: screenWidth),
                    const SizedBox(
                      height: 32,
                    ),
                    TimeLeft(
                      timeLeft: timeLeft,
                      screenWidth: screenWidth,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CaptionStyle(
                        textColor: const Color(0xff8c8c8c),
                        text: 'Unlock campus with a scan :D',
                        fontSize: screenWidth * 0.03),
                    Transform.translate(
                      offset: const Offset(0, -20),
                      child: SizedBox(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            LottieBuilder.asset(
                              'assets/lottie/dino.json',
                              width: MediaQuery.of(context).size.width * 0.4,
                              fit: BoxFit.cover,
                            ),
                            CircleAvatar(
                                radius: 20,
                                backgroundColor: const Color(0xff3b3b3b),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        createFadeRoute(Account(
                                            email: email!,
                                            name: name!,
                                            branch: branch!,
                                            rollNo: rollNo!, token: widget.token,)));
                                  },
                                  child: SvgPicture.asset(
                                    'assets/images/account.svg',
                                    width: 20,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
