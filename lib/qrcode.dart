import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scanago/templates/button.dart';

class QrCodeView extends StatefulWidget {
  final String email;
  final String name;
  final String rollNo;
  final String phoneNo;
  final String room;
  final String branch;
  final String type;
  final String? image;
  const QrCodeView(
      {super.key,
      required this.email,
      required this.name,
      required this.rollNo,
      required this.phoneNo,
      required this.room,
      required this.branch,
      required this.type,
      required this.image});

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
    calculateTimeLeft();
    super.initState();
  }

  void calculateTimeLeft() {
    if (now.isAfter(DateTime(now.year, now.month, now.day, 22, 0, 1)) ||
        now.isBefore(DateTime(now.year, now.month, now.day, 5, 30, 0))) {
      timeLeft = Duration.zero;
    } else {
      final DateTime totaltime =
          DateTime(DateTime.now().year, now.month, now.day, 22, 0, 0);
      timeLeft = totaltime.difference(now);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color(0xFFF8F4EA),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.20,
              child: const Center(
                child: Text(
                  'Scanago',
                  style: TextStyle(
                      fontFamily: 'monkey',
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.60,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      (timeLeft == Duration.zero)
                          ? const Text(
                              'In/Out time is over for today',
                              style: TextStyle(
                                  fontFamily: 'monkey',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(
                              '${timeLeft.inHours}h : ${timeLeft.inMinutes % 60}m Left',
                              style: const TextStyle(
                                  fontFamily: 'monkey',
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: reason,
                        decoration: InputDecoration(
                          labelText: 'Reason',
                          filled: true,
                          fillColor: const Color.fromARGB(230, 0, 0, 0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
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
                                      size: 250,
                                      data: jsonEncode({
                                        'email': widget.email,
                                        'name': widget.name,
                                        'rollNo': widget.rollNo,
                                        'phoneNo': widget.phoneNo,
                                        'room': widget.room,
                                        'branch': widget.branch,
                                        'dateNtime': now.toIso8601String(),
                                        'reason': reason.text,
                                        'type': widget.type,
                                        'image': widget.image
                                      }),
                                      gapless: false,
                                      padding: const EdgeInsets.all(10),
                                      eyeStyle: const QrEyeStyle(
                                        eyeShape: QrEyeShape.circle,
                                        color: Colors.black,
                                      ),
                                      dataModuleStyle: const QrDataModuleStyle(
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
                  ),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.20,
              child: Stack(
                children: [
                  Positioned(
                      bottom: 35,
                      left: 16,
                      child: Image.asset(
                        'assets/images/bottom.png',
                        width: 120,
                      )),
                  Positioned(
                      bottom: 0,
                      right: 15,
                      child: Image.asset(
                        'assets/images/arrow.png',
                        width: 220,
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
