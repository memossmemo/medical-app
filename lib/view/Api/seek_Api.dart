import 'dart:convert';

import 'package:triaq/main.dart';
import 'package:triaq/view/variables.dart';

import 'package:http/http.dart' as http;

class seek_Api {
  variables vare = variables();

  Future<void> register_seek() async {
    const String url =
        'https://pharma-manager-copy-2.onrender.com/api/Pharmatic/createNewSeek';

    // Construct the body of the request
    final Map<String, dynamic> body = {
      'fullName': variables.seek_name.text,
      "phone": '+20'+variables.seek_number.text.toString(),
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
      print('User registered successfully: ${response.body}');
      // Check the response
      if (response.statusCode == 201) {
        final dataa = json.decode(response.body);
        print('User registered successfully: ${response.body}');
        shared?.setString("id_seek", "${dataa["newSeek"]["_id"]}");
        shared?.setString("token_seek", "${dataa["token"]}");
      } else {
        print('Failed to register user: ${response.statusCode}');
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
