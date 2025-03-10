import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:triaq/main.dart';
import 'package:triaq/modle/sign/time.dart';
import 'package:triaq/view/variables.dart';
import 'package:flutter/material.dart';
import '../../mm.dart';
import '../../view/Api/spec_Api.dart';
import '../My Wedgit/custom_Text.dart';

class Spec extends StatefulWidget {
  const Spec({super.key});

  @override
  State<Spec> createState() => _SpecState();
}

class _SpecState extends State<Spec> {
  bool? ppo = false;

  void load() {
    setState(() {
      ppo = shared?.getBool("emailused");
    });
  }

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

  bool isArabicAlphabet(String input) {
    // التعبير المنتظم للتحقق من أن النص يحتوي فقط على حروف أبجدية عربية
    final regExp = RegExp(r'^[\u0600-\u06FF\s]+$');
    return regExp.hasMatch(input);
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

  variables vare = variables();
  spec_Api v = spec_Api();

  // Function to select start time
  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: vare.selectedStartTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != vare.selectedStartTime) {
      setState(() {
        vare.selectedStartTime = picked;
        variables.startTimeController.text =
            vare.selectedStartTime!.format(context);
      });
    }
  }

  // Function to select end time
  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: vare.selectedEndTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != vare.selectedEndTime) {
      setState(() {
        vare.selectedEndTime = picked;
        variables.endTimeController.text =
            vare.selectedEndTime!.format(context);
      });
    }
  }

  //*************************************************************************************************************************************
  GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (shared?.getString("spec") == "Pharmatic") {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text("صيدلية"),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: form,
            child: Column(
              children: [
                Container(
                  height: 60,
                ),
                Center(
                  child: Container(
                      width: 300,
                      child: Custom_Text(
                        validator: (val) {
                          if (!isArabicAlphabet(val!) || val.isEmpty)
                            return "الرجاء التاكد من الاسم";
                          return null;
                        },
                        labelText: 'اسم الصيدلية',
                        controller: variables.name,
                        keyboardType: TextInputType.text,
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 170,
                      child: TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) return "الرجاء التاكد من الوقت";
                          return null;
                        },
                        controller: variables.startTimeController,
                        decoration: const InputDecoration(
                          labelText: 'وقت بدء العمل',
                          icon: Icon(Icons.access_time),
                        ),
                        readOnly: true,
                        onTap: () => _selectStartTime(context),
                      ),
                    ),
                    Container(
                      width: 170,
                      child: TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) return "الرجاء التاكد من الوقت";
                          return null;
                        },
                        controller: variables.endTimeController,
                        decoration: const InputDecoration(
                          labelText: 'وقت انتهاء العمل',
                          icon: Icon(Icons.access_time),
                        ),
                        readOnly: true,
                        onTap: () => _selectEndTime(context),
                      ),
                    )
                  ],
                ),
                Container(
                  height: 20,
                ),

                Center(
                  child: Container(
                      width: 300,
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: TextFormField(
                          validator: (val) {
                            if (val!.length < 10)
                              return "الرجاء التاكد من الرقم";
                            return null;
                          },
                          textAlign: TextAlign.right,
                          maxLength: 10,

                          // تحديد محاذاة النص
                          decoration: InputDecoration(
                            prefixText: "+20",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            labelText:
                                "رقم الهاتف", // تحديد النص الذي يظهر كـ "label"
                          ),
                          controller: variables.number,
                          // التحكم في النص المدخل
                          keyboardType: TextInputType.phone,
                          // تحديد نوع لوحة المفاتيح
                        ),
                      )),
                ),
                Container(
                  height: 20,
                ),
                Center(
                  child: Container(
                      width: 300,
                      child: Custom_Text(
                        validator: (val) {
                          load();
                          if (!isEmailValid(val!)) {
                            return "الرجاء التأكد من الايميل";
                          }
                          if (ppo == true) return "الأيميل مستخدم مسبقا";
                          return null;
                        },
                        labelText: 'البريد الالكتروني ',
                        controller: variables.email,
                        keyboardType: TextInputType.text,
                      )),
                ),
                Container(
                  height: 20,
                ),
                Center(
                  child: Container(
                      width: 300,
                      child: Custom_Text(
                        validator: (val) {
                          if (isPasswordValid(val!)) {
                            return null;
                          }

                          return "الرجاء التاكد من كلمة المرور";
                        },
                        labelText: 'كلمة المرور',
                        controller: variables.password,
                        keyboardType: TextInputType.visiblePassword,
                      )),
                ),
                Container(
                  height: 20,
                ),
                Center(
                  child: Container(
                      width: 300,
                      child: Custom_Text(
                        validator: (val) {
                          if (val!.length > 30 || val.isEmpty)
                            return "الرجاء التحقق من العنوان";
                          return null;
                        },
                        labelText: 'العنوان ب التفصيل',
                        controller: variables.address,
                        keyboardType: TextInputType.text,
                      )),
                ),
                Container(
                  height: 50,
                ),
                Container(
                  width: 200,
                  child: DropdownButtonFormField<String>(
                    value: variables.selectedGovernorate,
                    decoration: const InputDecoration(
                      labelText: 'اختيار المحافظة',
                      border: OutlineInputBorder(),
                    ),
                    items: vare.locations.keys.map((String governorate) {
                      return DropdownMenuItem<String>(
                        value: governorate,
                        child: Text(governorate),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'الرجاء اختيار خيار';
                      }
                      return null; // إذا كانت القيمة صحيحة، ارجع null
                    },
                    onChanged: (newValue) {
                      setState(() {
                        variables.selectedGovernorate = newValue;
                        variables.selectedRegion =
                            null; // إعادة تعيين المنطقة عند تغيير المحافظة
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),

                // اختيار المنطقة بناءً على المحافظة
                if (variables.selectedGovernorate != null)
                  Container(
                    width: 200,
                    child: DropdownButtonFormField<String>(
                      value: variables.selectedRegion,
                      decoration: const InputDecoration(
                        labelText: 'اختيار المدينة',
                        border: OutlineInputBorder(),
                      ),
                      items: vare.locations[variables.selectedGovernorate]!
                          .map((String region) {
                        return DropdownMenuItem<String>(
                          value: region,
                          child: Text(region),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'الرجاء اختيار خيار';
                        }
                        return null; // إذا كانت القيمة صحيحة، ارجع null
                      },
                      onChanged: (newValue) {
                        setState(() {
                          variables.selectedRegion = newValue;
                        });
                      },
                    ),
                  ),
                Container(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () async {
                    print("object");
                    await v.register_pharm();
                    print("jjjjjjjj");
                    if (!form.currentState!.validate()) {
                      showDialogError();
                    } else {
                      print("objectqqqqqqqqqqq");
                      shared?.setInt("select", 1);
                      shared?.setString("a", '${variables.name.text}');
                      shared?.setString("b", '${variables.email.text}');
                      shared?.setString("c", '${variables.password.text}');
                      shared?.setString(
                          "d", '${variables.selectedGovernorate}');
                      shared?.setString("e", '${variables.selectedRegion}');
                      shared?.setString("f", '${variables.address.text}');
                      shared?.setString("g", '${variables.number.text}');
                      shared?.setString(
                          "h", '${variables.startTimeController.text}');
                      shared?.setString(
                          "i", '${variables.endTimeController.text}');
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => time()),
                          );

                    }
                  },
                  child: Text("تسجيل"),
                  color: Colors.blue,
                )
                //*******************************************************pharma********************
              ],
            ),
          ),
        ),
      );
    }
    else if (shared?.getString("spec") == "Doctor") {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text("doctor"),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: form,
            child: Column(
              children: [
                Container(
                  height: 60,
                ),
                Center(
                  child: Container(
                      width: 300,
                      height: 50,
                      child: Custom_Text(
                        validator: (val) {
                          if (!isArabicAlphabet(val!) || val.isEmpty)
                            return "الرجاء التاكد من الاسم";
                          return null;
                        },
                        labelText: 'اسم الدكتور',
                        controller: variables.name,
                        keyboardType: TextInputType.text,
                      )),
                ),
                Container(
                  height: 20,
                ),
                MaterialButton(
                  color: Colors.grey[300],
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => mm()));
                  },
                  child: Text("اختيار مواعيد العمل"),
                ),
                Container(
                  width: 200,
                  child: TextFormField(
                    controller: vare.casesPerHourController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'عدد الحالات  في الساعة',
                      icon: Icon(Icons.medical_services),
                    ),
                  ),
                ),

                Container(
                  height: 20,
                ),

                Center(
                  child: Container(
                      width: 300,
                      height: 50,
                      child: Custom_Text(
                        validator: (val) {
                          if (val!.length < 10) return "الرجاء التاكد من الرقم";
                        },
                        labelText: 'رقم الهاتف',
                        controller: variables.number,
                        keyboardType: TextInputType.phone,
                      )),
                ),
                Container(
                  height: 20,
                ),
                Center(
                  child: Container(
                      width: 300,
                      height: 50,
                      child: Custom_Text(
                        validator: (val) {},
                        labelText: 'الايميل',
                        controller: variables.email,
                        keyboardType: TextInputType.emailAddress,
                      )),
                ),
                Container(
                  height: 20,
                ),
                Center(
                  child: Container(
                      width: 300,
                      height: 50,
                      child: Custom_Text(
                        validator: (val) {},
                        labelText: 'كلمة المرور',
                        controller: variables.password,
                        keyboardType: TextInputType.visiblePassword,
                      )),
                ),
                Container(
                  height: 20,
                ),
                Center(
                  child: Container(
                      width: 300,
                      child: Custom_Text(
                        validator: (val) {
                          if (val!.length > 30 || val.isEmpty)
                            return "الرجاء التحقق من العنوان";
                          return null;
                        },
                        labelText: 'العنوان ب التفصيل',
                        controller: variables.address,
                        keyboardType: TextInputType.text,
                      )),
                ),

                Container(
                  height: 20,
                ),
                Container(
                  width: 200,
                  child: DropdownButtonFormField<String>(
                    value: variables.spec,
                    decoration: const InputDecoration(
                      labelText: 'اختيار التخصص',
                      border: OutlineInputBorder(),
                    ),
                    items: vare.doctor.keys.map((String governorate) {
                      return DropdownMenuItem<String>(
                        value: governorate,
                        child: Text(governorate),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        variables.spec = newValue;
                        variables.sergn1 =
                            null; // إعادة تعيين المنطقة عند تغيير المحافظة
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),

                // اختيار المنطقة بناءً على المحافظة
                if (variables.spec == "جراحة : ")
                  Container(
                    width: 300,
                    child: DropdownButtonFormField<String>(
                      value: variables.sergn1,
                      decoration: const InputDecoration(
                        labelText: 'اختيار الجراحة',
                        border: OutlineInputBorder(),
                      ),
                      items: vare.doctor[variables.spec]!.map((String region) {
                        return DropdownMenuItem<String>(
                          value: region,
                          child: Text(region),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          variables.sergn1 = newValue;
                        });
                      },
                    ),
                  ),
                /////////////////////////////////
                Container(
                  height: 20,
                ),
                Container(
                  width: 200,
                  child: DropdownButtonFormField<String>(
                    value: variables.selectedGovernorate,
                    decoration: const InputDecoration(
                      labelText: 'اختيار المحافظة',
                      border: OutlineInputBorder(),
                    ),
                    items: vare.locations.keys.map((String governorate) {
                      return DropdownMenuItem<String>(
                        value: governorate,
                        child: Text(governorate),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        variables.selectedGovernorate = newValue;
                        variables.selectedRegion =
                            null; // إعادة تعيين المنطقة عند تغيير المحافظة
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),

                // اختيار المنطقة بناءً على المحافظة
                if (variables.selectedGovernorate != null)
                  Container(
                    width: 200,
                    child: DropdownButtonFormField<String>(
                      value: variables.selectedRegion,
                      decoration: const InputDecoration(
                        labelText: 'اختيار المنطقة',
                        border: OutlineInputBorder(),
                      ),
                      items: vare.locations[variables.selectedGovernorate]!
                          .map((String region) {
                        return DropdownMenuItem<String>(
                          value: region,
                          child: Text(region),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          variables.selectedRegion = newValue;
                        });
                      },
                    ),
                  ),
                MaterialButton(
                  onPressed: () {},
                  child: Text("تسجيل"),
                  color: Colors.blue,
                )
                //*********************************************doctor*************************************
              ],
            ),
          ),
        ),
      );
    }
    else if (shared?.getString("spec") == "Analyst") {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text("مركز التحاليل"),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: form,
            child: Column(
              children: [
                Container(
                  height: 60,
                ),
                Center(
                  child: Container(
                      width: 300,
                      child: Custom_Text(
                        validator: (val) {
                          if (!isArabicAlphabet(val!) || val.isEmpty)
                            return "الرجاء التاكد من الاسم";
                          return null;
                        },
                        labelText: 'اسم المركز',
                        controller: variables.name,
                        keyboardType: TextInputType.text,
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 170,
                      child: TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) return "الرجاء التاكد من الوقت";
                          return null;
                        },
                        controller: variables.startTimeController,
                        decoration: const InputDecoration(
                          labelText: 'وقت بدء العمل',
                          icon: Icon(Icons.access_time),
                        ),
                        readOnly: true,
                        onTap: () => _selectStartTime(context),
                      ),
                    ),
                    Container(
                      width: 170,
                      child: TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) return "الرجاء التاكد من الوقت";
                          return null;
                        },
                        controller: variables.endTimeController,
                        decoration: const InputDecoration(
                          labelText: 'وقت انتهاء العمل',
                          icon: Icon(Icons.access_time),
                        ),
                        readOnly: true,
                        onTap: () => _selectEndTime(context),
                      ),
                    )
                  ],
                ),
                Container(
                  height: 20,
                ),

                Center(
                  child: Container(
                      width: 300,
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: TextFormField(
                          validator: (val) {
                            if (val!.length < 10)
                              return "الرجاء التاكد من الرقم";
                            return null;
                          },
                          textAlign: TextAlign.right,
                          maxLength: 10,

                          // تحديد محاذاة النص
                          decoration: InputDecoration(
                            prefixText: "+20",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            labelText:
                                "رقم الهاتف", // تحديد النص الذي يظهر كـ "label"
                          ),
                          controller: variables.number,
                          // التحكم في النص المدخل
                          keyboardType: TextInputType.phone,
                          // تحديد نوع لوحة المفاتيح
                        ),
                      )),
                ),
                Container(
                  height: 20,
                ),
                Center(
                  child: Container(
                      width: 300,
                      child: Custom_Text(
                        validator: (val) {
                          load();
                          if (!isEmailValid(val!)) {
                            return "الرجاء التأكد من الايميل";
                          }
                          if (ppo == true) return "الأيميل مستخدم مسبقا";
                          return null;
                        },
                        labelText: 'البريد الالكتروني ',
                        controller: variables.email,
                        keyboardType: TextInputType.text,
                      )),
                ),
                Container(
                  height: 20,
                ),
                Center(
                  child: Container(
                      width: 300,
                      child: Custom_Text(
                        validator: (val) {
                          if (isPasswordValid(val!)) {
                            return null;
                          }

                          return "يجب التاكد ان كلمة المرور قوية";
                        },
                        labelText: 'كلمة المرور',
                        controller: variables.password,
                        keyboardType: TextInputType.visiblePassword,
                      )),
                ),
                Container(
                  height: 20,
                ),
                Center(
                  child: Container(
                      width: 300,
                      child: Custom_Text(
                        validator: (val) {
                          if (val!.length > 30 || val.isEmpty)
                            return "الرجاء التحقق من العنوان";
                          return null;
                        },
                        labelText: 'العنوان ب التفصيل',
                        controller: variables.address,
                        keyboardType: TextInputType.visiblePassword,
                      )),
                ),
                Container(
                  height: 50,
                ),
                Container(
                  width: 200,
                  child: DropdownButtonFormField<String>(
                    value: variables.selectedGovernorate,
                    decoration: const InputDecoration(
                      labelText: 'اختيار المحافظة',
                      border: OutlineInputBorder(),
                    ),
                    items: vare.locations.keys.map((String governorate) {
                      return DropdownMenuItem<String>(
                        value: governorate,
                        child: Text(governorate),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'الرجاء اختيار خيار';
                      }
                      return null; // إذا كانت القيمة صحيحة، ارجع null
                    },
                    onChanged: (newValue) {
                      setState(() {
                        variables.selectedGovernorate = newValue;
                        variables.selectedRegion =
                            null; // إعادة تعيين المنطقة عند تغيير المحافظة
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),

                // اختيار المنطقة بناءً على المحافظة
                if (variables.selectedGovernorate != null)
                  Container(
                    width: 200,
                    child: DropdownButtonFormField<String>(
                      value: variables.selectedRegion,
                      decoration: const InputDecoration(
                        labelText: 'اختيار المدينة',
                        border: OutlineInputBorder(),
                      ),
                      items: vare.locations[variables.selectedGovernorate]!
                          .map((String region) {
                        return DropdownMenuItem<String>(
                          value: region,
                          child: Text(region),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'الرجاء اختيار خيار';
                        }
                        return null; // إذا كانت القيمة صحيحة، ارجع null
                      },
                      onChanged: (newValue) {
                        setState(() {
                          variables.selectedRegion = newValue;
                        });
                      },
                    ),
                  ),
                Container(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: ()async {
                    await v.register_analyst();
                    if (!form.currentState!.validate()) {
                      showDialogError();
                    } else {
                      shared?.setInt("select", 1);
                      shared?.setString("a", '${variables.name.text}');
                      shared?.setString("b", '${variables.email.text}');
                      shared?.setString("c", '${variables.password.text}');
                      shared?.setString(
                          "d", '${variables.selectedGovernorate}');
                      shared?.setString("e", '${variables.selectedRegion}');
                      shared?.setString("f", '${variables.address.text}');
                      shared?.setString("g", '${variables.number.text}');
                      shared?.setString(
                          "h", '${variables.startTimeController.text}');
                      shared?.setString(
                          "i", '${variables.endTimeController.text}');
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => time()),
                          );

                    }
                  },
                  child: Text("تسجيل"),
                  color: Colors.blue,
                )
                //*******************************************************pharma********************
              ],
            ),
          ),
        ),
      );
    } else if (shared?.getString("spec") == "Radiology") {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text("مركز الاشعة"),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: form,
            child: Column(
              children: [
                Container(
                  height: 60,
                ),
                Center(
                  child: Container(
                      width: 300,
                      child: Custom_Text(
                        validator: (val) {
                          if (!isArabicAlphabet(val!) || val.isEmpty)
                            return "الرجاء التاكد من الاسم";
                          return null;
                        },
                        labelText: 'اسم المركز',
                        controller: variables.name,
                        keyboardType: TextInputType.text,
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 170,
                      child: TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) return "الرجاء التاكد من الوقت";
                          return null;
                        },
                        controller: variables.startTimeController,
                        decoration: const InputDecoration(
                          labelText: 'وقت بدء العمل',
                          icon: Icon(Icons.access_time),
                        ),
                        readOnly: true,
                        onTap: () => _selectStartTime(context),
                      ),
                    ),
                    Container(
                      width: 170,
                      child: TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) return "الرجاء التاكد من الوقت";
                          return null;
                        },
                        controller: variables.endTimeController,
                        decoration: const InputDecoration(
                          labelText: 'وقت انتهاء العمل',
                          icon: Icon(Icons.access_time),
                        ),
                        readOnly: true,
                        onTap: () => _selectEndTime(context),
                      ),
                    )
                  ],
                ),
                Container(
                  height: 20,
                ),

                Center(
                  child: Container(
                      width: 300,
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: TextFormField(
                          validator: (val) {
                            if (val!.length < 10)
                              return "الرجاء التاكد من الرقم";
                            return null;
                          },
                          textAlign: TextAlign.right,
                          maxLength: 10,

                          // تحديد محاذاة النص
                          decoration: InputDecoration(
                            prefixText: "+20",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            labelText:
                                "رقم الهاتف", // تحديد النص الذي يظهر كـ "label"
                          ),
                          controller: variables.number,
                          // التحكم في النص المدخل
                          keyboardType: TextInputType.phone,
                          // تحديد نوع لوحة المفاتيح
                        ),
                      )),
                ),
                Container(
                  height: 20,
                ),
                Center(
                  child: Container(
                      width: 300,
                      child: Custom_Text(
                        validator: (val) {
                          load();
                          if (!isEmailValid(val!)) {
                            return "الرجاء التأكد من الايميل";
                          }
                          if (ppo == true) return "الأيميل مستخدم مسبقا";
                          return null;
                        },
                        labelText: 'البريد الالكتروني ',
                        controller: variables.email,
                        keyboardType: TextInputType.text,
                      )),
                ),
                Container(
                  height: 20,
                ),
                Center(
                  child: Container(
                      width: 300,
                      child: Custom_Text(
                        validator: (val) {
                          if (isPasswordValid(val!)) {
                            return null;
                          }

                          return "الرجاء التاكد من كلمة المرور";
                        },
                        labelText: 'كلمة المرور',
                        controller: variables.password,
                        keyboardType: TextInputType.visiblePassword,
                      )),
                ),
                Container(
                  height: 20,
                ),
                Center(
                  child: Container(
                      width: 300,
                      child: Custom_Text(
                        validator: (val) {
                          if (val!.length > 30 || val.isEmpty)
                            return "الرجاء التحقق من العنوان";
                          return null;
                        },
                        labelText: 'العنوان ب التفصيل',
                        controller: variables.address,
                        keyboardType: TextInputType.visiblePassword,
                      )),
                ),
                Container(
                  height: 50,
                ),
                Container(
                  width: 200,
                  child: DropdownButtonFormField<String>(
                    value: variables.selectedGovernorate,
                    decoration: const InputDecoration(
                      labelText: 'اختيار المحافظة',
                      border: OutlineInputBorder(),
                    ),
                    items: vare.locations.keys.map((String governorate) {
                      return DropdownMenuItem<String>(
                        value: governorate,
                        child: Text(governorate),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'الرجاء اختيار خيار';
                      }
                      return null; // إذا كانت القيمة صحيحة، ارجع null
                    },
                    onChanged: (newValue) {
                      setState(() {
                        variables.selectedGovernorate = newValue;
                        variables.selectedRegion =
                            null; // إعادة تعيين المنطقة عند تغيير المحافظة
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),

                // اختيار المنطقة بناءً على المحافظة
                if (variables.selectedGovernorate != null)
                  Container(
                    width: 200,
                    child: DropdownButtonFormField<String>(
                      value: variables.selectedRegion,
                      decoration: const InputDecoration(
                        labelText: 'اختيار المدينة',
                        border: OutlineInputBorder(),
                      ),
                      items: vare.locations[variables.selectedGovernorate]!
                          .map((String region) {
                        return DropdownMenuItem<String>(
                          value: region,
                          child: Text(region),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'الرجاء اختيار خيار';
                        }
                        return null; // إذا كانت القيمة صحيحة، ارجع null
                      },
                      onChanged: (newValue) {
                        setState(() {
                          variables.selectedRegion = newValue;
                        });
                      },
                    ),
                  ),
                Container(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () async{
                    await v.register_xradio();
                    if (!form.currentState!.validate()) {
                      showDialogError();
                    } else {
                      shared?.setInt("select", 1);
                      shared?.setString("a", '${variables.name.text}');
                      shared?.setString("b", '${variables.email.text}');
                      shared?.setString("c", '${variables.password.text}');
                      shared?.setString(
                          "d", '${variables.selectedGovernorate}');
                      shared?.setString("e", '${variables.selectedRegion}');
                      shared?.setString("f", '${variables.address.text}');
                      shared?.setString("g", '${variables.number.text}');
                      shared?.setString(
                          "h", '${variables.startTimeController.text}');
                      shared?.setString(
                          "i", '${variables.endTimeController.text}');
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => time())
                          );

                    }
                  },
                  child: Text("تسجيل"),
                  color: Colors.blue,
                )
                //*******************************************************pharma********************
              ],
            ),
          ),
        ),
      );
    }
    return Container();
  }
}
