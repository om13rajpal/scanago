import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scanago/templates/button.dart';
import 'package:scanago/templates/textfield.dart';
import 'package:scanago/utils/time_left.dart';
import 'package:scanago/utils/user_data.dart';

class QrCodeView extends StatefulWidget {
  final String type;
  const QrCodeView({
    super.key,
    required this.type,
  });

  @override
  State<QrCodeView> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCodeView> {
  late DateTime now;
  late Duration timeLeft;
  TextEditingController reason = TextEditingController();
  @override
  void initState() {
    now = DateTime.now();
    timeLeft = calculateTimeLeft(now);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
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
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                child: Center(
                  child: Text(
                    'Scanago',
                    style: TextStyle(
                        fontFamily: 'inter',
                        fontSize: screenwidth * 0.08,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff353535)),
                  ),
                )),
            Stack(
              alignment: Alignment.center,
              children: [
                LottieBuilder.asset('assets/lottie/run.json'),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Textfield(
                          controller: reason,
                          hintText: 'Reason',
                          screenWidth: screenwidth,
                          obscure: false,
                          prefixIcon: Icons.question_mark,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Button(
                            text: 'Get Code',
                            onPressed: () {
                              if (reason.text.isNotEmpty) {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Center(
                                      child: QrImageView(
                                        version: QrVersions.auto,
                                        size: screenwidth * 0.6,
                                        data: jsonEncode({
                                          'email': email,
                                          'name': name,
                                          'rollNo': rollNo,
                                          'phoneNo': phoneNo,
                                          'room': room,
                                          'branch': branch,
                                          'dateNtime': now.toIso8601String(),
                                          'reason': reason.text,
                                          'type': widget.type,
                                          'image': image
                                        }),
                                        gapless: false,
                                        padding: const EdgeInsets.all(10),
                                        eyeStyle: const QrEyeStyle(
                                          eyeShape: QrEyeShape.circle,
                                          color: Colors.black,
                                        ),
                                        dataModuleStyle:
                                            const QrDataModuleStyle(
                                          dataModuleShape:
                                              QrDataModuleShape.circle,
                                          color: Colors.black,
                                        ),
                                        errorStateBuilder: (cxt, err) {
                                          return const Center(
                                            child: Text(
                                              "Uh oh! Something went wrong...",
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                            radius: 12,
                            fontSize: 12)
                      ],
                    )),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.20,
              child: Stack(
                children: [
                  Positioned(
                      bottom: 25,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/images/fast_transparent.svg',
                        width: screenwidth * 0.25,
                      )),
                  Positioned(
                      bottom: 0,
                      right: 15,
                      child: SvgPicture.asset(
                        'assets/images/arrow.svg',
                        width: screenwidth * 0.5,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
