import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scanago/templates/caption_style.dart';
import 'package:scanago/utils/user_data.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EntryList extends StatefulWidget {
  final String listType;
  const EntryList({super.key, required this.listType});

  @override
  State<EntryList> createState() => _EntryListState();
}

class _EntryListState extends State<EntryList> {
  List<Map<String, dynamic>> entryList = [];

  @override
  void initState() {
    super.initState();
    getList();
  }

  void getList() async {
    var body = {"email": email};
    var response = await http.post(
      Uri.parse('https://scanago.onrender.com/${widget.listType}'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      var jsonRes = jsonDecode(response.body);
      if (jsonRes['status']) {
        var listData = jsonRes[widget.listType];
        if (listData is List) {
          setState(() {
            entryList = listData.map((item) {
              return Map<String, dynamic>.from(item);
            }).toList();
          });
        }
      }
    }
  }

  String selectedValue = 'old';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: screenWidth,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xfff3f3f3), Color(0xffd8d8d8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Text(
                    'Scanago',
                    style: TextStyle(
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w700,
                        fontSize: screenWidth * 0.06,
                        color: const Color(0xff353535)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            value: 'old',
                            groupValue: selectedValue,
                            onChanged: (String? value) {
                              setState(() {
                                selectedValue = value!;
                              });
                            },
                          ),
                          CaptionStyle(
                              textColor: const Color(0xff454545),
                              text: 'Old',
                              fontSize: screenWidth * 0.04),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'new',
                            groupValue: selectedValue,
                            onChanged: (String? value) {
                              setState(() {
                                selectedValue = value!;
                              });
                            },
                          ),
                          CaptionStyle(
                              textColor: const Color(0xff454545),
                              text: 'New',
                              fontSize: screenWidth * 0.04),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.8,
              child: entryList.isEmpty
                  ? Center(
                      child: CaptionStyle(
                          textColor: const Color(0xff555555),
                          text: 'No entry found :D',
                          fontSize: screenWidth * 0.035),
                    )
                  : ListView.builder(
                      reverse: false,
                      itemCount: entryList.length,
                      itemBuilder: (context, index) {
                        int displayIndex = selectedValue == 'new'
                            ? entryList.length - 1 - index
                            : index;
                        var listItem = entryList[displayIndex];
                        DateTime dateTime =
                            DateTime.parse(listItem['dateNtime']);
                        int hour = dateTime.hour;
                        String period = hour >= 12 ? 'PM' : 'AM';
                        if (hour == 0) {
                          hour = 12;
                        } else if (hour > 12) {
                          hour -= 12;
                        }
                        String date =
                            '${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year}';
                        String time =
                            '${hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} $period';
                        return Animate(
                          effects: [
                            FadeEffect(
                                duration: 300.ms, delay: (100 * index).ms)
                          ],
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  listItem['reason'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xff353535),
                                      fontFamily: 'inter',
                                      fontSize: screenWidth * 0.042),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 4.0),
                                    CaptionStyle(
                                        textColor: const Color(0xff454545),
                                        text: 'Date: $date',
                                        fontSize: screenWidth * 0.035)
                                  ],
                                ),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CaptionStyle(
                                        textColor: const Color(0xff646464),
                                        text: time,
                                        fontSize: screenWidth * 0.03)
                                  ],
                                ),
                                leading: CaptionStyle(
                                    textColor: const Color(0xff404040),
                                    text: (index + 1).toString(),
                                    fontSize: screenWidth * 0.03),
                                visualDensity:
                                    VisualDensity.adaptivePlatformDensity,
                              ),
                              const Divider(
                                color: Colors.black26,
                                thickness: 1,
                                indent: 15,
                                endIndent: 15,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
