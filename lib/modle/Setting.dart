import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/variables.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  variables vare = variables();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(margin: EdgeInsets.only(top: 30),
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
                  items:
                  vare.locations[variables.selectedGovernorate]!.map((String region) {
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
          ],
        ),
      ),
    );
  }
}
