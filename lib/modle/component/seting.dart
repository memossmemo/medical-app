import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triaq/main.dart';
import 'package:triaq/modle/component/substring.dart';
import 'package:triaq/view/variables.dart';

import 'notification.dart';

class seting extends StatefulWidget {
  const seting({super.key});

  @override
  State<seting> createState() => _pharmState();
}

class _pharmState extends State<seting> {

  Future<void> update_pharm() async {
    String url =
        'https://pharma-manager-copy-2.onrender.com/api/Pharmatic/updatePharInfo/${shared?.getString("id_spec")}';
    print(shared?.getString("id_spec"));
    final Map<String, dynamic> body = {
      'fullName': _nameController.text,
      'city': city.text,
      'region': ragon.text,
      'address': addressController.text,
      "phone": '+20' + _phoneController.text.toString(),
      'StartJob': _startTime.toString(),
      'EndJob': _endTime.toString(),
    };

    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${shared?.getString("token_spec")}'
        },
        body: jsonEncode(body),
      );
      print(response.statusCode);
      // Check the response
      if (response.statusCode == 201) {
        print('User registered successfully: ${response.body}');
      } else {
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // قائمة لتغيير محتوى الشاشة حسب الخيار المح
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController =
      TextEditingController(text: shared?.getString("a"));
  final TextEditingController _phoneController =
      TextEditingController(text: shared?.getString("g"));
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController emailController =
      TextEditingController(text: shared?.getString("b"));
  final TextEditingController passwordController =
      TextEditingController(text: shared?.getString("c"));
  final TextEditingController addressController =
      TextEditingController(text: shared?.getString("f"));
  final TextEditingController city =
      TextEditingController(text: shared?.getString("d"));
  final TextEditingController ragon =
      TextEditingController(text: shared?.getString("e"));
  variables vare = variables();

  substring ll = substring();







  var _startTime = TimeOfDay(hour: 3, minute: 0);
  var _endTime = TimeOfDay(hour: 10, minute: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Text(' الاعدادات'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextFormField(
                      controller: _nameController,
                      icon: Icons.local_pharmacy,
                    ),
                    _buildTextFormField(
                      controller: emailController,
                      icon: Icons.email,
                    ),
                    _buildTextFormField(
                      controller: passwordController,
                      icon: Icons.password,
                    ),
                    _buildTextFormField(
                      controller: _phoneController,
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                    ),
                    _buildTimeRow(
                      label: 'وقت البدء',
                      selectedTime: _startTime,
                      isStartTime: true,
                    ),
                    _buildTimeRow(
                      label: 'وقت الانتهاء',
                      selectedTime: _endTime,
                      isStartTime: false,
                    ),
                    _buildTextFormField(
                      controller: city,
                      icon: Icons.location_city,
                    ),
                    _buildTextFormField(
                      controller: ragon,
                      icon: Icons.email,
                    ),
                    _buildTextFormField(
                      controller: addressController,
                      icon: Icons.location_city,
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            update_pharm();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[600],
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'تحديث المعلومات',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    var labelText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue[600]!),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'يرجى إدخال $labelText';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildTimeRow(
      {required String label,
      required TimeOfDay selectedTime,
      required bool isStartTime}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () => _selectTime(context, isStartTime),
            child: Text(
              '${selectedTime.format(context)}',
              style: TextStyle(fontSize: 16, color: Colors.blue[600]),
            ),
          ),
        ],
      ),
    );
  }

  void _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? _startTime : _endTime,
    );
    if (picked != null && picked != (isStartTime ? _startTime : _endTime)) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

// void _submitForm() {
//   if (_formKey.currentState?.validate() ?? false) {
//     // إرسال البيانات أو حفظها
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('تم التحديث'),
//           content: Text('تم تحديث معلومات الصيدلية بنجاح!'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('موافق'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
}
