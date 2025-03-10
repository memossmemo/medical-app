import 'dart:convert';

import 'package:triaq/view/variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../My Wedgit/custom_Text.dart';
import 'package:http/http.dart' as http;

class Login_analyst extends StatefulWidget {
  const Login_analyst({super.key});

  @override
  State<Login_analyst> createState() => _LoginState();
}

class _LoginState extends State<Login_analyst> {
  bool isEmailValid(String email) {
    // تعبير منتظم للتحقق من صحة البريد الإلكتروني
    RegExp regExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regExp.hasMatch(email);
  }

  variables vare = variables();
  TextEditingController login_email = TextEditingController();
  TextEditingController login_password = TextEditingController();

  Future<void> signinPharmatic() async {
    // The URL of your API
    final url = Uri.parse(
        'https://pharma-manager-copy-2.onrender.com/api/Analyst/signinAnalyst');

    // Prepare the request body
    final body = {
      'email': login_email.text,
      'password': login_password.text,
    };

    // Make the POST request
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      // Handle the response
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('User logged in successfully: $data');
        shared?.setString("token_analyst", data['token']);
        // Handle successful login here (store user data, navigate to another screen, etc.)
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        // Handle error here (show message to user, etc.)
      }
    } catch (e) {
      print('Error: $e');
      // Handle network or other errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("تسجيل الدخول"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 300,
              height: 300,
              child: Image.asset(fit: BoxFit.cover, "photo/pharm2.png"),
            ),
            Container(
              height: 30,
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 80),
                width: 300,
                height: 50,
                child: Custom_Text(
                  validator: (val) {
                    if (!isEmailValid(val!) || val.isEmpty) {
                      return "الرجاء التاكد من الايميل";
                    }
                    return null;
                  },
                  labelText: 'الايميل',
                  controller: login_email,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
            ),
            Container(
              height: 40,
            ),
            Center(
              child: Container(
                width: 300,
                height: 50,
                child: Custom_Text(
                  validator: (val) {
                    return null;
                  },
                  labelText: 'كلمة المرور',
                  controller: login_password,
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),
            ),
            Container(
              height: 60,
            ),
            ElevatedButton(
              onPressed: () {
                signinPharmatic();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                // لون النص عند الضغط
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 25.0),
                // المسافة حول النص
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), // الزوايا المدورة
                ),
                elevation: 5, // الظل لإعطاء تأثير العمق
              ),
              child: Text(
                'تسجيل',
                style: TextStyle(
                  fontSize: 18.0, // حجم النص
                  fontWeight: FontWeight.bold, // جعل النص غامق
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
