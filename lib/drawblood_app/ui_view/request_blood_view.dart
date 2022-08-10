import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/models/medical_data.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/models/request_appoinment_data.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/models/user_data.dart';
import 'package:drawblood_medicalinstitution_app/firebase_info.dart';
import 'package:drawblood_medicalinstitution_app/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../drawbood_app_theme.dart';

import 'package:flutter/material.dart';
import 'dart:math' as math;

String? uid = '';
String venue = '';
DateTime now = new DateTime.now();
DateTime date = DateTime(now.year, now.month, now.day);
TimeOfDay time =
    TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);

class RequestBloodView extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const RequestBloodView({Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  State<RequestBloodView> createState() => _RequestBloodViewState();
}

class _RequestBloodViewState extends State<RequestBloodView> {
  String bloodType = 'A+';
  String requestStatus = 'Emergency';

  void initState() {
    uid = useruid();
    getCurrentMedicalName(uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.animationController!,
        builder: (BuildContext context, Widget? child) {
          content:
          return FadeTransition(
            opacity: widget.animation!,
            child: new Transform(
              transform: new Matrix4.translationValues(
                  0.0, 30 * (1.0 - widget.animation!.value), 0.0),
              child: Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 16, bottom: 18),
                  child: Container(
                    decoration: BoxDecoration(
                      color: drawbloodAppTheme.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                          topRight: Radius.circular(68.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: drawbloodAppTheme.grey.withOpacity(0.2),
                            offset: Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16, left: 16, right: 16),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 4),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          height: 64,
                                          width: 3,
                                          decoration: BoxDecoration(
                                            color: HexColor('#FF797A')
                                                .withOpacity(0.5),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Blood Type',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: drawbloodAppTheme
                                                      .fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  letterSpacing: -0.1,
                                                  color: drawbloodAppTheme
                                                      .darkText
                                                      .withOpacity(0.8),
                                                ),
                                              ),
                                              Container(
                                                width: 100,
                                                child: DropdownButton<String>(
                                                  items: <String>[
                                                    'A+',
                                                    'A-',
                                                    'B+',
                                                    'B-',
                                                    'AB+',
                                                    'AB-',
                                                    'O+',
                                                    'O-'
                                                  ].map((String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  hint: Text(
                                                    bloodType,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  onChanged: (value) async {
                                                    setState(() =>
                                                        bloodType = value!);
                                                  },
                                                  elevation: 6,
                                                  isExpanded: true,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 14,
                                        ),
                                        Container(
                                          height: 64,
                                          width: 3,
                                          decoration: BoxDecoration(
                                            color: HexColor('#FF797A')
                                                .withOpacity(0.5),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Request Status',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: drawbloodAppTheme
                                                      .fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  letterSpacing: -0.1,
                                                  color: drawbloodAppTheme
                                                      .darkText
                                                      .withOpacity(0.8),
                                                ),
                                              ),
                                              Container(
                                                width: 100,
                                                child: DropdownButton<String>(
                                                  items: <String>[
                                                    'Emergency',
                                                    'Refill'
                                                  ].map((String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  hint: Text(
                                                    requestStatus,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  onChanged: (value) async {
                                                    setState(() =>
                                                        requestStatus = value!);
                                                  },
                                                  elevation: 6,
                                                  isExpanded: true,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          height: 64,
                                          width: 3,
                                          decoration: BoxDecoration(
                                            color: HexColor('#FF797A')
                                                .withOpacity(0.5),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Date and Time',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: drawbloodAppTheme
                                                      .fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  letterSpacing: -0.1,
                                                  color: drawbloodAppTheme
                                                      .darkText
                                                      .withOpacity(0.8),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    padding: EdgeInsets.zero,
                                                    constraints:
                                                        BoxConstraints(),
                                                    icon: Icon(
                                                        Icons.calendar_month),
                                                    onPressed: () {},
                                                  ),
                                                  TextButton(
                                                      style: ButtonStyle(),
                                                      onPressed: () async {
                                                        DateTime? Newdate =
                                                            await showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    date,
                                                                firstDate:
                                                                    DateTime(now
                                                                        .year),
                                                                lastDate: DateTime(
                                                                    now.year +
                                                                        30));
                                                        if (Newdate == null)
                                                          return;
                                                        setState(() =>
                                                            date = Newdate);
                                                      },
                                                      child: Text(
                                                        date
                                                            .toString()
                                                            .substring(0, 10),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      )),
                                                  TextButton(
                                                      style: ButtonStyle(),
                                                      onPressed: () async {
                                                        TimeOfDay? Newtime =
                                                            await showTimePicker(
                                                          context: context,
                                                          initialTime: time,
                                                        );
                                                        if (Newtime == null)
                                                          return;
                                                        setState(() =>
                                                            time = Newtime);
                                                      },
                                                      child: Text(
                                                        '${time.hourOfPeriod}:${time.minute} ${time.period.toString().split('.')[1]}',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ))
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: drawbloodAppTheme.red,
                                          shape: StadiumBorder(),
                                        ),
                                        onPressed: () {
                                          FirestoreQuery.createRequstAppoiment(
                                              RequestAppointmentList(
                                                  uid: uid,
                                                  request_id:
                                                      Uuid().v4().toString(),
                                                  bloodtype: bloodType,
                                                  status: "Ongoing",
                                                  venue: venue,
                                                  date: date.toString(),
                                                  time:
                                                      '${time.hourOfPeriod}:${time.minute} ${time.period.toString().split('.')[1]}'));
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Successfully Requested the Blood to the Users.",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor:
                                                  drawbloodAppTheme.background,
                                              textColor:
                                                  drawbloodAppTheme.darkText,
                                              fontSize: 16.0);
                                        },
                                        child: const Text('Request Blood Now',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  drawbloodAppTheme.fontName,
                                              fontSize: 14,
                                              letterSpacing: 0.18,
                                              color: drawbloodAppTheme.white,
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          );
        });
  }
}

void getCurrentMedicalName(uid) {
  final db = FirebaseFirestore.instance;
  final docRefName = db.collection("user").doc(uid);
  docRefName.get().then(
    (DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      venue = data['name'];
    },
    onError: (e) => print("Error getting document: $e"),
  );
}
