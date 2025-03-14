import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:triaq/main.dart';
import 'Login/login.dart';

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
    final response = await http.post(
      Uri.parse(
          'https://pharma-manager-copy-2.onrender.com/api/${shared?.getString("spec")}/isApproved${shared?.getString("spec")}'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'email': shared?.getString("b")}),
    );

    print(response.body); // طباعة الاستجابة للتحقق من القيم
    // التحقق من القيم

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return  "user is  approved sucessfully!";
    } else {
      return  " الرجاء الانتظار";    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('صفحة الانتظار')),
      body: FutureBuilder<String>(
        future: _approvalStatus,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("${snapshot.data}//////////////////////////////////////");

            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print("${snapshot.data}//////////////////////////////////////");

            return Center(child: Text('يوجد خطا'));
          }

          // طباعة قيمة snapshot.data للتحقق من محتواها
          print('Snapshot data: ${snapshot.data}');

          // تحقق من القيمة التي يعيدها الخادم
          if (snapshot.data == 'user is  approved sucessfully!') {
            print("${snapshot.data}//////////////////////////////////////");
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Future.delayed(Duration(milliseconds: 500), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              });
            });
          }
// shared?.setInt("select", 0);
          return Center(child: Text("انتظر لتتم الموافقة" ?? ''));
        },
      ),
    );
  }
}
