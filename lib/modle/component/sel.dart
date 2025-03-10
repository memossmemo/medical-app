import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triaq/modle/component/pharm.dart';
import 'package:triaq/modle/component/seting.dart';
import 'package:triaq/modle/component/store.dart';

import 'notification.dart';

class sel extends StatefulWidget {
  const sel({super.key});

  @override
  State<sel> createState() => _selState();
}


class _selState extends State<sel> {
  int _selectedIndex = 0;

  // قائمة لتغيير محتوى الشاشة حسب الخيار المحدد
  static const List<Widget> _widgetOptions = <Widget>[
    pharm(),
    notification(),
    store(),
    seting(),



  ];

  // دالة لتغيير الخيار المحدد
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex), // تغيير الشاشة بناءً على الاختيار
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:Colors.blue ,

        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(backgroundColor: Colors.blue,
            icon: Icon(Icons.account_circle),
            label: 'الملف الشخصي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: ' الاشعارات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_grocery_store_rounded),
            label: ' المتجر',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'الاعدادات',
          ),
        ],
      ),);
  }
}
