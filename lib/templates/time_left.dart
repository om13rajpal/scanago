import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TimeLeft extends StatelessWidget {
  final Duration timeLeft;
  final double screenWidth;
  const TimeLeft(
      {super.key, required this.timeLeft, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: screenWidth * 0.08,
          backgroundColor: const Color(0xff202020),
          child: LottieBuilder.asset(
            'assets/lottie/clock.json',
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.only(left: 15),
            height: screenWidth * 0.16,
            decoration: BoxDecoration(
                color: const Color(0xff202020),
                borderRadius: BorderRadius.circular(22)),
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Out time left',
                    style: TextStyle(
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w500,
                        fontSize: screenWidth * 0.03,
                        color: const Color(0xffb4b4b4)),
                  ),
                  (timeLeft == Duration.zero)
                      ? Text(
                          '00h : 00m',
                          style: TextStyle(
                              fontFamily: 'inter',
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xffe6e6e6)),
                        )
                      : Text(
                          '${timeLeft.inHours}h : ${timeLeft.inMinutes % 60}m',
                          style: const TextStyle(
                              fontFamily: 'inter',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffe6e6e6)),
                        )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
