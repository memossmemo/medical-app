import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'main.dart';

class ImageCarousel extends StatefulWidget {
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final Map<String, dynamic> patientData = {
    "name": "محمد علي",
    "date": "2025-03-02",
    "time": "14:30",
    "image": "https://via.placeholder.com/150", // رابط صورة وهمي
  };
  void _showFullImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero, // إزالة المسافات من الـ Dialog
          content: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(); // إغلاق الـ Dialog عند النقر على الصورة
            },
            child: Image.asset(
              "photo/pharm2.png",
              fit: BoxFit.contain, // لضبط الصورة داخل الـ Dialog بدون تشويه
              width: MediaQuery.of(context).size.width, // عرض الصورة بحسب حجم الشاشة
              height: MediaQuery.of(context).size.height, // ارتفاع الصورة بحجم الشاشة بالكامل
            ),
          ),
        );
      },
    );
  }
  void _showPriceDialog(BuildContext context) {
    TextEditingController priceController = TextEditingController(); // للتحكم في النص المدخل

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('معلومات المريض')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20), // مسافة من الأعلى والأسفل
        child: Stack(
          children: [
            // ✅ الطبقة الخلفية: الكارد يأخذ عرض الشاشة بالكامل
            Container(
              width: double.infinity, // عرض الشاشة بالكامل
              height: 150, // ارتفاع الكارد
              margin: EdgeInsets.symmetric(horizontal: 10), // تباعد خفيف من الجوانب
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
              left: 20, // النص على اليسار
              right: 110, // يترك مساحة للصورة على اليمين
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patientData["name"],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.date_range, color: Colors.blueAccent, size: 18),
                      SizedBox(width: 5),
                      Text(
                        patientData["date"],
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.green, size: 18),
                      SizedBox(width: 5),
                      Text(
                        patientData["time"],
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Positioned(
              top: 15,
              right: 15,
              child: GestureDetector(
                onTap: () {
                  // عند النقر على الصورة يتم فتح الـ AlertDialog
                  _showFullImageDialog(context);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    "photo/pharm2.png",
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // ✅ زر "نعم" على اليمين في أسفل البطاقة
            Positioned(
              bottom: 10, // وضع الزر في أسفل البطاقة
              left: 15, // تباعد من الجهة اليمنى
              child: ElevatedButton(
                onPressed: () {
                  // عند النقر على الزر، سيتم فتح الـ AlertDialog
                  _showPriceDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // لون الزر الأخضر
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // الزر دائر الشكل
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
      ),
    );
  }
}
