import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EntryList extends StatefulWidget {
  final String email;
  final String listType;
  const EntryList({super.key, required this.email, required this.listType});

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
      Uri.parse('http://localhost:3000/${widget.listType}'),
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
          print(listData);
        } else {
          print("Expected a list but got: $listData");
        }
      } else {
        print("Response status is false: ${jsonRes['message']}");
      }
    } else {
      print("HTTP request failed with status: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color(0xFFF8F4EA),
        child: entryList.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: entryList.length,
                itemBuilder: (context, index) {
                  var listItem = entryList[index];
                  DateTime dateTime = DateTime.parse(listItem['dateNtime']);
                  String date =
                      '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
                  String time =
                      '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
                  return ListTile(
                    title: Text(listItem['email']),
                    subtitle: Text(date),
                    trailing: Text(time),
                    leading: Text((index + 1).toString()),
                  );
                },
              ),
      ),
    );
  }
}
