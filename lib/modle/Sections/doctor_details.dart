import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class doc extends StatefulWidget {
  const doc({super.key});

  @override
  State<doc> createState() => _doctorState();
}

class _doctorState extends State<doc> {
  bool _expanded = false;

  // التبديل بين حالة التوسيع

  final List<String> daysOfWeek = [
    'الأحد',
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت'
  ];

  // متغير لتخزين فهرس الكارد الذي تم النقر عليه
  int _expandedIndex = -1;

  // دالة لتبديل حالة التوسيع للكارد المحدد
  void _toggleExpand(int index) {
    setState(() {
      if (_expandedIndex == index) {
        // إذا تم النقر على نفس الكارد مرة أخرى، نقوم بإغلاقه
        _expandedIndex = -1;
      } else {
        // توسيع الكارد الذي تم النقر عليه
        _expandedIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("بيانات الدكتور"),
        actions: [],
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.all(60),
                        child: Icon(Icons.accessibility_sharp)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20, bottom: 10),
                              child: Text(
                                "دكتور احمد حلمي",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),

                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow[800],
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow[800],
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow[800],
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow[800],
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow[800],
                            ),
                            Container(
                              child: Text(
                                "( 7 زوار )",
                                style: TextStyle(color: Colors.grey[600]),
                              ),

                            )
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              "استشاري الجلدية و التناسلية",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w300),
                            ))
                      ],
                    )
                  ],
                ),
                width: 1000,
                height: 150,
              ),
              Container(
                width: 1000,
                height: 15,
                color: Colors.grey[200],
              ),
              Container(
                height: 50,
                width: 1000,
                margin: EdgeInsets.only(),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Icon(
                        Icons.document_scanner,
                        color: Colors.blue,
                      ),
                    ),
                    Text("جلدية متخصص في امراض تناسلية")
                  ],
                ),
              ),
              Container(
                height: 50,
                width: 1000,
                margin: EdgeInsets.only(),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Icon(
                        Icons.location_on,
                        color: Colors.blue,
                      ),
                    ),
                    Text("المنصورة : شارع النحلة")
                  ],
                ),
              ),
              Container(
                height: 40,
                width: 1000,
                margin: EdgeInsets.only(),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Icon(
                        Icons.money_off_rounded,
                        color: Colors.blue,
                      ),
                    ),
                    Text("سعر الكشف : 200 جنيه")
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "اختر ميعاد حجزك",
                    style: TextStyle(fontWeight: FontWeight.w900),
                  )),
              Container(
                margin: EdgeInsets.only(top: 10, right: 30, left: 30),
                width: 1000,
                height: 250,
                child: Container(
                    child: ListView.builder(
                  scrollDirection: Axis.horizontal, // التمرير أفقيًا
                  itemCount: daysOfWeek.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () => _toggleExpand(index),
                        // عند النقر على الكارد
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          // مدة الأنيميشن
                          width: _expandedIndex == index ? 170 : 100,
                          // إذا كان الكارد موسعًا، زيادة العرض
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(40)),

                                alignment: Alignment.center,
                                height: 60,
                                // ارتفاع القسم الأول (يحتوي على أيام الأسبوع)
                                child: Text(
                                  daysOfWeek[index],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              if (_expandedIndex == index) ...[
                                // فقط الكارد الذي تم النقر عليه يتم توسيعه
                                // قسم الساعات
                                Container(
                                  width: 120,
                                  height: 120,
                                  child: ListView(
                                    padding: EdgeInsets.all(5),
                                    children: [
                                      Container(alignment: Alignment.center,
                                          decoration: BoxDecoration(color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Text("10ص الى 6م")),
                                      Container(alignment: Alignment.center,margin: EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(color: Colors.grey[300],
                                              borderRadius:
                                              BorderRadius.circular(30)),
                                          child: Text("10ص الى 6م")),
                                      Container(alignment: Alignment.center,margin: EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(color: Colors.grey[300],
                                              borderRadius:
                                              BorderRadius.circular(30)),
                                          child: Text("10ص الى 6م")),
                                      Container(alignment: Alignment.center,margin: EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(color: Colors.grey[300],
                                              borderRadius:
                                              BorderRadius.circular(30)),
                                          child: Text("10ص الى 6م")),
                                      Container(alignment: Alignment.center,margin: EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(color: Colors.grey[300],
                                              borderRadius:
                                              BorderRadius.circular(30)),
                                          child: Text("10ص الى 6م")),



                                    ],
                                  ),
                                ),
                                // زر الحجز
                                InkWell(
                                  onTap: () {
                                    print("dsdsdsdsds");
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.greenAccent,
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    height: 50,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "أحجز",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ]
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )),
              )
            ],
          )
        ],
      ),
    );
  }
}
