import 'package:triaq/main.dart';
import 'package:triaq/modle/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triaq/modle/sign/spec.dart';

class select extends StatefulWidget {
  const select({super.key});

  @override
  State<select> createState() => _selectState();
}

class _selectState extends State<select> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 150),
            child: const Text(
              "الرجاء اختيار التخصص ",
              style: TextStyle(fontSize: 30),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 150, ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async {
                      await shared?.setString("spec", "Doctor");
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Spec()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              spreadRadius: 4,
                              blurRadius: 10,
                              offset:
                                  Offset(4, 4), // الإزاحة الأفقية والرأسية للظل
                            ),
                          ],
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      alignment: Alignment.center,
                      width: 150,
                      height: 100,
                      child: const Text(
                        "دكتور",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Container(width: 10,),
                  InkWell(
                    onTap: () async {
                      await shared?.setString("spec", "Pharmatic");
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Spec()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 40),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              spreadRadius: 4,
                              blurRadius: 10,
                              offset:
                                  Offset(4, 4), // الإزاحة الأفقية والرأسية للظل
                            ),
                          ],
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      alignment: Alignment.center,
                      width: 150,
                      height: 100,
                      child: const Text(
                        "صيدلية",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              )),
          Container(
            margin: EdgeInsets.only(top: 50,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () async {
                    await shared?.setString("spec", "Analyst");
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Spec()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            spreadRadius: 4,
                            blurRadius: 10,
                            offset:
                                Offset(4, 4), // الإزاحة الأفقية والرأسية للظل
                          ),
                        ],
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    alignment: Alignment.center,
                    width: 150,
                    height: 100,
                    child: const Text(
                      "مركز تحاليل",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(width: 20,),
                InkWell(
                  onTap: () async {
                    await shared?.setString("spec", "Radiology");
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Spec()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 40),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            spreadRadius: 4,
                            blurRadius: 10,
                            offset:
                                Offset(4, 4), // الإزاحة الأفقية والرأسية للظل
                          ),
                        ],
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    alignment: Alignment.center,
                    width: 150,
                    height: 100,
                    child: const Text(
                      "مركز أشعة",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
