import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:triaq/modle/Sections/Analyst.dart';
import 'package:triaq/modle/Sections/xray.dart';

import '../../main.dart';
import '../Sections/pharma.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double _rating = 3.0; // القيمة الافتراضية
  bool _isSubmitting = false;

  // ✨ دالة لإرسال التقييم إلى API
  Future<void> submitRating_pharm() async {
    setState(() {
      _isSubmitting = true;
    });

    String url =  'https://pharma-manager-copy-2.onrender.com/api/Pharmatic/ratePharmacy/${shared?.getString("id_pharm")}';

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json",
        "Authorization":"Bearer ${shared?.getString("token_seek")}"},
        body: jsonEncode({"rating": _rating,"userId":shared?.getString("id_seek")}), // إرسال التقييم كـ JSON
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
    if (shared?.getString("rat") == "pharmatic") {
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
                minRating: 0,
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
                onPressed: () async {

                  await submitRating_pharm();
                  print(shared?.getString("id_pharm"));
                },
                child:

                    const Text("إرسال التقييم"),
              ),
            ],
          ),
        ),
      );
    } else if (shared?.getString("rat") == "radiology") {
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

            ],
          ),
        ),
      );
    } else if (shared?.getString("rat") == "Analyst") {
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

            ],
          ),
        ),
      );
    }
    return Container();
  }
}
// double _rating = 0.0; // القيمة الافتراضية
// bool _isLoading = true;
//
// // 🌍 دالة لجلب التقييم من API
// Future<void> fetchRating() async {
//   String url =  'https://pharma-manager-copy-2.onrender.com/api/Pharmatic/final-rate-pharmacy/${shared?.getString("id")}';
//
//   try {
//     var response = await http.get(Uri.parse(url));
//
//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       setState(() {
//         _rating = (data['finalRate'] ?? 0.0).toDouble();
//         _isLoading = false;
//       });
//     } else {
//       print("فشل في جلب التقييم: ${response.statusCode}");
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   } catch (e) {
//     print("خطأ أثناء الاتصال بـ API: $e");
//     setState(() {
//       _isLoading = false;
//     });
//   }
// }
// void initState() {
//   super.initState();
//   print(shared?.getString("id"));
//   fetchRating(); // جلب التقييم عند تشغيل التطبيق
// }
//
// @override
// Widget build(BuildContext context) {
//   // if (shared?.getString("rat") == "pharmatic"){
//   return Scaffold(
//     appBar: AppBar(title: Text("تقييم الصيدلية")),
//     body: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Text("التقييم العام:", style: TextStyle(fontSize: 20)),
//
//           // ⭐⭐⭐⭐⭐ مكوّن التقييم (يستخدم فقط للعرض)
//           RatingBarIndicator(
//             rating: _rating,
//             itemCount: 5,
//             itemSize: 40.0,
//             physics: const BouncingScrollPhysics(),
//             itemBuilder: (context, _) => const Icon(
//               Icons.star,
//               color: Colors.amber,
//             ),
//           ),
//
//           const SizedBox(height: 20),
//
//           // عرض التقييم الرقمي
//           Text("التقييم الحالي: $_rating", style: const TextStyle(fontSize: 18)),
//         ],
//       ),
//     ),
//   );
