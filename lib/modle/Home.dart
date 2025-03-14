import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:triaq/main.dart';
import 'package:triaq/modle/Sections/Analyst.dart';
import 'package:triaq/modle/Sections/pharma.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triaq/modle/Sections/doctor.dart';
import 'package:flutter/widgets.dart';
import 'package:triaq/modle/Sections/xray.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _hoState();
}

class _hoState extends State<Homepage> {
   static List<String> image = [
    'photo/page1.jpg',
    'photo/page2.jpg',
    'photo/page3.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    if(shared!.getString("spec")== "aa"){}
    return Scaffold(

      appBar: AppBar(
        elevation: 40,
        title: const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "صحتك تهمنا",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        width: 500,
        height: 800,
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: 3,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                var imageUrl = image[itemIndex];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(imageUrl),
                );
              },
              options: CarouselOptions(
                height: 300,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 2500),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                onPageChanged: (index, reason) {},
                scrollDirection: Axis.horizontal,
              ),
            ),
            Container(
                height: 160,
                width: 500,
                child: Row(
                  children: [

                    InkWell(onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => doctor()));
                    },
                      child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // الصورة مع التعتيم
                            Container(
                              width: 180,
                              margin: EdgeInsets.only(left: 10, right: 10),
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.5),
                                    // تعتيم الصورة (التعتيم الأسود)
                                    BlendMode
                                        .darken, // طريقة المزج التي تؤدي إلى التعتيم
                                  ),
                                  child: Image.asset(
                                    "photo/page6.jpg",
                                    // تأكد من أن الصورة موجودة في المسار الصحيح
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),

                            // النص مع الظل
                            const Text(
                              "عيادات",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                    ),

                    InkWell(onTap: () {
                      shared?.setString("rat", "pharmatic");

                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => pharma()));
                    },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // الصورة مع التعتيم
                          Container(
                            width: 180,
                            margin: EdgeInsets.only(left: 10, right: 10),
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.5),
                                  // تعتيم الصورة (التعتيم الأسود)
                                  BlendMode
                                      .darken, // طريقة المزج التي تؤدي إلى التعتيم
                                ),
                                child: Image.asset(
                                  "photo/page4.jpg",
                                  // تأكد من أن الصورة موجودة في المسار الصحيح
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          // النص مع الظل
                          const Text(
                            "صيدليات",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
            Container(
                height: 160,
                width: 500,
                child: Row(
                  children: [
                    InkWell(onTap: (){
                      shared?.setString("rat", "Analyst");
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Analyst()));
                    },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // الصورة مع التعتيم
                          Container(
                            width: 180,
                            margin: EdgeInsets.only(left: 10, right: 10),
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.5),
                                  // تعتيم الصورة (التعتيم الأسود)
                                  BlendMode
                                      .darken, // طريقة المزج التي تؤدي إلى التعتيم
                                ),
                                child: Image.asset(
                                  "photo/page5.jpg",
                                  // تأكد من أن الصورة موجودة في المسار الصحيح
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          // النص مع الظل
                          const Text(
                            "تحاليل",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(onTap: (){
                      shared?.setString("rat", "radiology");
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => xray()));},
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // الصورة مع التعتيم
                          Container(
                            width: 180,
                            margin: EdgeInsets.only(left: 10, right: 10),
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.5),
                                  // تعتيم الصورة (التعتيم الأسود)
                                  BlendMode
                                      .darken, // طريقة المزج التي تؤدي إلى التعتيم
                                ),
                                child: Image.asset(
                                  "photo/page7.jpg",
                                  // تأكد من أن الصورة موجودة في المسار الصحيح
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          // النص مع الظل
                          const Text(
                            "اشعة",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
