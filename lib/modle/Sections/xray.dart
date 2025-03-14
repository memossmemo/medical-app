import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:flutter/widgets.dart';
import 'package:triaq/main.dart';
import 'package:triaq/view/Api/pharma_Api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../view/Api/pharma_Api.dart';
import '../component/rate.dart';

class xray extends StatefulWidget {
  const xray({super.key});

  @override
  State<xray> createState() => _pharmaState();
}

class _pharmaState extends State<xray> {
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  bool _isUploading = false;
  Future<void> _uploadImage() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("يرجى اختيار صورة أولاً")));
      return;
    }

    setState(() {
      _isUploading = true;
    });

    var url = Uri.parse( 'https://pharma-manager-copy-2.onrender.com/api/Pharmatic/send-request/${shared?.getString("id_seek")}/${shared?.getString("city")}/${shared?.getString("region")}');
    var request = http.MultipartRequest("POST", url);

    // إضافة الصورة إلى الطلب
    var file = await http.MultipartFile.fromPath("image", _image!.path, filename: p.basename(_image!.path));
    request.files.add(file);

    try {
      var response = await request.send();
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم رفع الصورة بنجاح!")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("فشل رفع الصورة")));
      }
    } catch (e) {
      print("خطأ أثناء رفع الصورة: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("حدث خطأ أثناء رفع الصورة")));
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }
  final ImagePicker _picker = ImagePicker();
  XFile? _image; // المتغير الذي يخزن الصورة
  // دالة لالتقاط صورة باستخدام الكاميرا
  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    setState(() {
      _image = image; // تخزين الصورة في المتغير
      print("تم اختيار الصورة: ${_image!.path}");
      _uploadImage();
    });
  }
  // دالة لعرض خيارات المصدر
  void _showPickerDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera),
              title: Text("التقاط صورة"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
                print("//////////////////////////////////////////////////////////////////////${_image?.path}");
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("اختيار من المعرض"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Future<Map<String, dynamic>> fetchRadio(String city, String region) async {
    String url =
        'https://pharma-manager-copy-2.onrender.com/api/getradiologiesinCity';
    url += '/$city';
    url += '/$region';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 201) {
        final dataa = json.decode(response.body);
        print(dataa);
        return dataa;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
    return {};
  }

  pharma_Api pharm = pharma_Api();
  List phID = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded))
        ],
        title: Text("مركز الاشعة")
      ),
      body: Container(
        child: Column(
          children: [
            InkWell(onTap: (){_showPickerDialog();},
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3), // لون الظل
                    offset: Offset(4, 4), // مكان الظل (المقدار العمودي والأفقي)
                    blurRadius: 10, // درجة التمويه للظل
                  ),
                ],
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.all(15),
                width: 1000,
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Container(
                          margin: EdgeInsets.only(left: 30),
                          child: Text(
                            "أنقر لتصوير الروشتة",
                            style: TextStyle(fontSize: 20, color: Colors.blue),
                          ),
                        )),
                    Icon(
                      Icons.camera_alt,
                      size: 30,
                      color: Colors.blue,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<Map<String, dynamic>>(
                future: fetchRadio("${shared?.getString("city")}",
                    "${shared?.getString("region")}"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('حدث خطأ'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!["findradiology"].length,
                      itemBuilder: (context, index) {
                        phID.add(snapshot.data!["findradiology"][index]["_id"]);

                        return Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 40, right: 40),
                            child: Center(
                              child: Card(
                                elevation: 10,
                                shadowColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        height: 70,
                                        width: 70,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(40), // تحديد نصف القطر
                                          child: Image.asset(
                                            'photo/page33.jpg',
                                            fit: BoxFit.cover, // لتغطية المساحة بالكامل
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        '${snapshot.data!["findradiology"][index]["fullName"]}',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '${snapshot.data!["findradiology"][index]["city"].toString().replaceAll("محافظة", "")} /${snapshot.data!["findradiology"][index]["region"].toString().replaceAll("مدينة", "")} /${snapshot.data!["findradiology"][index]["address"]} ',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                          'مواعيد العمل: من ${snapshot.data!["findradiology"][index]["StartJob"]} \n                     الى${snapshot.data!["findradiology"][index]["EndJob"]}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54),
                                      ),
                                      SizedBox(height: 20),
                                      InkWell(onTap: (){Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RatingScreen(

                                                  )));},
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            RatingBarIndicator(
                                              rating:
                                              (snapshot.data?["findradiology"]
                                              [index]
                                              ["finalRate"] ??
                                                  0.0)
                                                  .toDouble(),
                                              itemCount: 5,
                                              itemSize: 15.0,
                                              physics:
                                              const BouncingScrollPhysics(),
                                              itemBuilder: (context, _) =>
                                              const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                            ),
                                            Container(
                                              width: 50,
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                var phoneNumber =
                                                    '${snapshot.data!["findradiology"][index]["phone"]}';
                                                final Uri uri = Uri(
                                                    scheme: 'tel',
                                                    path: phoneNumber);
                                                if (await canLaunchUrl(uri)) {
                                                  await launchUrl(uri);
                                                } else {
                                                  throw 'Could not launch $phoneNumber';
                                                } // استبدل هذا بالرقم الذي تريد الاتصال به
                                              },
                                              style: ElevatedButton.styleFrom(
                                                elevation: 10,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: Text(
                                                'اتصل الان',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.blue),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ));
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//"${await shared?.getString("city")}"
//"${await shared?.getString("address")}"
/*
FutureBuilder<Map<String,dynamic>>(
        future: fetchData(
            "${shared?.getString("city")}", "${shared?.getString("address")}"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!["findPharma"].length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10,left: 30,right: 30),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        children: [
                          // اسم الصيدلية
                          Text(
                            " صيدلية : ${snapshot.data!["findPharma"][index]["fullName"]}",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(

                            children: [
                              Icon(Icons.location_disabled, color: Colors.green),
                              SizedBox(width: 8),
                              Text(
                                "الدقهلية/دكرنس/شارع الحمراء",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],


                          ),SizedBox(height: 20),
                          Row(

                            children: [
                              Icon(Icons.access_time, color: Colors.orange),
                              SizedBox(width: 8),
                              Text(
                                'من: ${snapshot.data!["findPharma"][index]["StartJob"]}',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(width: 16),
                              Text(
                                'إلى: ${snapshot.data!["findPharma"][index]["EndJob"]}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(height: 25),
                          // رقم الهاتف
                          Row(
mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.phone, color: Colors.green),
                              SizedBox(width: 8),
                              Text(
                                "${snapshot.data!["findPharma"][index]["phone"]}",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),

                          // مواعيد العمل

                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
*/
/*
Center(
            child: Card(
              elevation: 10,
              shadowColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.local_pharmacy,
                      size: 50,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'صيدلية الصحة والعافية',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'العنوان: دمياط/دكرنس/شارع الكمال',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'مواعيد العمل : من 3 الى 9 ما عدا الجمعة ',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.star,color: Colors.yellow[600]),
                        Icon(Icons.star,color: Colors.yellow[600]),
                        Icon(Icons.star,color: Colors.yellow[600]),
                        Icon(Icons.star,color: Colors.yellow[600]),
                        Icon(Icons.star,color: Colors.yellow[600]),
                        Container(width: 50,),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 10,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'اتصل الان',
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),


 */
