import 'dart:convert';
import 'package:triaq/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:triaq/view/variables.dart';

class spec_Api {
  variables vare = variables();
  static bool emailvalidate = false;

//   static Future<bool> checkEmailExists(String email) async {
//     const String url = 'https://pharma-manager-copy-2.onrender.com/api/EmailisUsed'; // استبدل بـ API حقيقي للتحقق من الإيميل
// print(email);
//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({'email':email}),
//       );
//
// print(response.statusCode);
//       if (response.statusCode == 400) {
//         return true; // تأكد من أن المفتاح في الـ API هو `emailExists`
//       }
//         return false;
//
//     } catch (e) {
//       print('Error occurred while checking email: $e');
//       return false;
//     }
//   }

  Future<void> register_pharm() async {
    const String url =
        'https://pharma-manager-copy-2.onrender.com/api/Pharmatic/createNewPharmatic';
    final Map<String, dynamic> body = {
      'fullName': variables.name.text,
      'email': variables.email.text,
      'password': variables.password.text,
      'city': variables.selectedGovernorate,
      'region': variables.selectedRegion,
      'address': variables.address.text,
      "phone": '+20' + variables.number.text.toString(),
      'StartJob': variables.startTimeController.text,
      'EndJob': variables.endTimeController.text,
    };

    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      print(response.statusCode);
      // Check the response
      if (response.statusCode == 200) {
        print('User registered successfully: ${response.body}');
        await shared?.setBool("emailused", false);
      } else if (response.statusCode == 400) {
        await shared?.setBool("emailused", true);
      } else if (response.statusCode == 409) {
        print("..............................................");
        await shared?.setBool("emailused", true);
      } else {
        print('Failed to register user: ${response.statusCode}');
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> register_analyst() async {
    const String url =
        'https://pharma-manager-copy-2.onrender.com/api/Analyst/createNewAnalyst';
    final Map<String, dynamic> body = {
      'fullName': variables.name.text,
      'email': variables.email.text,
      'password': variables.password.text,
      'city': variables.selectedGovernorate,
      'region': variables.selectedRegion,
      'address': variables.address.text,
      "phone": '+20' + variables.number.text.toString(),
      'StartJob': variables.startTimeController.text,
      'EndJob': variables.endTimeController.text,
    };

    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      print(response.statusCode);
      // Check the response
      if (response.statusCode == 200) {
        print('User registered successfully: ${response.body}');
        await shared?.setBool("emailused", false);
      } else if (response.statusCode == 409) {
        print("..............................................");
        await shared?.setBool("emailused", true);
      } else {
        print('Failed to register user: ${response.statusCode}');
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> register_xradio() async {
    const String url =
        'https://pharma-manager-copy-2.onrender.com/api/Radiology/createNewRadiology';
    final Map<String, dynamic> body = {
      'fullName': variables.name.text,
      'email': variables.email.text,
      'password': variables.password.text,
      'city': variables.selectedGovernorate,
      'region': variables.selectedRegion,
      'address': variables.address.text,
      "phone": '+20' + variables.number.text.toString(),
      'StartJob': variables.startTimeController.text,
      'EndJob': variables.endTimeController.text,
    };

    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      print(response.statusCode);
      // Check the response
      if (response.statusCode == 200) {
        print('User registered successfully: ${response.body}');
        await shared?.setBool("emailused", false);
      } else if (response.statusCode == 409) {
        print("..............................................");
        await shared?.setBool("emailused", true);
      } else {
        print('Failed to register user: ${response.statusCode}');
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
