import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Doctor extends StatefulWidget {
  const Doctor({Key? key}) : super(key: key);

  @override
  _DoctorState createState() => _DoctorState();
}

String? qualification;
String? gender;
String? city;
String? edu;
List<String> QualificationList = ["MBBS", "MCA", "BCA", "CIVIL"];
List<String> GenderList = ["MALE", "FEMALE", "OTHERS", "INTRESTED_ANY"];
List<String> CityList = ["LUCKNOW", "HARDOI", "DELHI", "MUMBAI"];
TextEditingController namectrl = new TextEditingController();

class _DoctorState extends State<Doctor> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("DOCTOR"),
        ),
        backgroundColor: Colors.white,
        body: Stack(children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            child: ListView(children: [
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * .35,
                      child: Image.asset(
                        "assets/images/doctor.webp",
                        cacheWidth: 100,
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Text(
                      "DOCTOR",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration:
                    BoxDecoration(border: buildBottomBorder(Colors.blue)),
                child: BuildTextField(namectrl, "Name"),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration:
                    BoxDecoration(border: buildBottomBorder(Colors.blue)),
                child: DropdownButton(
                    onChanged: (value) {
                      setState(() {
                        qualification = value as String;
                      });
                    },
                    hint: const Text("Qualification"),
                    underline: const Text(""),
                    isExpanded: true,
                    value: qualification,
                    items: QualificationList.map<DropdownMenuItem<String>>((e) {
                      return DropdownMenuItem<String>(
                        child: Text(e),
                        value: e,
                      );
                    }).toList()),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration:
                    BoxDecoration(border: buildBottomBorder(Colors.blue)),
                child: DropdownButton(
                    onChanged: (value) {
                      setState(() {
                        gender = value as String;
                      });
                    },
                    hint: const Text("Gender"),
                    underline: const Text(""),
                    isExpanded: true,
                    value: gender,
                    items: GenderList.map<DropdownMenuItem<String>>((e) {
                      return DropdownMenuItem<String>(
                        child: Text(e),
                        value: e,
                      );
                    }).toList()),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration:
                    BoxDecoration(border: buildBottomBorder(Colors.blue)),
                child: DropdownButton(
                    onChanged: (value) {
                      setState(() {
                        city = value as String;
                      });
                    },
                    hint: const Text("City"),
                    underline: const Text(""),
                    isExpanded: true,
                    value: city,
                    items: CityList.map<DropdownMenuItem<String>>((e) {
                      return DropdownMenuItem<String>(
                        child: Text(e),
                        value: e,
                      );
                    }).toList()),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 110),
                child: ElevatedButton(
                  // style: style,
                  onPressed: () {
                  = add_Doctor();
                  },
                  child: Text(
                    "Upload",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ]),
          ),
        ]));
    Future<void> add_Doctor() async {
      var data = {
        "Name": namectrl.text.toString(),
        "Qualification": edu.toString(),
        "Gender": gender.toString(),
        "City": city.toString(),
      };
      var response = await http.post(
          Uri.parse("http://khancollege.000webhostapp.com/add/add_Doctor.php"),
          body: json.encode(data));
      var obj = jsonDecode(response.body);
      if (obj['result'] == "S") {
        print("Record is Saved");
      } else {
      
        print("Record is not  Saved");
      }
    }
  }
}

TextField BuildTextField(TextEditingController controller, String label) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      label: Text(label),
      // labelStyle: TextStyle(color: Colors.blue),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
      ),
    ),
  );
}

buildBottomBorder(var color) {
  return Border(
    bottom: BorderSide(
      color: color,
      width: 2,
    ),
  );
}
