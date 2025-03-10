import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:triaq/stst.dart';
import 'modle/Home.dart';
import 'modle/Sections/pharma.dart';
import 'modle/component/notification.dart';
import 'modle/component/rate.dart';
import 'modle/homepage.dart';
import 'modle/sign/Login/login_analyst.dart';
import 'modle/sign/Login/login.dart';
import 'modle/sign/select.dart';
import 'modle/sign/time.dart';

SharedPreferences? shared;
var box;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  shared = await SharedPreferences.getInstance();
  await Hive.initFlutter();
   box= await Hive.openBox<Map>("mybox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        supportedLocales: [
          // الإنجليزية
          Locale('ar', 'SA'),
        ],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: Locale('ar', 'SA'),
        home: notification());
  }
}
// shared?.getInt("select") == 1 ? time() :