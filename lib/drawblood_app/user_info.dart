import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/models/user_data.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/ui_view/appointment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

final locate = FirebaseFirestore.instance.collection("appoinment");
Color dangercolor = Colors.lightGreen;
var size2;
String? name = "";
String? time = "";
String? id = "";
String? userid = "";
String? appointid = "";
DateTime? date;
int? point = 0;
String stpoint = "";
String blood = "";

class info {
  late String bloodtype;
  late DateTime date;
  late String gender;
  late String height;
  late String name;
  late String status;
  late String user_id;
  late String vanue;
  late String weight;
  late String point;

  info({
    required this.bloodtype,
    required this.date,
    required this.gender,
    required this.height,
    required this.name,
    required this.status,
    required this.user_id,
    required this.vanue,
    required this.weight,
    required this.point,
  });
  Map<String, dynamic> toJson() => {
        'bloodtype': bloodtype,
        'date': date,
        'gender': gender,
        'height': height,
        'name': name,
        'status': status,
        'user_id': user_id,
        'vanue': vanue,
        'weight': weight,
        'point': point,
      };

  static info fromJson(Map<String, dynamic> json) => info(
        bloodtype: json['bloodtype'],
        date: json['date'].toDate(),
        gender: json['gender'],
        height: json['height'],
        name: json['name'],
        status: json['status'],
        user_id: json['user_id'],
        vanue: json['vanue'],
        weight: json['weight'],
        point: json['point'],
      );
}

class user_info extends StatefulWidget {
  const user_info({Key? key}) : super(key: key);

  @override
  State<user_info> createState() => _user_infoState();
}

class _user_infoState extends State<user_info> {
  @override
  Widget build(BuildContext context) {
    final appoint_id = ModalRoute.of(context)!.settings.arguments;
    appointid = appoint_id.toString();
    Size size = MediaQuery.of(context).size;
    size2 = size;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(),
      body: FutureBuilder<info?>(
          future: read(
            appoint_id.toString(),
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final user_info = snapshot.data;
              userid = user_info!.user_id;
              date = user_info!.date;
              point = int.parse(user_info!.point);
              blood = user_info!.bloodtype;
              if (blood == "AB+") {
                blood = "abpositive";
              } else if (blood == "AB-") {
                blood = "abnegative";
              } else if (blood == "A+") {
                blood = "apositive";
              } else if (blood == "A-") {
                blood = "anegative";
              } else if (blood == "B+") {
                blood = "bpositive";
              } else if (blood == "B-") {
                blood = "bnegative";
              } else if (blood == "O+") {
                blood = "opositive";
              } else if (blood == "O-") {
                blood = "onegative";
              }

              if (user_info.status == "Ongoing") {
                return buildbody(user_info!);
              } else {
                dangercolor = Colors.red;
                return buildbody2(user_info!);
              }
            } else
              return Center(
                child: Text('Loading'),
              );
          }),
    );
  }

  Future<info?> read(name) async {
    final doc = FirebaseFirestore.instance.collection('appoinment').doc(name);
    final snapshot = await doc.get();
    final snapshot2 = await doc.get();

    if (snapshot.exists) {
      return info.fromJson(snapshot.data()!);
    }
  }

  Widget buildbody(info info) => SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(
            height: size2.height,
            child: Stack(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 200),
                    height: 700,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24))),
                    child: Padding(
                      padding: EdgeInsets.only(left: 40, right: 30, top: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Appoint ID",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(appointid!,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text("Vanue",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(info.vanue,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text("Date",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(info.date.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text("Gender",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(info.gender,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text("Blood Types",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(info.bloodtype,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          SizedBox(
                              height: 60,
                              width: 300,
                              child: TextButton(
                                onPressed: () {
                                  point = (point! + 500);
                                  stpoint = point.toString();
                                  inputData();
                                  Navigator.pop(context);
                                },
                                child: Text("Complete"),
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Colors.blue,
                                  onSurface: Colors.white,
                                  shape: const BeveledRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ))
                        ],
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 40, right: 30, top: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Text("Appointment Information",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          Text(info.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            info.status,
                            style: TextStyle(
                                color: dangercolor,
                                fontSize: 60,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ]),
      );

  Widget buildbody2(info info) => SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(
            height: size2.height,
            child: Stack(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 200),
                    height: 700,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24))),
                    child: Padding(
                      padding: EdgeInsets.only(left: 40, right: 30, top: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Appoint ID",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(appointid!,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text("Vanue",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(info.vanue,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text("Date",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(info.date.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text("Gender",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(info.gender,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text("Blood Types",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(info.bloodtype,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    )),
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 40, right: 30, top: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Text("Appointment Information",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          Text(info.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            info.status,
                            style: TextStyle(
                                color: dangercolor,
                                fontSize: 60,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ]),
      );
}

Future<void> inputData() async {
  final docUser = FirebaseFirestore.instance.collection('user').doc(userid);

  final updateapplist =
      FirebaseFirestore.instance.collection('appoinment').doc(appointid);

  final updateuserapp = FirebaseFirestore.instance
      .collection('user')
      .doc(userid)
      .collection('appointment')
      .doc('appoit');

  final json = {
    'status': "Complete",
  };

  final json2 = {'lastapp': date, 'status': "Complete", 'point': stpoint};
  try {
    await updateapplist.update(json);
    await docUser.update(json2);
    await updateuserapp.update(json);
  } catch (error) {
    String message = error.toString();
    Fluttertoast.showToast(msg: message, timeInSecForIosWeb: 25);
  }

  Fluttertoast.showToast(
      msg: "Status Update Successfull", timeInSecForIosWeb: 25);
}
