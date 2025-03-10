import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:triaq/main.dart';
import 'package:triaq/view/Api/spec_Api.dart';
import 'package:triaq/view/variables.dart';
import 'Login/login_analyst.dart';
import 'Login/login_doctor.dart';
import 'Login/login.dart';
import 'Login/login_xray.dart';

class time extends StatefulWidget {
  @override
  State<time> createState() => _TimeState();
}

class _TimeState extends State<time> {
  late Future<String> _approvalStatus;

  @override
  void initState() {
    super.initState();
    _approvalStatus = _checkApprovalStatus();
  }

  Future<String> _checkApprovalStatus() async {

    final response =
      await http.post(
      Uri.parse(
          'https://pharma-manager-copy-2.onrender.com/api/${shared?.getString("spec")}/isApproved${shared?.getString("spec")}'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'email': shared?.getString("b")}),
    );

    print(response.body); // طباعة الاستجابة للتحقق من القيم
    // التحقق من القيم

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['message'];
    } else {
      return 'Error checking approval status';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Waiting for Approval')),
      body: FutureBuilder<String>(
        future: _approvalStatus,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // طباعة قيمة snapshot.data للتحقق من محتواها
          print('Snapshot data: ${snapshot.data}');

          // تحقق من القيمة التي يعيدها الخادم
          if (snapshot.data == 'user is  approved sucessfully!') {
            // تأجيل التنقل حتى اكتمال بناء الصفحة
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (shared?.getString("spec") != null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              }
              shared?.setInt("select", 0);
            });
          }

          return Center(child: Text(snapshot.data ?? ''));
        },
      ),
    );
  }
}
