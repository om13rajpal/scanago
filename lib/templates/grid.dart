import 'package:flutter/material.dart';
import 'package:scanago/qrcode.dart';
import 'package:scanago/templates/grid_content.dart';
import 'package:scanago/utils/user_data.dart';

class Grid extends StatelessWidget {
  const Grid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      childAspectRatio: 8 / 6.7,
      children: [
        GridContent(
          bgColor: const Color(0xffE5C7F0),
          title: 'Home entry',
          subtitle: 'Generate QR code\nto scan and go',
          svgPath: 'assets/images/home.svg',
          page: QrCodeView(
              email: email!,
              name: name!,
              rollNo: rollNo!,
              phoneNo: phoneNo!,
              room: room!,
              branch: branch!,
              type: 'home',
              image: image),
        ),
        GridContent(
          bgColor: const Color(0xffBDE9C2),
          title: 'Local entry',
          subtitle: 'Generate QR code\nto scan and go',
          svgPath: 'assets/images/local.svg',
          page: QrCodeView(
              email: email!,
              name: name!,
              rollNo: rollNo!,
              phoneNo: phoneNo!,
              room: room!,
              branch: branch!,
              type: 'local',
              image: image),
        ),
        GridContent(
          bgColor: const Color(0xffE6D6AE),
          title: 'Night entry',
          subtitle: 'Mark your todays\nnight entry',
          svgPath: 'assets/images/moon.svg',
          page: QrCodeView(
              email: email!,
              name: name!,
              rollNo: rollNo!,
              phoneNo: phoneNo!,
              room: room!,
              branch: branch!,
              type: 'home',
              image: image),
        ),
        GridContent(
          bgColor: const Color(0xffDADADA),
          title: 'Food rating',
          subtitle: 'Rate your todays\nmess food',
          svgPath: 'assets/images/food.svg',
          page: QrCodeView(
              email: email!,
              name: name!,
              rollNo: rollNo!,
              phoneNo: phoneNo!,
              room: room!,
              branch: branch!,
              type: 'local',
              image: image),
        ),
      ],
    );
  }
}
