import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mime/mime.dart';
import 'package:scanago/button.dart';
import 'package:scanago/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Details extends StatefulWidget {
  final String token;
  const Details({super.key, required this.token});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String? _uploadedImageUrl =
      "https://res.cloudinary.com/dvhwz7ptr/image/upload/v1720547605/pngwing.com_1_zk9ic6.png";

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      await _uploadImage(_image!);
    }
  }

  Future<void> _uploadImage(File image) async {
    final mimeType = lookupMimeType(image.path)?.split('/');
    if (mimeType == null) return;

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('https://api.cloudinary.com/v1_1/dvhwz7ptr/image/upload'),
    );

    request.fields['upload_preset'] = 'yivzihlh';
    request.files.add(await http.MultipartFile.fromPath(
      'file',
      image.path,
      contentType: MediaType(mimeType[0], mimeType[1]),
    ));

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final data = jsonDecode(responseData);
      Fluttertoast.showToast(
        msg: "Image Uploaded",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      setState(() {
        imagebutton = "Image Uploaded";
        _uploadedImageUrl = data['secure_url'];
      });
    }
  }

  Route _createFadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  Future<void> saveData(BuildContext context) async {
    var body = {
      'email': email,
      'name': name.text,
      'phoneNo': phoneNo.text,
      'room': room.text,
      'rollNo': rollNo.text,
      'branch': (_selectedValue == 1) ? 'CSE' : 'MBA',
      'image': _uploadedImageUrl,
    };

    if (name.text.isNotEmpty &&
        phoneNo.text.isNotEmpty &&
        room.text.isNotEmpty &&
        rollNo.text.isNotEmpty) {
      var response = await http.post(
        Uri.parse('https://scanago.onrender.com/updateDetails'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      var jsonRes = await jsonDecode(response.body);

      if (jsonRes['status']) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        var body = {"endUser": email, "name": name.text};
        http.post(Uri.parse('https://scanago.onrender.com/sendMail'),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(body));

        await prefs.remove('token');
        await prefs.setString('token', jsonRes['token']);
        token = prefs.getString('token');

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

        Navigator.pushReplacement(
          context,
          _createFadeRoute(Dashboard(token: token)),
        );
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
    } else {
      Fluttertoast.showToast(
        msg: "Please fill all the fields",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  TextEditingController name = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController rollNo = TextEditingController();
  TextEditingController room = TextEditingController();
  late String email;
  late String? token;
  late String imagebutton = "Select Image";

  int? _selectedValue;

  @override
  void initState() {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(widget.token);
    email = decodedToken['email'];
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
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
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    controller: name,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      prefixIcon: const Icon(
                        Icons.account_circle,
                        color: Colors.white,
                        size: 20,
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(230, 0, 0, 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: const TextStyle(
                        color: Colors.white60,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: phoneNo,
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      prefixIcon: const Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 20,
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(230, 0, 0, 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: const TextStyle(
                        color: Colors.white60,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: room,
                    decoration: InputDecoration(
                      hintText: 'Room',
                      prefixIcon: const Icon(
                        Icons.room,
                        color: Colors.white,
                        size: 20,
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(230, 0, 0, 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: const TextStyle(
                        color: Colors.white60,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: rollNo,
                    decoration: InputDecoration(
                      hintText: 'Roll Number',
                      prefixIcon: const Icon(
                        Icons.numbers,
                        color: Colors.white,
                        size: 20,
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(230, 0, 0, 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: const TextStyle(
                        color: Colors.white60,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: _selectedValue,
                            onChanged: (value) {
                              setState(() {
                                _selectedValue = value;
                              });
                            },
                          ),
                          const Text(
                            'CSE',
                            style: TextStyle(
                                fontFamily: 'monkey',
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 2,
                            groupValue: _selectedValue,
                            onChanged: (value) {
                              setState(() {
                                _selectedValue = value;
                              });
                            },
                          ),
                          const Text(
                            'MBA',
                            style: TextStyle(
                                fontFamily: 'monkey',
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                  Button(
                    onPressed: pickImage,
                    text: imagebutton,
                    fontSize: 12,
                    radius: 12,
                  ),
                  Button(
                      text: 'Save',
                      onPressed: () {
                        saveData(context);
                      },
                      radius: 12,
                      fontSize: 12)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
