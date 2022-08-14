import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/models/request_appoinment_data.dart';

import 'package:drawblood_medicalinstitution_app/firebase_info.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../drawbood_app_theme.dart';

List<RequestAppointmentList> userAppointmentList = [];
List<RequestAppointmentList> categoriesAppointmentList = [];

class RequestAppointmentListView extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const RequestAppointmentListView(
      {Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  State<RequestAppointmentListView> createState() =>
      _RequestAppointmentListViewState();
}

class _RequestAppointmentListViewState
    extends State<RequestAppointmentListView> {
  int _value = 1;
  var data = '';
  String? uid = '';

  @override
  void initState() {
    uid = useruid();
    getUserAppointmentList(uid);
    _searchCategory(1);
    super.initState();
  }

  void _searchCategory(value) {
    if (value == 1) {
      data = 'All';
    } else if (value == 2) {
      data = 'On Going';
    } else if (value == 3) {
      data = 'Completed';
    } else if (value == 4) {
      data = 'Canceled';
    } else if (value == 5) {
      data = 'A';
    } else if (value == 6) {
      data = 'B';
    } else if (value == 7) {
      data = 'AB';
    } else if (value == 8) {
      data = 'O';
    }

    setState(() {
      if (data == 'On Going') {
        categoriesAppointmentList = userAppointmentList
            .where((element) => element.status == 'Ongoing')
            .toList();
      } else if (data == 'Completed') {
        categoriesAppointmentList = userAppointmentList
            .where((element) => element.status == 'Complete')
            .toList();
      } else if (data == 'Canceled') {
        categoriesAppointmentList = userAppointmentList
            .where((element) => element.status == 'Cancel')
            .toList();
      } else if (data == 'A') {
        categoriesAppointmentList = userAppointmentList
            .where((element) =>
                element.bloodtype == 'A+' || element.bloodtype == 'A-')
            .toList();
      } else if (data == 'B') {
        categoriesAppointmentList = userAppointmentList
            .where((element) =>
                element.bloodtype == 'B+' || element.bloodtype == 'B-')
            .toList();
      } else if (data == 'AB') {
        categoriesAppointmentList = userAppointmentList
            .where((element) =>
                element.bloodtype == 'AB+' || element.bloodtype == 'AB-')
            .toList();
      } else if (data == 'O') {
        categoriesAppointmentList = userAppointmentList
            .where((element) =>
                element.bloodtype == 'O+' || element.bloodtype == 'O-')
            .toList();
      } else {
        categoriesAppointmentList = userAppointmentList;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 12, bottom: 18),
              child: WillPopScope(
                onWillPop: () async => false,
                child: SizedBox(
                  height: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                width: 50,
                                decoration: new BoxDecoration(
                                  color: drawbloodAppTheme.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: drawbloodAppTheme.grey
                                          .withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: Offset(0, 1),
                                    )
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 5.0),
                                child: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 30.0, vertical: 5.0),
                                    child: DropdownButton(
                                      hint: Text('Appointment Category'),
                                      value: _value,
                                      icon: const Icon(Icons.arrow_downward),
                                      elevation: 16,
                                      items: [
                                        DropdownMenuItem(
                                          child: Text(
                                            "All",
                                          ),
                                          value: 1,
                                        ),
                                        DropdownMenuItem(
                                          child: Text(
                                            "On Going",
                                          ),
                                          value: 2,
                                        ),
                                        DropdownMenuItem(
                                            child: Text(
                                              "Completed",
                                            ),
                                            value: 3),
                                        DropdownMenuItem(
                                            child: Text(
                                              "Canceled",
                                            ),
                                            value: 4),
                                        DropdownMenuItem(
                                            child: Text(
                                              "A",
                                            ),
                                            value: 5),
                                        DropdownMenuItem(
                                            child: Text(
                                              "B",
                                            ),
                                            value: 6),
                                        DropdownMenuItem(
                                            child: Text(
                                              "AB",
                                            ),
                                            value: 7),
                                        DropdownMenuItem(
                                            child: Text(
                                              "O",
                                            ),
                                            value: 8),
                                      ],
                                      onChanged: (int? value) {
                                        setState(() {
                                          _value = value!;
                                          _searchCategory(_value);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: categoriesAppointmentList.isNotEmpty
                                  ? categoriesAppointmentList.length
                                  : 1,
                              itemBuilder: (BuildContext context, int index) {
                                if (categoriesAppointmentList.isEmpty) {
                                  return Center(
                                    child: Text(
                                        'The section is currently empty. \n Request more if neccessary.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily:
                                              drawbloodAppTheme.fontName,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16,
                                          letterSpacing: -0.1,
                                          color: drawbloodAppTheme.grey
                                              .withOpacity(0.8),
                                        )),
                                  );
                                } else {
                                  return _userAppointmentListWidget(
                                      categoriesAppointmentList[index]);
                                }
                              }))
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _userAppointmentListWidget(RequestAppointmentList list) {
  return Material(
      child: Padding(
    padding:
        const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
    child: Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: drawbloodAppTheme.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
            topRight: Radius.circular(8.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: drawbloodAppTheme.grey.withOpacity(0.2),
              offset: Offset(1.1, 1.1),
              blurRadius: 10.0),
        ],
      ),
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            children: [
              ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: list.status == 'Ongoing'
                                ? AssetImage(
                                    "assets/drawblood_app/processing.png")
                                : list.status == 'Complete'
                                    ? AssetImage(
                                        "assets/drawblood_app/done.png")
                                    : AssetImage(
                                        "assets/drawblood_app/cancelled.png"))),
                  ),
                  title: Text(
                    list.date.toString(),
                    style: TextStyle(
                      fontFamily: drawbloodAppTheme.fontName,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 0.18,
                      color: drawbloodAppTheme.darkerText,
                    ),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2.5),
                        child: Text(
                          'Requested blood: ${list.bloodtype.toString()}',
                          style: TextStyle(
                            fontFamily: drawbloodAppTheme.fontName,
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            letterSpacing: 0.18,
                            color: drawbloodAppTheme.grey.withOpacity(0.6),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.5),
                        child: Text(
                          'Request on: ${list.time.toString()}',
                          style: TextStyle(
                            fontFamily: drawbloodAppTheme.fontName,
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            letterSpacing: 0.18,
                            color: drawbloodAppTheme.grey.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ],
                  ),
                  trailing: Text(
                    list.status.toString(),
                    style: TextStyle(
                      fontFamily: drawbloodAppTheme.fontName,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      letterSpacing: 0.18,
                      color: list.status == 'Ongoing'
                          ? drawbloodAppTheme.darkText
                          : list.status == 'Complete'
                              ? drawbloodAppTheme.limegreen
                              : drawbloodAppTheme.red,
                    ),
                  )),
              list.status == 'Ongoing'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 4.0, top: 2.5, bottom: 2.5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: drawbloodAppTheme.limegreen,
                              shape: StadiumBorder(),
                            ),
                            onPressed: () {
                              FirestoreQuery.updateRequestStatus(
                                  list.uid, list.request_id, 'Complete');
                              Fluttertoast.showToast(
                                  msg: "The request set as completed",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: drawbloodAppTheme.background,
                                  textColor: drawbloodAppTheme.darkText,
                                  fontSize: 16.0);
                            },
                            child: const Text('Mark as Complete',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: drawbloodAppTheme.fontName,
                                  fontSize: 12,
                                  letterSpacing: 0.18,
                                  color: drawbloodAppTheme.white,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 4.0, right: 8.0, top: 2.5, bottom: 2.5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: drawbloodAppTheme.red,
                              shape: StadiumBorder(),
                            ),
                            onPressed: () {
                              FirestoreQuery.updateRequestStatus(
                                  list.uid, list.request_id, 'Cancel');
                              Fluttertoast.showToast(
                                  msg: "The request had been canceled",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: drawbloodAppTheme.background,
                                  textColor: drawbloodAppTheme.darkText,
                                  fontSize: 16.0);
                            },
                            child: const Text('Cancel',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: drawbloodAppTheme.fontName,
                                  fontSize: 12,
                                  letterSpacing: 0.18,
                                  color: drawbloodAppTheme.white,
                                )),
                          ),
                        ),
                      ],
                    )
                  : SizedBox()
            ],
          )),
    ),
  ));
}

void getUserAppointmentList(uid) async {
  final db = FirebaseFirestore.instance;
  final docRef = db
      .collection("request_appointment")
      .where('uid', isEqualTo: uid)
      .orderBy('date', descending: true);
  var snapshot = await docRef.get();
  if (userAppointmentList.isNotEmpty) {
    userAppointmentList.clear();
  }
  if (snapshot.docs.isNotEmpty) {
    for (DocumentSnapshot results in snapshot.docs) {
      Map<String, dynamic> data = results.data() as Map<String, dynamic>;

      userAppointmentList.add(RequestAppointmentList(
          uid: data['uid'],
          request_id: data['request_id'],
          bloodtype: data['bloodtype'],
          status: data['status'],
          venue: data['venue'],
          date: data['date'],
          time: data['time']));
    }
  }
}
