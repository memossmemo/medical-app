import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class postrate extends StatefulWidget {
  const postrate({super.key});

  @override
  State<postrate> createState() => _selState();
}

class _selState extends State<postrate> {
  double _rating = 3.0; // القيمة الافتراضية
  bool _isSubmitting = false;

  // ✨ دالة لإرسال التقييم إلى API
  Future<void> submitRating(double rating) async {
    setState(() {
      _isSubmitting = true;
    });

    String url = "https://example.com/api/rating"; // استبدل برابط API الحقيقي

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"rating": rating}), // إرسال التقييم كـ JSON
      );

      if (response.statusCode == 200) {
        print("تم إرسال التقييم بنجاح: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("تم إرسال التقييم بنجاح ✅")),
        );
      } else {
        print("فشل في إرسال التقييم: ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("فشل في إرسال التقييم ❌")),
        );
      }
    } catch (e) {
      print("خطأ أثناء الإرسال: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("حدث خطأ أثناء الإرسال ⚠️")),
      );
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("إرسال التقييم")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("قيّم تجربتك:", style: TextStyle(fontSize: 20)),

            // ⭐⭐⭐⭐⭐ مكوّن التقييم
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),

            const SizedBox(height: 20),

            // زر إرسال التقييم
            ElevatedButton(
              onPressed: _isSubmitting ? null : () => submitRating(_rating),
              child: _isSubmitting
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("إرسال التقييم"),
            ),
          ],
        ),
      ),
    );
  }
}
