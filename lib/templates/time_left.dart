import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TimeLeft extends StatelessWidget {
  final Duration timeLeft;
  const TimeLeft({super.key, required this.timeLeft});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 31,
          backgroundColor: const Color(0xff202020),
          child: LottieBuilder.asset(
            'assets/lottie/clock.json',
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.only(left: 15),
            height: 62,
            decoration: BoxDecoration(
                color: const Color(0xff202020),
                borderRadius: BorderRadius.circular(22)),
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Out time left',
                    style: TextStyle(
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                        color: Color(0xffb4b4b4)),
                  ),
                  (timeLeft == Duration.zero)
                      ? const Text(
                          '00h : 00m',
                          style: TextStyle(
                              fontFamily: 'inter',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffe6e6e6)),
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
