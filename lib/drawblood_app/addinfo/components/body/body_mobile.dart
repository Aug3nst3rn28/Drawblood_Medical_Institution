import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/addinfo/components/background.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/components/rounded_button.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/login_page/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../components/rounded_input_field copy.dart';

class addinfo extends StatefulWidget {
  const addinfo({Key? key}) : super(key: key);

  @override
  State<addinfo> createState() => _addinfoState();
}

class _addinfoState extends State<addinfo> {
  String Blood_type = "";
  String name = "";
  String gender = "Male";
  String height = "";
  String weight = "";
  String Phone_number = "";
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final genderController = TextEditingController();
    final heightController = TextEditingController();
    final weightController = TextEditingController();
    final Phone_numberController = TextEditingController();
    final database = FirebaseDatabase.instance.reference();
    final userRef = database.child('user');
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Welcome",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
            ),
            Text(
              "please insert your information",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Full Name",
              icon: Icons.person,
              onChanged: (text) {
                name = text;
              },
              controller: nameController,
            ),
            RoundedInputField(
              hintText: "Phone number",
              icon: Icons.cake,
              onChanged: (text) {
                Phone_number = text;
              },
              controller: Phone_numberController,
            ),
            RoundedInputField(
              hintText: "Weight",
              icon: Icons.announcement,
              onChanged: (text) {
                weight = text;
              },
              controller: weightController,
            ),
            RoundedInputField(
              hintText: "Height",
              icon: Icons.announcement,
              onChanged: (text) {
                height = text;
              },
              controller: heightController,
            ),
            SizedBox(height: size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Gender",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    DropdownButton(
                        items: <String>[
                          'Male',
                          'Female',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        hint: Text(
                          gender,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        }),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Blood Type",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    DropdownButton(
                        items: <String>[
                          'A+',
                          'B+',
                          'O+',
                          'AB+',
                          'A-',
                          'B-',
                          'O-',
                          'AB-',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        hint: Text(
                          Blood_type,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        onChanged: (value) {
                          setState(() {
                            Blood_type = value.toString();
                          });
                        }),
                  ],
                ),
              ],
            ),
            RoundedButton(text: "Create", press: inputData),
          ],
        ),
      ),
    );
  }

  Future<void> inputData() async {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    final docUser = FirebaseFirestore.instance.collection('user').doc(uid);
    final createreward = FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('reward');
    final createappointment = FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('appointment');

    final json = {
      'name': name,
      'bloodtype': Blood_type,
      'gender': gender,
      'height': height,
      'phonenum': Phone_number,
      'point': "0",
      'type': "user",
      'weight': weight,
      'status': "Complete",
      'lastapp': DateTime(2022, 01, 01),
    };

    await docUser.set(json);
    await createappointment;
    await createreward;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
    // here you write the codes to input the data into firestore
  }
}
