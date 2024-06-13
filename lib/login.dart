import 'package:flutter/material.dart';
import 'package:scanago/button.dart';

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
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'assets/images/woman.png',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Unlock\ncampus\nwith a\nscan',
                          style: TextStyle(
                              fontFamily: 'monkey', fontSize: 30, height: 1.2),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Colors.white,
                              size: 20,
                            ),
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
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 20,
                            ),
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
                          height: 35,
                          width: 91,
                          child: Button(
                              text: 'Login',
                              onPressed: () {},
                              radius: 20,
                              fontSize: 15),
                        )
                      ]),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.20,
          )
        ],
      ),
    ));
  }
}
