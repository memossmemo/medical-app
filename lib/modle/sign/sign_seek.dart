import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:triaq/main.dart';
import 'package:triaq/modle/location.dart';
import 'package:triaq/view/Api/seek_Api.dart';
import 'package:triaq/view/variables.dart';
import 'package:flutter/material.dart';

import '../homepage.dart';

class Sign_seek extends StatefulWidget {
  const Sign_seek({super.key});

  @override
  State<Sign_seek> createState() => _Sign_seekState();
}

class _Sign_seekState extends State<Sign_seek> {
  bool isArabicAlphabet(String input) {
    // تعبير منتظم للتحقق من أن النص يحتوي فقط على الحروف العربية والمسافات
    final regExp = RegExp(r'^[\u0600-\u06FF\s]+$');
    return regExp.hasMatch(input);
  }
  void showDialogError() {
    AwesomeDialog(

        context: context,
        dialogType: DialogType.error,

        animType: AnimType.rightSlide,
        title: 'إدخال خاطئ',
        titleTextStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
        desc: 'الرجاء إعادة المحاولة',
    btnOkText: "موافق",
    btnOkOnPress: () {},
      btnOkColor: Colors.blue
    )..show();

  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      // عدم السماح بغلق الـ Dialog عند الضغط في أي مكان خارج الـ Dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green, // إشارة صح باللون الأخضر
                size: 50.0, // حجم الأيقونة
              ),
              SizedBox(height: 10),
              Text(
                'تسجيل ناجح',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text('تم التسجيل بنجاح!'),
        );
      },
    );

    // استخدام Future.delayed للتأخير قبل الانتقال إلى الصفحة التالية
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context); // غلق الـ Dialog
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => location()), // الانتقال إلى الصفحة التالية
      );
    });
  }

  variables vare = variables();
  seek_Api api = seek_Api();
  GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Center(
            child: Form(
          key: form,
          child: Column(
            children: [
              Container(
                height: 100,
              ),
              Container(
                  child: Text(
                "الرجاء اكمال معلومات التسجيل",
                style: TextStyle(fontSize: 20),
              )),
              Container(
                height: 100,
              ),
              Container(
                width: 300,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    validator: (val){
                      if(!isArabicAlphabet(val!) || val.isEmpty)
                        return "الرجاء التاكد من الاسم";
                      return null;
                    },
                    controller: variables.seek_name,
                    decoration: InputDecoration(
                        labelText: "اسم المريض",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
              ),
              Container(
                height: 70,
              ),
              Container(
                width: 300,
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: TextFormField(
                    validator: (val){
                      if(val!.length < 10 )
                        return "الرجاء التاكد من الرقم";
                      return null;
                    },

                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    textAlign: TextAlign.right,
                    controller: variables.seek_number,
                    decoration: InputDecoration(
                        prefixText: "+20",
                        labelText: "رقم الهاتف",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
              ),
              Container(
                height: 50,
              ),
              MaterialButton(
                onPressed: () async {
                  if (!form.currentState!.validate()) {
                    showDialogError();
                  } else {
                   await api.register_seek();
                    _showSuccessDialog(context);
                   // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder) => Home()));

                  }
                },
                child: Text("تسجيل"),
                color: Colors.blue,
              )
            ],
          ),
        )),
      ),
    );
  }
}
