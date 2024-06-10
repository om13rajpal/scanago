import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color(0xFFF8F4EA),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              color: Colors.blue,
              child: const Center(
                child: Text('Scanago'),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.65,
              color: Colors.amber,
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: Image.asset('assets/images/man.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 25),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Image.asset('assets/images/side_design.png'),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 40.0, left: 20, bottom: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 60,
                          color: Colors.black,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 60,
                          color: Colors.black,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 60,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
