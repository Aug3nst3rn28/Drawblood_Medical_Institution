import 'package:drawblood_medicalinstitution_app/drawblood_app/models/medical_data.dart';
import 'package:drawblood_medicalinstitution_app/firebase_info.dart';

import '../drawbood_app_theme.dart';

import 'package:flutter/material.dart';
import 'dart:math' as math;

String? uid = '';
String? email = '';

class ProfileView extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const ProfileView({Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  void initState() {
    super.initState();
    uid = useruid();
    email = useremail();
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
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 18),
                child: FutureBuilder<MedicalModel?>(
                  future: FirestoreQuery.readMedicalInfo(uid),
                  builder: (context, snapshot) {
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
                      final userData = snapshot.data;
                      return Container(
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
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16, left: 16, right: 16, bottom: 16),
                              child: Row(children: <Widget>[
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8, top: 4),
                                  child: Column(children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        CircleAvatar(
                                          radius: 42.0,
                                          backgroundColor: Color(0xff000000)
                                              .withOpacity(0.3),
                                          child: CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  'assets/drawblood_app/profile.png'),
                                              radius: 40.0),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: 8),
                                          child: Text(
                                            "${userData?.name}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  drawbloodAppTheme.fontName,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                              letterSpacing: -0.1,
                                              color: drawbloodAppTheme.darkText,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 16, bottom: 12),
                                          child: Text(
                                            'Personal Information',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  drawbloodAppTheme.fontName,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              letterSpacing: 0.18,
                                              color:
                                                  drawbloodAppTheme.darkerText,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: 14),
                                          child: Text(
                                            'Email',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  drawbloodAppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              letterSpacing: -0.1,
                                              color: drawbloodAppTheme.grey
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: 8),
                                          child: Text(
                                            "$email",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  drawbloodAppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              letterSpacing: -0.1,
                                              color: drawbloodAppTheme.darkText,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: 20),
                                          child: Text(
                                            'Phone Number',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  drawbloodAppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              letterSpacing: -0.1,
                                              color: drawbloodAppTheme.grey
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: 8),
                                          child: Text(
                                            "${userData?.phonenumber}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  drawbloodAppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              letterSpacing: -0.1,
                                              color: drawbloodAppTheme.darkText,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ]),
                                ))
                              ]),
                            )
                          ],
                        ),
                      );
                    }
                    return Center(
                        child: CircularProgressIndicator(
                      color: drawbloodAppTheme.red,
                    ));
                  },
                )),
          ),
        );
      },
    );
  }
}
