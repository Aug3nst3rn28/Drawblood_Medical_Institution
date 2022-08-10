import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/models/reward_list_data.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/models/user_reward_list_data.dart';
import 'package:drawblood_medicalinstitution_app/firebase_info.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import '../drawbood_app_theme.dart';
import 'package:flutter/material.dart';

String? uid = '';
String point = '';

class RewardListView extends StatefulWidget {
  const RewardListView({Key? key, this.animationController, this.animation})
      : super(key: key);

  final Animation<double>? animation;
  final AnimationController? animationController;

  @override
  State<RewardListView> createState() => _RewardListViewState();
}

class _RewardListViewState extends State<RewardListView> {
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
                child: StreamBuilder<List<RewardModel>>(
                  stream: FirestoreQuery.readReward(),
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
                      final rewardData = snapshot.data;
                      return Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: rewardData!.length,
                              itemBuilder: (context, index) {
                                final rewardInfo = rewardData[index];
                                return Container(
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
                                          color: drawbloodAppTheme.grey
                                              .withOpacity(0.2),
                                          offset: Offset(1.1, 1.1),
                                          blurRadius: 10.0),
                                    ],
                                  ),
                                  child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      child: ListTile(
                                        leading: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/drawblood_app/reward_default.png"))),
                                        ),
                                        title: Text(
                                          "${rewardInfo.reward_name}",
                                          style: TextStyle(
                                            fontFamily:
                                                drawbloodAppTheme.fontName,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            letterSpacing: 0.18,
                                            color: drawbloodAppTheme.darkerText,
                                          ),
                                        ),
                                        subtitle: Text(
                                          "${rewardInfo.description}",
                                          style: TextStyle(
                                            fontFamily:
                                                drawbloodAppTheme.fontName,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14,
                                            letterSpacing: 0.18,
                                            color: drawbloodAppTheme.grey
                                                .withOpacity(0.6),
                                          ),
                                        ),
                                        trailing: Container(
                                          height: 30,
                                          width: 60,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: drawbloodAppTheme.red,
                                                shape: StadiumBorder(),
                                              ),
                                              onPressed: () {
                                                getUserPoint(uid);
                                                if (point != '') {
                                                  int userPoint =
                                                      int.parse(point);
                                                  int redeem_point = int.parse(
                                                      rewardInfo.redeem_point ??
                                                          "");
                                                  if (userPoint >=
                                                      redeem_point) {
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (context) =>
                                                                AlertDialog(
                                                                  title:
                                                                      const Text(
                                                                    'Redeem Confirmation',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          drawbloodAppTheme
                                                                              .fontName,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          20,
                                                                      letterSpacing:
                                                                          -0.1,
                                                                      color: drawbloodAppTheme
                                                                          .darkText,
                                                                    ),
                                                                  ),
                                                                  content: Text(
                                                                    "Are you sure you want to redeem ${rewardInfo.reward_name} ?",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          drawbloodAppTheme
                                                                              .fontName,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          16,
                                                                      letterSpacing:
                                                                          -0.1,
                                                                      color: drawbloodAppTheme
                                                                          .darkText,
                                                                    ),
                                                                  ),
                                                                  actions: <
                                                                      Widget>[
                                                                    TextButton(
                                                                      onPressed:
                                                                          () =>
                                                                              {
                                                                        userPoint -=
                                                                            redeem_point,
                                                                        point =
                                                                            userPoint.toString(),
                                                                        Navigator.pop(
                                                                            context,
                                                                            'Yes'),
                                                                        Fluttertoast.showToast(
                                                                            msg:
                                                                                "Successfully Redeemed the Reward.",
                                                                            toastLength: Toast
                                                                                .LENGTH_SHORT,
                                                                            gravity: ToastGravity
                                                                                .BOTTOM,
                                                                            timeInSecForIosWeb:
                                                                                1,
                                                                            backgroundColor:
                                                                                drawbloodAppTheme.background,
                                                                            textColor: drawbloodAppTheme.darkText,
                                                                            fontSize: 16.0),
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        'Yes',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              drawbloodAppTheme.fontName,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontSize:
                                                                              16,
                                                                          letterSpacing:
                                                                              -0.1,
                                                                          color:
                                                                              drawbloodAppTheme.red,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed: () => Navigator.pop(
                                                                          context,
                                                                          'No'),
                                                                      child:
                                                                          Text(
                                                                        'No',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              drawbloodAppTheme.fontName,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontSize:
                                                                              16,
                                                                          letterSpacing:
                                                                              -0.1,
                                                                          color: drawbloodAppTheme
                                                                              .grey
                                                                              .withOpacity(0.6),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ));
                                                  } else {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            AlertDialog(
                                                              title: const Text(
                                                                'Insufficient Point',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      drawbloodAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 20,
                                                                  letterSpacing:
                                                                      -0.1,
                                                                  color: drawbloodAppTheme
                                                                      .darkText,
                                                                ),
                                                              ),
                                                              content: Text(
                                                                "Sorry, you do not have enough point to redeem ${rewardInfo.reward_name}. Please donate more to earn the point.",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      drawbloodAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 16,
                                                                  letterSpacing:
                                                                      -0.1,
                                                                  color: drawbloodAppTheme
                                                                      .darkText,
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          'OK'),
                                                                  child:
                                                                      const Text(
                                                                    'OK',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          drawbloodAppTheme
                                                                              .fontName,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          16,
                                                                      letterSpacing:
                                                                          -0.1,
                                                                      color: drawbloodAppTheme
                                                                          .red,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ));
                                                  }
                                                } else {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                            title: const Text(
                                                              'Error',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    drawbloodAppTheme
                                                                        .fontName,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20,
                                                                letterSpacing:
                                                                    -0.1,
                                                                color:
                                                                    drawbloodAppTheme
                                                                        .darkText,
                                                              ),
                                                            ),
                                                            content: Text(
                                                              "Sorry, something is going wrong. Please try again later.",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    drawbloodAppTheme
                                                                        .fontName,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 16,
                                                                letterSpacing:
                                                                    -0.1,
                                                                color:
                                                                    drawbloodAppTheme
                                                                        .darkText,
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context,
                                                                        'OK'),
                                                                child:
                                                                    const Text(
                                                                  'OK',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        drawbloodAppTheme
                                                                            .fontName,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        16,
                                                                    letterSpacing:
                                                                        -0.1,
                                                                    color:
                                                                        drawbloodAppTheme
                                                                            .red,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ));
                                                }
                                              },
                                              child: Text(
                                                "${rewardInfo.redeem_point}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: drawbloodAppTheme
                                                      .fontName,
                                                  fontSize: 14,
                                                  letterSpacing: 0.18,
                                                  color:
                                                      drawbloodAppTheme.white,
                                                ),
                                              )),
                                        ),
                                      )),
                                );
                              }));
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

getUserPoint(uid) {
  final db = FirebaseFirestore.instance;
  final docRef = db.collection("user").doc(uid);
  String? userPoint;
  docRef.get().then(
    (DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      point = data['point'];
    },
    onError: (e) => print("Error getting document: $e"),
  );
}
