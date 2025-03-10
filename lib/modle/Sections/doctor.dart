import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class doctor extends StatefulWidget {
  const doctor({super.key});

  @override
  State<doctor> createState() => _doctorState();
}

class _doctorState extends State<doctor> {
  Text s = Text(
    "200 جنيه",
    style: TextStyle(color: Colors.green),
  );
  String? selectedSpecialization; // لتخزين الاختصاص المحدد

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(' العيادات'),
          leading: Column(
            children: [
              Text('الاقسام', style: TextStyle()),
              Icon(Icons.arrow_back),
            ],
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded))
          ],
        ),
        body: Container(
          margin: EdgeInsets.only(top: 20),
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[300],
          child: Stack( 
            children: [
              Positioned(
                  right: 20,
                  top: 20,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(60)),
                  )),
              Positioned(
                top: 30,
                left: 120,
                child: Container(
                  child: Text(
                    "دكتور احمد حلمي",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              Positioned(
                left: 90,
                top: 70,
                child: Row(
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
              ),
              Positioned(
                left: 60,
                top: 90,
                child: Container(
                    width: 200,
                    height: 50,
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      maxLines: 2,
                      "استشاري الجلدية و التناسلية",
                      softWrap: true,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    )),
              ),
              Positioned(
                  right: 20,
                  top: 150,
                  child: Container(
                      child: Row(
                    children: [
                      Icon(
                        Icons.monetization_on_rounded,
                        color: Colors.blue,
                        size: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: 15, color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'سعر الكشف: ', // النص الأول باللون الأسود
                              ),
                              TextSpan(
                                text: '200 جنيه', // النص الذي نريد تغييره
                                style: TextStyle(
                                    color: Colors.green), // النص بلون أخضر
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))),
              Positioned(
                top: 180,
                left: 20,
                child: MaterialButton(
                  elevation: 10,
                  color: Colors.green,
                  onPressed: () {},
                  child: Text(
                    "احجز الان",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Positioned(
                  right: 20,
                  top: 180,
                  child: Container(
                      padding: EdgeInsets.only(bottom: 20),
                      width: 270,
                      height: 90,
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.blue,
                            size: 20,
                          ),
                          Container(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              "دمباط/الزرقا/جانب برج خليفة عند اول دخلة على الشمال قرب الحديقة ",
                              softWrap: true,
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ))),
            ],
          ),
        ));
  }
}
