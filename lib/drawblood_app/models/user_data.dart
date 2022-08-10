import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawblood_medicalinstitution_app/firebase_info.dart';

class UserModel {
  final String? name;
  final String? bloodtype;
  final String? gender;
  final String? height;
  final String? phonenum;
  final String? point;
  final String? weight;
  final DateTime? lastapp;
  final String? status;

  UserModel(
      {this.name,
      this.bloodtype,
      this.gender,
      this.height,
      this.phonenum,
      this.point,
      this.weight,
      this.lastapp,
      this.status});

  static UserModel fromJson(Map<String, dynamic> snapshot) => UserModel(
      name: snapshot['name'],
      bloodtype: snapshot['bloodtype'],
      gender: snapshot['gender'],
      height: snapshot['height'],
      phonenum: snapshot['phonenum'],
      point: snapshot['point'],
      weight: snapshot['weight'],
      lastapp: snapshot['lastapp'].toDate(),
      status: snapshot['status']);

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      name: data?['name'],
      bloodtype: data?['bloodtype'],
      gender: data?['gender'],
      height: data?['height'],
      phonenum: data?['phonenum'],
      point: data?['point'],
      weight: data?['weight'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (bloodtype != null) "bloodtype": bloodtype,
      if (gender != null) "gender": gender,
      if (height != null) "height": height,
      if (phonenum != null) "phonenum": phonenum,
      if (point != null) "point": point,
      if (weight != null) "weight": weight,
    };
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "bloodtype": bloodtype,
        "gender": gender,
        "height": height,
        "phonenum": phonenum,
        "point": point,
        "weight": weight,
        "lastapp": lastapp
      };
}

class appoint {
  final String? vanue;
  final String? status;
  final DateTime? date;
  final DateTime? createdate;

  appoint({this.vanue, this.status, this.date, this.createdate});

  static appoint fromJson(Map<String, dynamic> snapshot) => appoint(
        vanue: snapshot['vanue'],
        status: snapshot['status'],
        date: snapshot['date'].toDate(),
        createdate: snapshot['createdate'].toDate(),
      );

  Map<String, dynamic> toJson() =>
      {"vanue": vanue, "status": status, "createdate": createdate};
}
