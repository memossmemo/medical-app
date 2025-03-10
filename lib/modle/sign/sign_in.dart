import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:triaq/modle/sign/select.dart';
import 'package:triaq/modle/sign/sign_seek.dart';
import 'package:triaq/modle/sign/spec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Sign_in extends StatefulWidget {
  const Sign_in({super.key});

  @override
  State<Sign_in> createState() => _Sign_inState();
}

class _Sign_inState extends State<Sign_in> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1000,
        height: 1000,
        child: Stack(
          children: [
            Container(
              width: 1000,
              height: 1000,
              child: Image.asset(
                "photo/page123.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                right: 40,
                top: 100,
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      "اهلا و سهلا بك في تطبيقنا ",
                      textStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      speed: Duration(milliseconds: 100),
                    ),
                  ],
                  isRepeatingAnimation: false,
                )),
            Positioned(
              right: 50,
              top: 200,
              child: Text("الدخول بصفة :",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  )),
            ),
            Positioned(
              right: 130,
              top: 280,
              child: InkWell(onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (builder) => Sign_seek()));
              },
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius:1,
                          blurRadius: 10,
                          offset:
                          Offset(4, 4), // الإزاحة الأفقية والرأسية للظل
                        ),
                      ],
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.center,
                  width: 150,
                  height: 100,
                  child: Text(
                    "مريض",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blue),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 130,
              top: 400,
              child: InkWell(onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (builder) => select()));
              },
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset:
                          Offset(4, 4), // الإزاحة الأفقية والرأسية للظل
                        ),
                      ],
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(30)),
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 60),
                  width: 150,
                  height: 100,
                  child: Text(
                    "متخصص",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blue),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 696,
              left: 60,
              child: IconButton(onPressed: () {}, icon: Icon(Icons.language)),
            ),
            Positioned(top: 710, left: 110, child: Text("اللغة"))
          ],
        ),
      ),
    );
  }
}
