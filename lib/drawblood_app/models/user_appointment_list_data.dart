import 'package:cloud_firestore/cloud_firestore.dart';

class AppoinmentList {
  final String? user_id;
  final String? venue;
  final String? status;
  final DateTime? date;
  final DateTime? createdate;

  AppoinmentList(
      {this.user_id, this.venue, this.status, this.date, this.createdate});

  static AppoinmentList fromJson(Map<String, dynamic> snapshot) =>
      AppoinmentList(
        venue: snapshot['vanue'],
        status: snapshot['status'],
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
      date: snapshot['date'].toDate(),
    );
  }
}
