import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class variables {
  static int index=0;

  static Map<String,String> pharm_ids = {};



  static TextEditingController startTimeController = TextEditingController();
  static TextEditingController endTimeController = TextEditingController();
  TextEditingController casesPerHourController = TextEditingController();
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

///////////////////////////////////////////////////////////////////////////////

  ////////////////////////////////////////////////////////////////////////

  static TextEditingController seek_name = TextEditingController();
  static TextEditingController seek_number = TextEditingController();

  /////////////////////////////////////////////////////////////////////////////////////

  static TextEditingController name = TextEditingController();
  static TextEditingController number = TextEditingController();
  static TextEditingController email = TextEditingController();
  static TextEditingController password = TextEditingController();
  static TextEditingController address = TextEditingController();

  ////////////////////////////////////////////////////////////////////////////////////
  final Map<String, List<String>> locations = {
    'محافظة دمياط': [
      "مدينة الزرقا",
      "مدينة فارسكور",
      "مدينة كفر سعد",
      "مدينة دمياط الجديدة",
      "مدينة دمياط"
    ],
    'محافظة الدقهلية': [
      ' مدينة دكرنس',
      'مدينة شربين',
      'مدينة المنصورة',
      'مدينة منية النصر'
    ],
    /////////////////////////////////////////
  };
  final Map<String, List<String>> doctor = {
    "أسنان":[],
    "مراكز تجميل":[],
    "جلدية و تناسلية":[],
    "باطنه":[],
    "قلب و أوعية دموية":[],
    "نساء و توليد":[],
    "أنف و أذن و حنجرة":[],
    "عظام":[],
    "مخ و أعصاب":[],
    "عيون":[],
    "مسالك بولية":[],
    "جهاز هضمي و كبد":[],
    "كلى":[],
    "أمراض دم":[],
    "أورام":[],
    "علاج طبيعي":[],
    "الطب النفسي":[],
    "تخسيس و تغذية":[],
    "نطق و تخاطب":[],
    "جراحة : ":[
      "جراحة عامة",
      "جراحة تجميل ",
      "جراحة أطفال",
      "جراحة أوعية دموية",
      "جراحة قلب و صدر",
      "جراحة مخ و اعصاب و عمود فقري",
      "جراحة اورام",],

    /////////////////////////////////////////
  };
  // static List<String> sergn = [
  //   "جراحة عامة",
  //   "جراحة تجميل ",
  //   "جراحة أطفال",
  //   "جراحة أوعية دموية",
  //   "جراحة قلب و صدر",
  //   "جراحة مخ و اعصاب و عمود فقري",
  //   "جراحة اورام",
  //   "",
  // ];
  // static List<String> doctor = [
  //   "أسنان",
  //   "مراكز تجميل",
  //   "جلدية و تناسلية",
  //   "باطنه",
  //   "قلب و أوعية دموية",
  //   "نساء و توليد",
  //   "أنف و أذن و حنجرة",
  //   "عظام",
  //   "مخ و أعصاب",
  //   "عيون",
  //   "مسالك بولية",
  //   "جهاز هضمي و كبد",
  //   "كلى",
  //   "أمراض دم",
  //   "أورام",
  //   "علاج طبيعي",
  //   "الطب النفسي",
  //   "تخسيس و تغذية",
  //   "نطق و تخاطب",
  //   "جراحة",
  // ];

////////////////////////////////////////////////////
  static String? selectedGovernorate; // المحافظة المختارة
  static String? selectedRegion; // المنطقة المختارة
  static String? spec; // المحافظة المختارة
  static String? sergn1;
}
