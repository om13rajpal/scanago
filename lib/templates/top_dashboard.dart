import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scanago/utils/logout.dart';

class TopDashboard extends StatelessWidget {
  final String name;
  const TopDashboard({super.key, required this.name});

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
              style: const TextStyle(
                  fontFamily: 'inter',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff8c8c8c)),
            ),
            InkWell(
              onTap: () {
                logout(context);
              },
              child: SvgPicture.asset(
                'assets/images/logout-light.svg',
                width: 17,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'Scanago',
          style: TextStyle(
              fontFamily: 'inter',
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(255, 18, 18, 18)),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.translate(
              offset: Offset(0, -1),
              child: SvgPicture.asset(
                'assets/images/tiet.svg',
                width: 26,
                height: 26,
              ),
            ),
            const Text(
              'TIET',
              style: TextStyle(
                  fontFamily: 'inter',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff8c8c8c)),
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
