import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scanago/utils/logout.dart';

class TopDashboard extends StatelessWidget {
  final String name;
  final double screenWidth;
  const TopDashboard(
      {super.key, required this.name, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hi $name,',
              style: TextStyle(
                  fontFamily: 'inter',
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff8c8c8c)),
            ),
            InkWell(
              onTap: () {
                logout(context);
              },
              child: SvgPicture.asset(
                'assets/images/logout-light.svg',
                width: screenWidth * 0.05,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Scanago',
          style: TextStyle(
              fontFamily: 'inter',
              fontSize: screenWidth * 0.067,
              fontWeight: FontWeight.w700,
              color: const Color.fromARGB(255, 18, 18, 18)),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: SvgPicture.asset(
                'assets/images/tiet.svg',
                width: screenWidth * 0.037,
                height: screenWidth * 0.037,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              'TIET',
              style: TextStyle(
                  fontFamily: 'inter',
                  fontSize: screenWidth * 0.033,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff8c8c8c)),
            ),
            const SizedBox(
              width: 7,
            ),
            SvgPicture.asset(
              'assets/images/down.svg',
              width: 17,
            )
          ],
        )
      ],
    );
  }
}
