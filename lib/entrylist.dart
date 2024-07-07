import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EntryList extends StatefulWidget {
  final String? email;
  final String listType;
  const EntryList({super.key, this.email, required this.listType});

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
    var body = {"email": widget.email};
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

  String dropdownValue = 'old';

  var items = ['old', 'new'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            color: const Color(0xFFF8F4EA),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward,
                      color: Color.fromARGB(255, 0, 0, 0)),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  dropdownColor: Colors.white,
                  underline: Container(
                    height: 2,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: items.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: value == dropdownValue
                              ? const Color.fromARGB(255, 0, 0, 0)
                              : Colors.black,
                          fontWeight: value == dropdownValue
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    );
                  }).toList(),
                  selectedItemBuilder: (BuildContext context) {
                    return items.map<Widget>((String value) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          value,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList();
                  },
                )
              ],
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.9,
              color: const Color(0xFFF8F4EA),
              child: entryList.isEmpty
                  ? const Center(child: Text('No Entry Found'))
                  : ListView.builder(
                      reverse: false,
                      itemCount: entryList.length,
                      itemBuilder: (context, index) {
                        int displayIndex = dropdownValue == 'new'
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
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 8.0),
                          color: Colors.black,
                          child: ListTile(
                            title: Text(
                              listItem['reason'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4.0),
                                Text(
                                  'Name: ${listItem['name']}',
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                Text(
                                  'Branch: ${listItem['branch']}',
                                  style: const TextStyle(color: Colors.white60),
                                ),
                                Text(
                                  'Date: $date',
                                  style: const TextStyle(color: Colors.white54),
                                ),
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  time,
                                  style: const TextStyle(color: Colors.white60),
                                ),
                              ],
                            ),
                            leading: CircleAvatar(
                              backgroundColor: Colors.white60,
                              child: Text(
                                (displayIndex + 1).toString(),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                            visualDensity:
                                VisualDensity.adaptivePlatformDensity,
                          ),
                        );
                      }))
        ],
      ),
    );
  }
}
