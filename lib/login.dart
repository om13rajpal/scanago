import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: const Color(0xFFF8F4EA),
      child: Column(
        children: [
          Container(
            color: Colors.blue,
            height: MediaQuery.of(context).size.height * 0.15,
            child: const Center(
              child: Text('Scanago'),
            ),
          ),
          Container(
            color: Colors.amber,
            height: MediaQuery.of(context).size.height * 0.65,
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'assets/images/woman.png',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Unlock\ncampus\nwith a\nscan'),
                        TextField(),
                        TextField(),
                        ElevatedButton(
                            onPressed: () {
                              print('login clicked');
                            },
                            child: const Text('Login'))
                      ]),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.20,
            color: Colors.cyan,
          )
        ],
      ),
    ));
  }
}
