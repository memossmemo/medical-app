import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:triaq/main.dart';
import 'package:triaq/modle/component/sel.dart';
import 'package:triaq/view/variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../My Wedgit/custom_Text.dart';
import 'package:http/http.dart' as http;

import '../../component/pharm.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Future<void> saveData(String newkay, String newvalue) async {
  //   // استدعاء الصندوق
  //   Map<String, String> current =
  //       Map<String, String>.from(box.get('nn', defaultValue: {}) ?? {});
  //   current[newkay] = newvalue;
  //   await box.put("data", current);
  //   print(curr ent.length);
  // }

  // Map<String, String> get() {
  //   print(Map<String, String>.from(box.get("data", defaultValue: {}) ?? {}));
  //   return Map<String, String>.from(box.get("data", defaultValue: {}) ?? {});
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   print(shared?.getString("spec"));
  // }

  bool isPasswordValid(String password) {
    // التعبير العادي لدعم الأحرف العربية فقط مع الأرقام والرموز
    RegExp regExp = RegExp(r'^(?=.*[A-Z])' // At least one uppercase letter
        r'(?=.*[a-z])' // At least one lowercase letter
        r'(?=.*\d)' // At least one digit
        r'(?=.*[!@#\$%\^&\*\(\)_\+\-=\[\]\{\};:\'
        r'",<>\./?\\|`~])'
        r'.{8,}$' // Minimum length of 8 characters
        );
    return regExp.hasMatch(password);
  }

  bool isEmailValid(String email) {
    // تعبير منتظم للتحقق من صحة البريد الإلكتروني
    RegExp regExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regExp.hasMatch(email);
  }

  variables vare = variables();
  TextEditingController login_email = TextEditingController();
  TextEditingController login_password = TextEditingController();

  Future<void> signin() async {
    // The URL of your API
    final url = Uri.parse(
        'https://pharma-manager-copy-2.onrender.com/api/${shared?.getString("spec")}/signin${shared?.getString("spec")}');

    // Prepare the request body
    final body = {
      'email': login_email.text,
      'password': login_password.text,
    };

    // Make the POST request
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );
      print(body);
      // Handle the response
      if (response.statusCode == 200) {
        print(response.statusCode);
        // var q =shared?.setInt("int", shared!.getInt("int")!+1);
        final data = json.decode(response.body);

        shared?.setString("a", data["user"]['fullName']);
        shared?.setString("b", data["user"]['email']);
        shared?.setString("id_spec", data["user"]['_id']);
        shared?.setString("c", data["user"]['password']);
        shared?.setString("d", data["user"]['city']);
        shared?.setString("e", data["user"]['region']);
        shared?.setString("f", data["user"]['address']);
        shared?.setString("g", data["user"]['phone']);
        shared?.setString("h", data["user"]['StartJob'].toString());
        shared?.setString("i", data["user"]['EndJob']);
        shared?.setString("token_spec", data['token']);
        shared?.setString("id_spec", data["user"]['_id']);

        //   Map<String, String> storedMap =
        //       Map<String, String>.from(box.get('data', defaultValue: {}));
        //   if (!storedMap.containsValue(data["user"]["_id"])) {
        //     await saveData("${storedMap.length + 1}", data["user"]["_id"]);
        //   }
        //   print(response.statusCode);
        //   await get();
      }
      // // shared!.remove("email_pharm_embty");
      // // shared!.remove("email_pharm");
      // // shared!.remove("password_pharm_empty");
      // // shared!.remove("password_pharm");

      if (response.statusCode == 403) {
        await shared?.setString("email_embty", "no");
      }
      if (response.statusCode == 404) {
        await shared?.setString("email", "no");
      }
      if (response.statusCode == 400) {
        await shared?.setString("password_empty", "no");
      }
      if (response.statusCode == 401) {
        await shared?.setString("password", "no");
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        await shared?.setString("something", "something error");
      }
    } catch (e) {
      print('Error: $e');
      // Handle network or other errors
    }
  }

  void showDialogError() {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'إدخال خاطئ',
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        desc: 'الرجاء إعادة المحاولة',
        btnOkText: "موافق",
        btnOkOnPress: () {},
        btnOkColor: Colors.blue)
      ..show();
  }

  GlobalKey<FormState> formm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(" wwتسجيل الدخول"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formm,
          child: Column(
            children: [
              Container(
                width: 300,
                height: 300,
                child: Image.asset(fit: BoxFit.cover, "photo/pharm2.png"),
              ),
              Container(
                height: 30,
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 80),
                  width: 300,
                  height: 70,
                  child: Custom_Text(
                    validator: (val) {
                      if (shared?.getString("email_embty") == "no") {
                        shared?.remove("email_embty");
                        return "الحقل مطلوب";
                      }
                      if (shared?.getString("email") == "no") {
                        shared?.remove("email");
                        return "الايميل غير موجود ";
                      }
                      return null;
                    },
                    labelText: 'الايميل',
                    controller: login_email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ),
              Container(
                height: 40,
              ),
              Center(
                child: Container(
                  width: 300,
                  height: 70,
                  child: Custom_Text(
                    validator: (val) {
                      if (shared?.getString("password_empty") == "no") {
                        shared?.remove("password_empty");
                        return "الحقل مطلوب";
                      } else if (shared?.getString("password") == "no") {
                        shared?.remove("password");
                        return "كلمة المرور غير صحيحة";
                      }

                      return null;
                    },
                    labelText: 'كلمة المرور',
                    controller: login_password,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
              ),
              Container(
                height: 60,
              ),
              ElevatedButton(
                onPressed: () async {
                  await signin();
                  if (!formm.currentState!.validate()) {
                    showDialogError();
                  } else {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => sel()));
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  // لون النص عند الضغط
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 25.0),
                  // المسافة حول النص
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30.0), // الزوايا المدورة
                  ),
                  elevation: 5, // الظل لإعطاء تأثير العمق
                ),
                child: Text(
                  'تسجيل',
                  style: TextStyle(
                    fontSize: 18.0, // حجم النص
                    fontWeight: FontWeight.bold, // جعل النص غامق
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
