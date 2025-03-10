import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:triaq/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../view/variables.dart';
import 'homepage.dart';

class location extends StatefulWidget {
  const location({super.key});

  @override
  State<location> createState() => _locationState();
}

class _locationState extends State<location> {
  variables vare = variables();
  void updateSelectedIndexInHomeState(int newIndex) {
    HomeState? homeState = context.findAncestorStateOfType<HomeState>();
    if (homeState != null) {
      homeState.updateSelectedIndex(newIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تحديد الموقع"),),
      body: Center(
        child: Column(
          children: [
            Container(height: 100,),

            SizedBox(
              width: 200.0,
              child: TextLiquidFill(
                textAlign: TextAlign.start,
                text: 'الرجاء تحديد موقعك',
                waveColor: Colors.blueAccent,
                boxBackgroundColor: Colors.white70,
                textStyle: const TextStyle(

                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                boxHeight: 100.0,
              ),
            )
            ,

            Container(height: 50,),



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
                  onChanged: (newValue) {
                    setState(() {
                      variables.selectedRegion = newValue;
                    });
                  },
                ),
              ),
            Container(height: 30,),
            MaterialButton(color: Colors.blue,
              onPressed: () async{
              await shared?.setString("city","${variables.selectedGovernorate}" );
              shared?.setString("region", "${variables.selectedRegion}");
              updateSelectedIndexInHomeState(1);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Home()));


              },
              child: Text("تاكيد"),
            )
          ],
        ),
      ),
    );
  }
}
