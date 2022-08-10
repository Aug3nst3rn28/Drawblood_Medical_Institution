import 'package:drawblood_medicalinstitution_app/firebase_info.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../drawbood_app_theme.dart';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class LogoutView extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const LogoutView({Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  State<LogoutView> createState() => _LogoutViewState();
}

class _LogoutViewState extends State<LogoutView> {
  void initState() {
    super.initState();
    final uid = useruid();
    print(uid);
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
                child: InkWell(
                    child: Container(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        children: [
                                          Icon(
                                            Icons.logout,
                                            color: drawbloodAppTheme.grey,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Logout',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily:
                                                  drawbloodAppTheme.fontName,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              letterSpacing: 0.18,
                                              color:
                                                  drawbloodAppTheme.darkerText,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ]),
                              ))
                            ]),
                          )
                        ],
                      ),
                    ),
                    onTap: () => FirebaseAuth.instance.signOut())),
          ),
        );
      },
    );
  }
}
