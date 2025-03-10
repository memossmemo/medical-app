import 'package:triaq/modle/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Notifications.dart';
import 'Setting.dart';
import 'location.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  static int selectedIndex = 1;
  static const List<Widget> _widgetOptions = <Widget>[
    location(),
    Homepage(),
    Notifications(),
    SettingsScreen(),



  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  void updateSelectedIndex(int newIndex) {
    setState(() {
      selectedIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'الموقع',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'الاشعارات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'الاعدادات',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
