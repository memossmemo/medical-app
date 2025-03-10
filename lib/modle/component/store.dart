import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class store extends StatefulWidget {
  const store({super.key});

  @override
  State<store> createState() => _storeState();
}

class _storeState extends State<store> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "قيد التنفيذ",
            style: TextStyle(
                color: Colors.blue, fontSize: 40, fontWeight: FontWeight.bold),
          )
        ],
      )),
    );
  }
}
