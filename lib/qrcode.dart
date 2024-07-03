import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scanago/button.dart';

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
  TextEditingController reason = TextEditingController();
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
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                      SizedBox(
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
                                        size: 200,
                                        data: jsonEncode({
                                          'email': widget.email,
                                          'name': widget.name,
                                          'rollNo': widget.rollNo,
                                          'phoneNo': widget.phoneNo,
                                          'room': widget.room,
                                          'branch': widget.branch,
                                          'dateNtime': now.toIso8601String(),
                                          'reason': reason.text
                                        })),
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
          ],
        ),
      ),
    );
  }
}
