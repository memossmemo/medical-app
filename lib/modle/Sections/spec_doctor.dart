import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DoctorSpecialtyPage extends StatelessWidget {
  // إنشاء Map يحتوي على اختصاص الطبيب والأيقونة الخاصة به
  final Map<String, String> doctorSpecialties = {
    "أسنان": "photo/spec1.ico",
    "مراكز تجميل": "photo/spec2.ico",
    "جلدية و تناسلية": "photo/s1.ico",
    "باطنه": "photo/spec20.ico",
    "قلب و أوعية دموية": "photo/spec3.ico",
    "نساء و توليد": "photo/spec25.ico",
    "أنف و أذن و حنجرة": "photo/s2.ico",
    "عظام": "photo/spec5.ico",
    "مخ و أعصاب": "photo/spec7.ico",
    "عيون": "photo/spec6.ico",
    "مسالك بولية": "photo/spec11.ico",
    "جهاز هضمي و كبد": "photo/spec8.ico",
    "كلى": "photo/spec9.ico",
    "أمراض دم": "photo/spec10.ico",
    "أورام": "photo/spec21.ico",
    "تخسيس و تغذية": "photo/spec12.ico",
    "الطب النفسي": "photo/spec19.ico",
    "نطق و تخاطب": "photo/spec13.ico",
    "علاج طبيعي": "photo/spec23.ico",
    "جراحة تجميل": "photo/spec14.ico",
    "جراحة قلب و صدر": "photo/spec15.ico",
    "جراحة اورام": "photo/spec16.ico",
    "جراحة مخ و اعصاب و عمود فقري": "photo/spec17.ico",
    "جراحة أطفال": "photo/spec18.ico",
    "جراحة عامة": "photo/spec24.ico",
    "جراحة أوعية دموية": "photo/spec26.ico"

  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('العيادات'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded))
        ],
      ),
      body: ListView.builder(
        itemCount: doctorSpecialties.length,
        itemBuilder: (context, index) {
          // الحصول على الاختصاص والأيقونة
          String specialty = doctorSpecialties.keys.elementAt(index);
          String icon = doctorSpecialties.values.elementAt(index);

          return Card(
            margin: EdgeInsets.only(top: 1),
            child: ListTile(
              leading: Container(
                height: 25,
                width: 25,
                child: Image.asset(
                  icon,
                ),
              ),
              title: Text(specialty, style: TextStyle(fontSize: 18)),
              onTap: () {
                // إضافة الإجراءات عند الضغط على الاختصاص
                print("تم الضغط على: $specialty");
              },
            ),
          );
        },
      ),
    );
  }
}
