import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeView extends StatefulWidget {
  final String email;
  final String name;
  final String rollNo;
  final String phoneNo;
  final String room;
  final String branch;
  const QrCodeView(
      {super.key,
      required this.email,
      required this.name,
      required this.rollNo,
      required this.phoneNo,
      required this.room,
      required this.branch});

  @override
  State<QrCodeView> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCodeView> {
  late DateTime now;
  @override
  void initState() {
    now = DateTime.now();
    print(now);
    super.initState();
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
              child: Center(
                child: QrImageView(
                    version: QrVersions.auto,
                    size: 200,
                    data: jsonEncode({
                      'email': widget.email,
                      'name': widget.name,
                      'rollNo': widget.rollNo,
                      'phoneNo': widget.phoneNo,
                      'room': widget.room,
                      'branch': widget.branch,
                      'dateNtime': now.toIso8601String()
                    })),
              ),
            )
          ],
        ),
      ),
    );
  }
}
