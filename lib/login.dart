import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:scanago/button.dart';
import 'package:scanago/dashboard.dart';
import 'package:scanago/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late SharedPreferences prefs;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    initSharedPrefs();
    super.initState();
  }

  void initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser(BuildContext context) async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      var body = {
        "email": email.text.trim(),
        "password": password.text.trim(),
      };

      var response = await http.post(Uri.parse('http://localhost:3000/login'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body));

      var jsonRes = jsonDecode(response.body);
      if (jsonRes['status']) {
        var myToken = jsonRes['token'];
        await prefs.setString('token', myToken);
        if (!context.mounted) return;

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Dashboard(token: myToken),
            ));
      }
    }
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
                          controller: email,
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
                          controller: password,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 35,
                              width: 91,
                              child: Button(
                                  text: 'Login',
                                  onPressed: () {
                                    loginUser(context);
                                  },
                                  radius: 20,
                                  fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'New to this app?',
                                  style: TextStyle(fontFamily: 'monkey '),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const SignUp(),
                                        ));
                                  },
                                  child: const Text(
                                    'Sign up',
                                    style: TextStyle(
                                        fontFamily: 'monkey',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
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
