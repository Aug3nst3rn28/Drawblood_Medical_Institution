import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/drawbood_app_theme.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/models/user_reward_list_data.dart';
import 'package:drawblood_medicalinstitution_app/firebase_info.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

List<UserRewardList> userRewardList = [];
List<UserRewardList> categoriesRewardList = [];
List<UserRewardList> categoriesUserRewardList = [];

class MyRewardView extends StatefulWidget {
  @override
  MyRewardViewState createState() => MyRewardViewState();
}

class MyRewardViewState extends State<MyRewardView> {
  int _value = 1;
  var data = '';
  String? uid = '';

  @override
  void initState() {
    uid = useruid();
    getUserRewardList(uid);
    _searchCategory(1);
    super.initState();
  }

  void _searchCategory(value) {
    if (value == 1) {
      data = 'All';
    } else if (value == 2) {
      data = 'Active';
    } else if (value == 3) {
      data = 'Used';
    }

    setState(() {
      if (data == 'Active') {
        categoriesRewardList = userRewardList
            .where((element) => element.status == 'active')
            .toList();
      } else if (data == 'Used') {
        categoriesRewardList = userRewardList
            .where((element) => element.status == 'used')
            .toList();
      } else {
        categoriesRewardList = userRewardList;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: drawbloodAppTheme.background,
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, top: 50.0, bottom: 25.0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back)),
                    Text(
                      'My Reward',
                      style: TextStyle(
                        fontFamily: drawbloodAppTheme.fontName,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 0.18,
                        color: drawbloodAppTheme.darkerText,
                      ),
                    ),
                  ],
                ),
              ),
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
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          boxShadow: [
                            BoxShadow(
                              color: drawbloodAppTheme.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5.0),
                        child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 5.0),
                          child: DropdownButton(
                              hint: Text('Category'),
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
                                    "Active",
                                  ),
                                  value: 2,
                                ),
                                DropdownMenuItem(
                                    child: Text(
                                      "Used",
                                    ),
                                    value: 3),
                              ],
                              onChanged: (int? value) {
                                setState(() {
                                  _value = value!;
                                  _searchCategory(_value);
                                });
                              }),
                        )),
                      ))
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: categoriesRewardList.isNotEmpty
                        ? categoriesRewardList.length
                        : 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (categoriesRewardList.isEmpty) {
                        return Center(
                          child: Text(
                              'The section is currently empty. \n Donate more to earn more rewards.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: drawbloodAppTheme.fontName,
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                                letterSpacing: -0.1,
                                color: drawbloodAppTheme.grey.withOpacity(0.8),
                              )),
                        );
                      } else {
                        return _userRewardListWidget(
                            categoriesRewardList[index]);
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userRewardListWidget(UserRewardList list) {
    return Material(
        child: Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: list.status == 'active'
              ? drawbloodAppTheme.white
              : drawbloodAppTheme.grey.withOpacity(0.2),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topRight: Radius.circular(8.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: list.status == 'active'
                    ? drawbloodAppTheme.grey.withOpacity(0.2)
                    : drawbloodAppTheme.white,
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
                            image: list.status == 'active'
                                ? AssetImage(
                                    "assets/drawblood_app/reward_default.png")
                                : AssetImage(
                                    "assets/drawblood_app/reward_default_grayscale.png"))),
                  ),
                  title: Text(
                    list.reward_name.toString(),
                    style: TextStyle(
                      fontFamily: drawbloodAppTheme.fontName,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 0.18,
                      color: drawbloodAppTheme.darkerText,
                    ),
                  ),
                  subtitle: Text(
                    list.description.toString(),
                    style: TextStyle(
                      fontFamily: drawbloodAppTheme.fontName,
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      letterSpacing: 0.18,
                      color: drawbloodAppTheme.grey.withOpacity(0.6),
                    ),
                  ),
                  trailing: Container(
                    height: 32,
                    width: 87,
                    child: list.status == 'active'
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: drawbloodAppTheme.red,
                              shape: StadiumBorder(),
                            ),
                            onPressed: () {
                              setState(() {
                                getUserRewardList(uid);
                              });
                              Fluttertoast.showToast(
                                  msg: "The Reward Marked as Used.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: drawbloodAppTheme.background,
                                  textColor: drawbloodAppTheme.darkText,
                                  fontSize: 16.0);
                            },
                            child: Text(
                              "Mark \n as Used",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: drawbloodAppTheme.fontName,
                                fontSize: 14,
                                letterSpacing: 0.18,
                                color: drawbloodAppTheme.white,
                              ),
                            ))
                        : Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text('Used',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: drawbloodAppTheme.fontName,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  letterSpacing: 0.18,
                                  color: drawbloodAppTheme.darkText,
                                )),
                          ),
                  ),
                ),
              ],
            )),
      ),
    ));
  }
}

void getUserRewardList(uid) async {
  final db = FirebaseFirestore.instance;
  final docRef = db
      .collection("user_reward_list")
      .where('uid', isEqualTo: uid)
      .orderBy('timestamp', descending: true);
  var snapshot = await docRef.get();
  if (userRewardList.isNotEmpty) {
    userRewardList.clear();
  }
  if (snapshot.docs.isNotEmpty) {
    for (DocumentSnapshot results in snapshot.docs) {
      Map<String, dynamic> data = results.data() as Map<String, dynamic>;
      userRewardList.add(UserRewardList(
          uid: data['uid'],
          redeem_id: data['redeem_id'],
          reward_name: data['reward_name'],
          status: data['status'],
          description: data['description'],
          timestamp: data['timestamp']));
    }
  }
}
