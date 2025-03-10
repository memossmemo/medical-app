import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';

class notification extends StatefulWidget {
  const notification({super.key});

  @override
  State<notification> createState() => _State();
}

class _State extends State<notification> {
  TextEditingController priceController = TextEditingController();

  Future<void> post_price() async {
     String url =
        'https://pharma-manager-copy-2.onrender.com/api/${shared?.getString("spec")}/respond-request-from-${shared?.getString("spec")}';

    // Construct the body of the request
    final Map<String, dynamic> body = {
      "requestId": shared?.getString("request_id"),
      "specId": shared?.getString("id_spec"),
      "price": priceController.text,
      "accepted": true,
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
      if (response.statusCode == 200) {
        final dataa = json.decode(response.body);
      } else {
        print('Failed to register user: ${response.statusCode}');
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
  void _showFullImageDialog(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero, // إزالة المسافات من الـ Dialog
          content: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pop(); // إغلاق الـ Dialog عند النقر على الصورة
            },
            child: Image.network(
              url,
              fit: BoxFit.contain, // لضبط الصورة داخل الـ Dialog بدون تشويه
              width: MediaQuery.of(context)
                  .size
                  .width, // عرض الصورة بحسب حجم الشاشة
              height: MediaQuery.of(context)
                  .size
                  .height, // ارتفاع الصورة بحجم الشاشة بالكامل
            ),
          ),
        );
      },
    );
  }

  void showPriceDialog(BuildContext context) {
    // للتحكم في النص المدخل

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('حدد السعر'),
          content: TextField(
            controller: priceController,
            decoration: InputDecoration(
              labelText: 'السعر',
              hintText: 'أدخل السعر',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number, // لضمان إدخال الأرقام
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // إغلاق الـ dialog
              },
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                // هنا يمكن استخدام السعر المدخل
                String enteredPrice = priceController.text;
                if (enteredPrice.isNotEmpty) {
                  post_price();
                  // يمكنك القيام بأي عملية مع السعر المدخل
                  print('تم تحديد السعر: $enteredPrice');
                } else {
                  print('لم يتم إدخال السعر');
                }
                Navigator.of(context).pop(); // إغلاق الـ dialog
              },
              child: Text('تحديد'),
            ),
          ],
        );
      },
    );
  }


  Future<Map<String, dynamic>> get_req() async {
    final String apiUrl =
        "https://pharma-manager-copy-2.onrender.com/api/${shared?.getString("spec")}/${shared?.getString("spec")}-requests/${shared?.getString("id_spec")}";
    // استبدل بالرابط الحقيقي

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        print(response.body);
        return json.decode(response.body); // تحويل JSON إلى Map
      } else {
        throw Exception(
            "فشل في جلب البيانات، كود الخطأ: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("حدث خطأ أثناء جلب البيانات: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    shared?.setString("spec", "Analyst");
    print(shared?.getString("spec"));
    shared?.setString("id_spec", "67c9948b8ca734376fc32308");
     shared?.setString("request_id", "67c998098ca734376fc32325");
    print(shared?.getString("id_spec"));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "الطلبات",
        ),
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: get_req(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('خطأ: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return Text('لا توجد بيانات');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!["requests"].length,
                // عدد المرضى في القائمة
                itemBuilder: (context, index) {
                  shared?.setString(
                      "request_id", snapshot.data!["requests"][index]["_id"]);
                  // جلب بيانات المريض الحالي

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Stack(
                      children: [
                        // ✅ الطبقة الخلفية: الكارد
                        Container(
                          width: double.infinity,
                          height: 150,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: Offset(3, 3),
                              ),
                            ],
                          ),
                        ),

                        // ✅ الطبقة العلوية: المحتوى
                        Positioned(
                          top: 15,
                          left: 20,
                          right: 110,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!["requests"][index]["patientId"]
                                ["fullName"],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.date_range,
                                      color: Colors.blueAccent, size: 18),
                                  SizedBox(width: 5),
                                  Text(
                                    snapshot.data!["requests"][index]
                                    ["dateFormatted"],
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.access_time,
                                      color: Colors.green, size: 18),
                                  SizedBox(width: 5),
                                  Text(
                                    snapshot.data!["requests"][index]
                                    ["timeFormatted"],
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // ✅ صورة على اليمين
                        Positioned(
                          top: 15,
                          right: 15,
                          child: GestureDetector(
                            onTap: () {
                              _showFullImageDialog(
                                  context,
                                  snapshot.data!["requests"][index]
                                  ["imageUrl"]);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                snapshot.data!["requests"][index]["imageUrl"],
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                        // ✅ زر "نعم"
                        Positioned(
                          bottom: 10,
                          left: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              showPriceDialog(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'نعم',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ), Positioned(
                          bottom: 10,
                          left: 15,
                          child: ElevatedButton(
                            onPressed: () {

                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'نعم',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }}