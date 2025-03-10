import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triaq/main.dart';
import 'package:triaq/modle/component/seting.dart';
import 'package:triaq/view/variables.dart';

import 'notification.dart';

class pharm extends StatefulWidget {
  const pharm({super.key});

  @override
  State<pharm> createState() => _pharmState();
}

class _pharmState extends State<pharm> {

  @override
  Widget build(BuildContext context) {

    if (shared?.getString("spec") == "pharmatic") {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "بيانات الصيدلية",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // لون الظل مع الشفافية
                blurRadius: 8, // مدى انتشار الظل
                offset: Offset(4, 4), // اتجاه الظل (أفقي، عمودي)
              ),
            ], borderRadius: BorderRadius.circular(20)),
            child: ListView(
              children: [
                buildText("الاسم", shared!.getString("a").toString()),
                buildText("الإيميل", shared!.getString("b").toString()),
                buildText("رقم الهاتف", shared!.getString("g").toString()),
                buildText("وقت البدء", shared!.get("h").toString()),
                buildText("وقت الانتهاء", shared!.getString("i").toString()),
                buildText("العنوان", shared!.getString("f").toString()),
              ],
            ),
          ),
        ),
      );
    } else if (shared?.getString("spec") == "Analyst") {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "بيانات مركز التحاليل",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // لون الظل مع الشفافية
                blurRadius: 8, // مدى انتشار الظل
                offset: Offset(4, 4), // اتجاه الظل (أفقي، عمودي)
              ),
            ], borderRadius: BorderRadius.circular(20)),
            child: ListView(
              children: [
                buildText("الاسم", shared!.getString("a").toString()),
                buildText("الإيميل", shared!.getString("b").toString()),
                buildText("رقم الهاتف", shared!.getString("g").toString()),
                buildText("وقت البدء", shared!.get("h").toString()),
                buildText("وقت الانتهاء", shared!.getString("i").toString()),
                buildText("العنوان", shared!.getString("f").toString()),
              ],
            ),
          ),
        ),
      );
    } else if (shared?.getString("spec") == "radiology") {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "بيانات مركز الاشعة",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // لون الظل مع الشفافية
                blurRadius: 8, // مدى انتشار الظل
                offset: Offset(4, 4), // اتجاه الظل (أفقي، عمودي)
              ),
            ], borderRadius: BorderRadius.circular(20)),
            child: ListView(
              children: [
                buildText("الاسم", shared!.getString("a").toString()),
                buildText("الإيميل", shared!.getString("b").toString()),
                buildText("رقم الهاتف", shared!.getString("g").toString()),
                buildText("وقت البدء", shared!.get("h").toString()),
                buildText("وقت الانتهاء", shared!.getString("i").toString()),
                buildText("العنوان", shared!.getString("f").toString()),
              ],
            ),
          ),
        ),
      );
    }
    return Container();
  }

  // دالة لعرض البيانات باستخدام Text
  Widget buildText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label, // العنوان (الاسم، الإيميل، إلخ)
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          SizedBox(height: 8.0), // مسافة بين العنوان والقيمة
          Text(
            value, // القيمة (البيانات المعروضة)
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
