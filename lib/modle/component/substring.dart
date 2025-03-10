import 'package:triaq/main.dart';


class substring {
   // Instance variable
  static int? hour;
  static int? minute;
  static void splitTime() {
    String? time = shared?.getString("h");
    List<String>? parts = time?.split(":");
     hour = int.parse(parts![0]);
     minute = int.parse(parts![1]);

    print("Hour: $hour");
    print("Minute: $minute");
  }
}