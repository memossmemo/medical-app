import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class mm extends StatefulWidget {
  const mm({super.key});

  @override
  State<mm> createState() => _mmState();
}

class _mmState extends State<mm> {
  List<String> daysOfWeek = [
    'الأحد',
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت'
  ];
  List<String> selectedDays = [];
  Map<String, int> startTimes = {};  // تخزين الوقت كعدد صحيح (ساعات فقط)
  Map<String, int> endTimes = {};    // تخزين الوقت كعدد صحيح (ساعات فقط)
  Map<String, TextEditingController> startTimeControllers = {};
  Map<String, TextEditingController> endTimeControllers = {};

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each day
    for (var day in daysOfWeek) {
      startTimeControllers[day] = TextEditingController();
      endTimeControllers[day] = TextEditingController();
    }
  }

  // دالة للتحقق من المدخلات وتحويل النص إلى عدد صحيح بين 1 و 24
  int? _parseHour(String value) {
    final hour = int.tryParse(value);
    if (hour != null && hour >= 1 && hour <= 24) {
      return hour;  // إذا كانت القيمة صحيحة
    }
    return null;  // إذا كانت القيمة غير صحيحة
  }

  // دالة للتحقق من أن وقت الانتهاء لا يقل عن وقت البدء
  bool _isEndTimeValid(String day) {
    final start = startTimes[day];
    final end = endTimes[day];
    if (start != null && end != null) {
      return end >= start;
    }
    return true;  // إذا لم يتم تحديد الوقت بعد
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("اختصاص الدكتور"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "اختر أيام الأسبوع للعمل:",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Wrap(
                children: daysOfWeek.map((day) {
                  return ChoiceChip(
                    label: Text(day),
                    selected: selectedDays.contains(day),
                    onSelected: (isSelected) {
                      setState(() {
                        if (isSelected) {
                          selectedDays.add(day);
                        } else {
                          selectedDays.remove(day);
                          startTimes.remove(day);
                          endTimes.remove(day);
                          startTimeControllers[day]!.clear();
                          endTimeControllers[day]!.clear();
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ...selectedDays.map((day) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$day:'),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: startTimeControllers[day],
                            decoration: InputDecoration(
                              labelText: 'وقت البدء',
                              hintText: 'أدخل ساعة البدء (من 1 إلى 24)',
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              final parsedHour = _parseHour(value);
                              if (parsedHour != null) {
                                setState(() {
                                  startTimes[day] = parsedHour;
                                });
                              } else {
                                if (value.isNotEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("الساعة يجب أن تكون بين 1 و 24"),
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: endTimeControllers[day],
                            decoration: InputDecoration(
                              labelText: 'وقت الانتهاء',
                              hintText: 'أدخل ساعة الانتهاء (من 1 إلى 24)',
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              final parsedHour = _parseHour(value);
                              if (parsedHour != null) {
                                setState(() {
                                  endTimes[day] = parsedHour;
                                });
                                // تحقق من أن وقت الانتهاء أكبر من أو يساوي وقت البدء
                                if (!_isEndTimeValid(day)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("وقت الانتهاء يجب أن يكون أكبر من أو يساوي وقت البدء"),
                                    ),
                                  );
                                }
                              } else {
                                if (value.isNotEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("الساعة يجب أن تكون بين 1 و 24"),
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                );
              }).toList(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      String selectedDaysText = selectedDays.isEmpty
                          ? "لم يتم اختيار أي يوم"
                          : selectedDays.map((day) {
                        String start = startTimes[day]?.toString() ?? "غير محدد";
                        String end = endTimes[day]?.toString() ?? "غير محدد";
                        return '$day: من $start إلى $end';
                      }).join('\n');
                      return AlertDialog(
                        title: Text("الأيام المحددة"),
                        content: Text(selectedDaysText),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("إغلاق"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text("عرض الأيام المحددة"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
