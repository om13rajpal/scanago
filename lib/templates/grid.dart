import 'package:flutter/material.dart';
import 'package:scanago/qrcode.dart';
import 'package:scanago/templates/grid_content.dart';

class Grid extends StatelessWidget {
  final double screenWidth;
  const Grid({super.key, required this.screenWidth});

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
          subtitle: 'Generate QR code\nto scan and go',
          svgPath: 'assets/images/home.svg',
          page: const QrCodeView(
            type: 'home',
          ),
          screenWidth: screenWidth,
        ),
        GridContent(
          bgColor: const Color(0xffBDE9C2),
          title: 'Local entry',
          subtitle: 'Generate QR code\nto scan and go',
          svgPath: 'assets/images/local.svg',
          page: const QrCodeView(
            type: 'local',
          ),
          screenWidth: screenWidth,
        ),
        GridContent(
          bgColor: const Color(0xffE6D6AE),
          title: 'Night entry',
          subtitle: 'Mark your todays\nnight entry',
          svgPath: 'assets/images/moon.svg',
          page: const QrCodeView(
            type: 'home',
          ),
          screenWidth: screenWidth,
        ),
        GridContent(
          bgColor: const Color(0xffDADADA),
          title: 'Food rating',
          subtitle: 'Rate your todays\nmess food',
          svgPath: 'assets/images/food.svg',
          page: const QrCodeView(
            type: 'local',
          ),
          screenWidth: screenWidth,
        ),
      ],
    );
  }
}
