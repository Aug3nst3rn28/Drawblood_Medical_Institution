import 'package:cloud_firestore/cloud_firestore.dart';

class AppoinmentList {
  final String? user_id;
  final String? venue;
  final String? status;
  final String? name;
  final String? bloodtype;
  final String? gender;
  final String? height;
  final String? weight;
  final DateTime? date;
  final DateTime? createdate;

  AppoinmentList(
      {this.user_id,
      this.venue,
      this.status,
      this.name,
      this.bloodtype,
      this.gender,
      this.height,
      this.weight,
      this.date,
      this.createdate});

  static AppoinmentList fromJson(Map<String, dynamic> snapshot) =>
      AppoinmentList(
        user_id: snapshot['user_id'],
        venue: snapshot['vanue'],
        status: snapshot['status'],
        name: snapshot['name'],
        bloodtype: snapshot['bloodtype'],
        gender: snapshot['gender'],
        height: snapshot['height'],
        weight: snapshot['weight'],
        date: snapshot['date'].toDate(),
        createdate: snapshot['createdate'].toDate(),
      );

  Map<String, dynamic> toJson() =>
      {"vanue": venue, "status": status, "createdate": createdate};

  factory AppoinmentList.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return AppoinmentList(
      user_id: snapshot['user_id'],
      venue: snapshot['vanue'],
      status: snapshot['status'],
      name: snapshot['name'],
      bloodtype: snapshot['bloodtype'],
      gender: snapshot['gender'],
      height: snapshot['height'],
      weight: snapshot['weight'],
      date: snapshot['date'].toDate(),
      createdate: snapshot['createdate'].toDate(),
    );
  }
}
