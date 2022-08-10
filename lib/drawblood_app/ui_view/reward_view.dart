import 'package:drawblood_medicalinstitution_app/drawblood_app/models/user_data.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/ui_view/my_reward_page_view.dart';
import 'package:drawblood_medicalinstitution_app/firebase_info.dart';

import '../drawbood_app_theme.dart';

import 'package:flutter/material.dart';

String? uid = '';

class RewardView extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const RewardView({Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  State<RewardView> createState() => _RewardViewState();
}

class _RewardViewState extends State<RewardView> {
  void initState() {
    super.initState();
    uid = useruid();
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
                child: FutureBuilder<UserModel?>(
                  future: FirestoreQuery.readUserInfo(uid),
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
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/drawblood_app/reward_bckgrd.jpg"),
                            fit: BoxFit.cover,
                          ),
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
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'AVAILABLE POINTS',
                                          style: TextStyle(
                                            fontFamily:
                                                drawbloodAppTheme.fontName,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            letterSpacing: 0.18,
                                            color: drawbloodAppTheme.nearlyWhite
                                                .withOpacity(0.85),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "${userData?.point}",
                                              style: TextStyle(
                                                fontFamily:
                                                    drawbloodAppTheme.fontName,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 35,
                                                letterSpacing: 0.18,
                                                color: drawbloodAppTheme.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: (() {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MyRewardView() //here pass the actual values of these variables, for example false if the payment isn't successfull..etc
                                                      ),
                                                );
                                              }),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 3.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "My Reward",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            drawbloodAppTheme
                                                                .fontName,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                        letterSpacing: 0.18,
                                                        color: drawbloodAppTheme
                                                            .white,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 1.0),
                                                      child: InkWell(
                                                        onTap: (() {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        MyRewardView() //here pass the actual values of these variables, for example false if the payment isn't successfull..etc
                                                                ),
                                                          );
                                                        }),
                                                        child: Icon(
                                                          Icons
                                                              .arrow_forward_ios_outlined,
                                                          color:
                                                              drawbloodAppTheme
                                                                  .white,
                                                          size: 16,
                                                        ),
                                                      ),
                                                    )
                                                  ],
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
