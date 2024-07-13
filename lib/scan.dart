import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scanago/templates/button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:scanago/entrylist.dart';
import 'package:scanago/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  void _showResultDialog(String result) {
    var data = jsonDecode(result);
    DateTime dateTime = DateTime.parse(data['dateNtime']);
    String url = data['image'];
    int hour = dateTime.hour;
    String period = hour >= 12 ? 'PM' : 'AM';
    if (hour == 0) {
      hour = 12;
    } else if (hour > 12) {
      hour -= 12;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(data['name']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                url,
                width: 300,
              ),
              const SizedBox(
                height: 3,
              ),
              Text('Roll No: ${data['rollNo']}'),
              Text('Branch: ${data['branch']}'),
              Text('Room: ${data['room']}'),
              Text('Phone No: ${data['phoneNo']}'),
              Text('Reason: ${data['reason']}'),
              Text(
                  'Entry Time: ${hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} $period'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                var body = {
                  "name": data['name'],
                  "rollNo": data['rollNo'],
                  "branch": data['branch'],
                  "room": data['room'],
                  "email": data['email'],
                  "phoneNo": data['phoneNo'],
                  "dateNtime": data['dateNtime'],
                  "reason": data['reason'],
                };

                String type = data['type'];
                String entryType;
                if (type == 'home') {
                  entryType = 'homeEntry';
                } else {
                  entryType = 'localEntry';
                }

                var response = await http.post(
                    Uri.parse('https://scanago.onrender.com/$entryType'),
                    headers: {"Content-Type": "application/json"},
                    body: jsonEncode(body));

                var jsonRes = jsonDecode(response.body);
                if (jsonRes['status']) {
                  Fluttertoast.showToast(
                    msg: "Entry Saved",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  if (!context.mounted) return;
                  Navigator.pop(context);
                } else {
                  Fluttertoast.showToast(
                    msg: "could not save data",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 30,
              right: 30,
              child: InkWell(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  if (!context.mounted) return;
                  prefs.remove('token');
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ));
                },
                child: const Icon(Icons.arrow_forward_ios),
              )),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Button(
                        text: 'Scan QR code',
                        onPressed: () async {
                          var res = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SimpleBarcodeScannerPage(),
                            ),
                          );
                          if (res is String) {
                            _showResultDialog(res);
                          }
                        },
                        radius: 12,
                        fontSize: 12),
                  ),
                  Button(
                      text: 'Home Entries',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const EntryList(listType: 'allHomeEntry'),
                            ));
                      },
                      radius: 12,
                      fontSize: 12),
                  Button(
                      text: 'Local Entries',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const EntryList(listType: 'allLocalEntry'),
                            ));
                      },
                      radius: 12,
                      fontSize: 12)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
