import 'dart:convert';

import 'package:http/http.dart' as http;

class pharma_Api {
  Future<void> fetchData(String city, String address) async {
    String url =
        'https://pharma-manager-copy-2.onrender.com/api/getPharmainCity';
    url += '/$city';
    url += '/$address';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 201) {
        final dataa = json.decode(response.body);
        print(dataa);
        return dataa;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
  }
}
