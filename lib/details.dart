import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lottie/lottie.dart';
import 'package:mime/mime.dart';
import 'package:scanago/templates/button.dart';
import 'package:scanago/dashboard.dart';
import 'package:scanago/templates/caption_style.dart';
import 'package:scanago/templates/textfield.dart';
import 'package:scanago/utils/route_animation.dart';
import 'package:scanago/utils/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Details extends StatefulWidget {
  final String token;
  final String saveType;
  const Details({super.key, required this.token, required this.saveType});

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
        setUserInfo(JwtDecoder.decode(jsonRes['token']), jsonRes['token']);

        await prefs.setBool('dataSaved', true);
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

        var emailbody = {"email": email};

        await http.post(
            Uri.parse('https://scanago.onrender.com/sendVerificationMail'),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(emailbody));

        if (!context.mounted) return;

        Navigator.pushReplacement(
          context,
          createFadeRoute(Dashboard(token: token)),
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

  Future<void> updateData(BuildContext context) async {
    var body = {
      'email': email,
      'name': name.text,
      'phoneNo': phoneNo.text,
      'room': room.text,
      'rollNo': rollNo.text,
      'branch': (_selectedValue == 1) ? 'CSE' : 'MBA',
      'image': _uploadedImageUrl,
    };

    var response = await http.post(
        Uri.parse('https://scanago.onrender.com/updateNewDetails'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body));

    var jsonRes = await jsonDecode(response.body);
    if (jsonRes['status']) {
      Fluttertoast.showToast(
        msg: "Entry Updated",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.setString('token', jsonRes['token']);
      setUserInfo(JwtDecoder.decode(jsonRes['token']), jsonRes['token']);

      if (!context.mounted) return;

      Navigator.pushReplacement(
        context,
        createFadeRoute(Dashboard(token: token)),
      );
    } else {
      Fluttertoast.showToast(
        msg: "Could not update entry",
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
  late String? token = '';
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
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xfff3f3f3), Color(0xffd8d8d8)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
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
                height: MediaQuery.of(context).size.height * 0.8,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(screenWidth * 0.25,
                          -MediaQuery.of(context).size.height * 0.1),
                      child: LottieBuilder.asset(
                        'assets/lottie/run.json',
                        renderCache: RenderCache.raster,
                        width: screenWidth,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Textfield(
                          controller: name,
                          hintText: 'Name',
                          screenWidth: screenWidth,
                          obscure: false,
                          prefixIcon: Icons.account_circle,
                        ),
                        Textfield(
                          controller: phoneNo,
                          hintText: 'Phone Number',
                          screenWidth: screenWidth,
                          obscure: false,
                          prefixIcon: Icons.phone,
                        ),
                        Textfield(
                          controller: rollNo,
                          hintText: 'Roll Number',
                          screenWidth: screenWidth,
                          obscure: false,
                          prefixIcon: Icons.confirmation_number,
                        ),
                        Textfield(
                          controller: room,
                          hintText: 'Room Number',
                          screenWidth: screenWidth,
                          obscure: false,
                          prefixIcon: Icons.room,
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
                                CaptionStyle(
                                    textColor: const Color(0xff747474),
                                    text: 'CSE',
                                    fontSize: screenWidth * 0.04)
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
                                CaptionStyle(
                                    textColor: const Color(0xff747474),
                                    text: 'MBA',
                                    fontSize: screenWidth * 0.04)
                              ],
                            ),
                          ],
                        ),
                        Button(
                          onPressed: pickImage,
                          text: imagebutton,
                          fontSize: screenWidth * 0.035,
                          radius: 12,
                        ),
                        Button(
                            text: 'Save',
                            onPressed: () {
                              (widget.saveType == 'save')
                                  ? saveData(context)
                                  : updateData(context);
                            },
                            radius: 12,
                            fontSize: screenWidth * 0.035)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
