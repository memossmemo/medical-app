import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("الطلبات"),
      ),
      // body: ListView.builder(
      //   itemCount: snapshot.data!["requests"].length, // عدد المرضى في القائمة
      //   itemBuilder: (context, index) {
      //     shared?.setString("request_id", snapshot.data!["requests"][index]["_id"]);
      //     // جلب بيانات المريض الحالي
      //
      //     return Padding(
      //       padding: const EdgeInsets.symmetric(vertical: 10),
      //       child: Stack(
      //         children: [
      //           // ✅ الطبقة الخلفية: الكارد
      //           Container(
      //             width: double.infinity,
      //             height: 150,
      //             margin: EdgeInsets.symmetric(horizontal: 10),
      //             decoration: BoxDecoration(
      //               color: Colors.white,
      //               borderRadius: BorderRadius.circular(15),
      //               boxShadow: [
      //                 BoxShadow(
      //                   color: Colors.black26,
      //                   blurRadius: 8,
      //                   spreadRadius: 2,
      //                   offset: Offset(3, 3),
      //                 ),
      //               ],
      //             ),
      //           ),
      //
      //           // ✅ الطبقة العلوية: المحتوى
      //           Positioned(
      //             top: 15,
      //             left: 20,
      //             right: 110,
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text(
      //                   snapshot.data!["requests"][index]["patientId"]["fullName"],
      //                   style: TextStyle(
      //                     fontSize: 20,
      //                     fontWeight: FontWeight.bold,
      //                     color: Colors.black87,
      //                   ),
      //                 ),
      //                 SizedBox(height: 8),
      //                 Row(
      //                   children: [
      //                     Icon(Icons.date_range, color: Colors.blueAccent, size: 18),
      //                     SizedBox(width: 5),
      //                     Text(
      //                       snapshot.data!["requests"][index]["dateFormatted"],
      //                       style: TextStyle(fontSize: 16, color: Colors.grey[700]),
      //                     ),
      //                   ],
      //                 ),
      //                 SizedBox(height: 8),
      //                 Row(
      //                   children: [
      //                     Icon(Icons.access_time, color: Colors.green, size: 18),
      //                     SizedBox(width: 5),
      //                     Text(
      //                       snapshot.data!["requests"][index]["timeFormatted"],
      //                       style: TextStyle(fontSize: 16, color: Colors.grey[700]),
      //                     ),
      //                   ],
      //                 ),
      //               ],
      //             ),
      //           ),
      //
      //           // ✅ صورة على اليمين
      //           Positioned(
      //             top: 15,
      //             right: 15,
      //             child: GestureDetector(
      //               onTap: () {
      //
      //               },
      //               child: ClipRRect(
      //                 borderRadius: BorderRadius.circular(12),
      //                 child: Image.network(
      //                   snapshot.data!["requests"][index]["imageUrl"],
      //                   width: 90,
      //                   height: 90,
      //                   fit: BoxFit.cover,
      //                 ),
      //               ),
      //             ),
      //           ),
      //
      //           // ✅ زر "نعم"
      //           Positioned(
      //             bottom: 10,
      //             left: 15,
      //             child: ElevatedButton(
      //               onPressed: () {
      //
      //               },
      //               style: ElevatedButton.styleFrom(
      //                 backgroundColor: Colors.green,
      //                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      //                 shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(30),
      //                 ),
      //               ),
      //               child: Text(
      //                 'نعم',
      //                 style: TextStyle(
      //                   fontSize: 16,
      //                   fontWeight: FontWeight.bold,
      //                   color: Colors.white,
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     );
      //   },
      // )
    );
  }
}
