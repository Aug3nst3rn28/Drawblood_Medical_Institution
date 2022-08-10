import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/models/medical_data.dart';
import 'package:drawblood_medicalinstitution_app/firebase_info.dart';
import 'package:drawblood_medicalinstitution_app/main.dart';
import 'package:flutter/material.dart';

import '../drawbood_app_theme.dart';

List<MedicalModel> bloodListData = [];
List<String> bloodTypeData = <String>[
  'A+',
  'A-',
  'B+',
  'B-',
  'AB+',
  'AB-',
  'O+',
  'O-',
];
List<String?> bloodTypeStorage = <String?>[];
String? uid = '';

class BloodBankListView extends StatefulWidget {
  const BloodBankListView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;
  @override
  _BloodBankListViewState createState() => _BloodBankListViewState();
}

class _BloodBankListViewState extends State<BloodBankListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    uid = useruid();
    // getMedicalDataList(uid);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: FutureBuilder<MedicalModel?>(
                  future: FirestoreQuery.readMedicalInfo(uid),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: drawbloodAppTheme.red,
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          snapshot.error.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: drawbloodAppTheme.fontName,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              letterSpacing: 0.18,
                              color: drawbloodAppTheme.darkText),
                        ),
                      );
                    }

                    if (snapshot.hasData) {
                      final bloodstorageData = snapshot.data;
                      bloodTypeStorage = [
                        bloodstorageData?.apositive,
                        bloodstorageData?.anegative,
                        bloodstorageData?.bpositive,
                        bloodstorageData?.bnegative,
                        bloodstorageData?.abpositive,
                        bloodstorageData?.abnegative,
                        bloodstorageData?.opositive,
                        bloodstorageData?.onegative
                      ];
                      return GridView(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 24, bottom: 16),
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        children: List<Widget>.generate(
                          bloodTypeData.length,
                          (int index) {
                            final int count = bloodTypeData.length;
                            final Animation<double> animation =
                                Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                parent: animationController!,
                                curve: Interval((1 / count) * index, 1.0,
                                    curve: Curves.fastOutSlowIn),
                              ),
                            );
                            animationController?.forward();
                            return BloodBankView(
                              bloodtype: bloodTypeData[index],
                              bloodstorage: bloodTypeStorage[index],
                              animation: animation,
                              animationController: animationController!,
                            );
                          },
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16.0,
                          crossAxisSpacing: 16.0,
                          childAspectRatio: 1.0,
                        ),
                      );
                    }
                    return Center(
                        child: CircularProgressIndicator(
                      color: drawbloodAppTheme.red,
                    ));
                  }),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class BloodBankView extends StatelessWidget {
  const BloodBankView({
    Key? key,
    this.bloodtype,
    this.bloodstorage,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final String? bloodtype;
  final String? bloodstorage;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Container(
                decoration: BoxDecoration(
                  color: drawbloodAppTheme.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(8.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: drawbloodAppTheme.grey.withOpacity(0.4),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Scaffold(
                    body: Center(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Image.asset(
                            'assets/drawblood_app/blooddrop.png',
                            height: 85,
                            width: 85,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          '$bloodtype',
                          style: TextStyle(
                            fontFamily: drawbloodAppTheme.fontName,
                            fontWeight: FontWeight.w600,
                            fontSize: bloodtype == 'AB+' || bloodtype == 'AB-'
                                ? 18
                                : 24,
                            color: drawbloodAppTheme.white,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              'Storage left: $bloodstorage',
                              style: TextStyle(
                                fontFamily: drawbloodAppTheme.fontName,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: drawbloodAppTheme.darkText,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 10,
                              width: 130,
                              decoration: BoxDecoration(
                                color: HexColor('#FF797A').withOpacity(0.2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width:
                                        ((int.parse(bloodstorage.toString()) /
                                                3 /
                                                1.2) *
                                            animation!.value),
                                    height: 10,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        HexColor('#FF797A'),
                                        HexColor('#FF797A').withOpacity(0.5),
                                      ]),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))),
          ),
        );
      },
    );
  }
}

// void getMedicalDataList(uid) async {
//   final db = FirebaseFirestore.instance;
//   final docRef = db.collection("user").doc(uid);
//   docRef.get().then(
//     (DocumentSnapshot doc) {
//       final data = doc.data() as Map<String, dynamic>;
//       bloodTypeStorage = [
//         data['apositive'],
//         data['anegative'],
//         data['bpositive'],
//         data['bnegative'],
//         data['abpositive'],
//         data['abnegative'],
//         data['opositive'],
//         data['onegative']
//       ];
//     },
//     onError: (e) => print("Error getting document: $e"),
//   );
// }
