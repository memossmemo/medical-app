import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Custom_Text extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  int? max;
  final String? Function(String?)? validator;
  String? prefx;

  Custom_Text(
      {super.key,
      required this.validator,
      required this.labelText,
      required this.controller,
      required this.keyboardType,
      this.max,
      this.prefx});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        validator: validator,
        maxLength: max,
        key: key,
        // تحديد محاذاة النص
        decoration: InputDecoration(
          prefixText: prefx,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          labelText: labelText, // تحديد النص الذي يظهر كـ "label"
        ),
        controller: controller,
        // التحكم في النص المدخل
        keyboardType: keyboardType,
        // تحديد نوع لوحة المفاتيح
      ),
    );
  }
}
