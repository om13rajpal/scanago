import 'package:flutter/material.dart';
import 'package:scanago/button.dart';
import 'package:scanago/entryList.dart';

class Account extends StatefulWidget {
  final String email;
  final String name;
  final String branch;
  final String rollNo;
  const Account(
      {super.key,
      required this.email,
      required this.name,
      required this.branch,
      required this.rollNo});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
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
              height: MediaQuery.of(context).size.height * 0.30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Hey ${widget.name}!',
                    style: const TextStyle(
                        fontFamily: 'monkey',
                        fontSize: 40,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Roll Number: ${widget.rollNo}',
                    style: const TextStyle(
                        fontFamily: 'monkey',
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Branch: ${widget.branch}',
                    style: const TextStyle(
                        fontFamily: 'monkey',
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    child: Button(
                        text: 'View Home Entry',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EntryList(
                                    email: widget.email,
                                    listType: 'listHomeEntry'),
                              ));
                        },
                        radius: 12,
                        fontSize: 12),
                  ),
                  SizedBox(
                    height: 40,
                    child: Button(
                        text: 'View Local Entry',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EntryList(
                                    email: widget.email,
                                    listType: 'listLocalEntry'),
                              ));
                        },
                        radius: 12,
                        fontSize: 12),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
