import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scanago/details.dart';
import 'package:scanago/entryList.dart';
import 'package:scanago/templates/grid_content.dart';

class Grid extends StatelessWidget {
  final double screenWidth;
  final dynamic token;
  const Grid({super.key, required this.screenWidth, this.token});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      childAspectRatio: 8 / 6.2,
      children: [
        GridContent(
          bgColor: const Color(0xffE5C7F0),
          title: 'Home entry',
          subtitle: 'View all your home\nentry',
          svgPath: 'assets/images/home.svg',
          page: const EntryList(listType: 'home'),
          screenWidth: screenWidth,
        ),
        GridContent(
          bgColor: const Color(0xffBDE9C2),
          title: 'Local entry',
          subtitle: 'View all your local\nentry',
          svgPath: 'assets/images/local.svg',
          page: const EntryList(listType: 'local'),
          screenWidth: screenWidth,
        ),
        GridContent(
          bgColor: const Color(0xffE6D6AE),
          title: 'Update details',
          subtitle: 'Update your profile\ndetails',
          svgPath: 'assets/images/user.svg',
          page: Details(token: token, saveType: 'update'),
          screenWidth: screenWidth,
        ),
        Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xffD4D4D4),
        ),
        child: LottieBuilder.asset('assets/lottie/dino.json'),
        )
      ],
    );
  }
}
