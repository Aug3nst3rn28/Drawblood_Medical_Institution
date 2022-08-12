import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/models/user_appointment_list_data.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/models/user_data.dart';
import 'package:drawblood_medicalinstitution_app/firebase_info.dart';

import 'package:flutter/material.dart';
import '../drawbood_app_theme.dart';

List<AppoinmentList> userAppointmentList = [];
List<AppoinmentList> categoriesAppointmentList = [];
List<UserModel> userInformationList = [];
String medicalInformation = '';

class AppointmentView extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const AppointmentView({Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  int _value = 1;
  var data = '';
  String? uid = '';
  String venue = '';

  @override
  void initState() {
    uid = useruid();
    getMedicalName(uid);
    getUserAppointmentList(medicalInformation);

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
      } else {
        categoriesAppointmentList = userAppointmentList;
      }
      getUserInformation(categoriesAppointmentList);
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
                                        'The section is currently empty. \n Donate more to earn more rewards.',
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

Widget _userAppointmentListWidget(AppoinmentList list) {
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
                    '${list.date!.year}/${list.date!.month}/${list.date!.day}',
                    style: TextStyle(
                      fontFamily: drawbloodAppTheme.fontName,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 0.18,
                      color: drawbloodAppTheme.darkerText,
                    ),
                  ),
                  subtitle: Text(
                    list.venue.toString(),
                    style: TextStyle(
                      fontFamily: drawbloodAppTheme.fontName,
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      letterSpacing: 0.18,
                      color: drawbloodAppTheme.grey.withOpacity(0.6),
                    ),
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
            ],
          )),
    ),
  ));
}

void getUserAppointmentList(medicalInformation) async {
  final db = FirebaseFirestore.instance;
  final docRef = db
      .collection("appoinment")
      .where('vanue', isEqualTo: medicalInformation)
      .orderBy('date', descending: true);
  var snapshot = await docRef.get();
  if (userAppointmentList.isNotEmpty) {
    userAppointmentList.clear();
  }

  if (snapshot.docs.isNotEmpty) {
    for (DocumentSnapshot results in snapshot.docs) {
      Map<String, dynamic> data = results.data() as Map<String, dynamic>;

      userAppointmentList.add(AppoinmentList(
          user_id: data['user_id'],
          venue: data['vanue'],
          status: data['status'],
          date: (data['date'] as Timestamp).toDate(),
          createdate: data['createdate']));

      print(userAppointmentList[0].user_id);
    }
  }
}

void getMedicalName(uid) async {
  final db = FirebaseFirestore.instance;
  final docRef = db.collection("user").doc(uid);

  docRef.get().then(
    (DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      medicalInformation = data['name'];
    },
    onError: (e) => print("Error getting document: $e"),
  );
}

void getUserInformation(user_id) async {
  print(user_id);
  final db = FirebaseFirestore.instance;
  final docRef = db.collection("user").doc(user_id);
  if (userInformationList.isNotEmpty) {
    userInformationList.clear();
  }
  docRef.get().then(
    (DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;

      userInformationList.add(UserModel(
          name: data['name'],
          bloodtype: data['bloodtype'],
          gender: data['gender'],
          height: data['height'],
          weight: data['weight']));
    },
    onError: (e) => print("Error getting document: $e"),
  );
}



// Future<UserModel?> getUserInformation(user_id) async {
//   print(user_id);
//   final userInfoCollection =
//       FirebaseFirestore.instance.collection("user").doc(user_id);
//   final snapshot = await userInfoCollection.get();
//   if (snapshot.exists) {
//     userInformationList.add(UserModel.fromJson(snapshot.data()!));
//   }

//   print('userInformationList[0].name');
//   print(userInformationList.length);
// }
