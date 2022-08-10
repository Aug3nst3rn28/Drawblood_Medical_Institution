import 'package:cloud_firestore/cloud_firestore.dart';

class RequestAppointmentList {
  final String? uid;
  final String? request_id;
  final String? bloodtype;
  final String? status;
  final String? venue;
  final String? date;
  final String? time;

  RequestAppointmentList(
      {this.uid,
      this.request_id,
      this.bloodtype,
      this.status,
      this.venue,
      this.date,
      this.time});

  static RequestAppointmentList fromJson(Map<String, dynamic> snapshot) =>
      RequestAppointmentList(
        uid: snapshot['uid'],
        request_id: snapshot['request_id'],
        bloodtype: snapshot['bloodtype'],
        status: snapshot['status'],
        venue: snapshot['venue'],
        date: snapshot['date'],
        time: snapshot['time'],
      );

  factory RequestAppointmentList.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return RequestAppointmentList(
      uid: snapshot['uid'],
      request_id: snapshot['request_id'],
      bloodtype: snapshot['bloodtype'],
      status: snapshot['status'],
      venue: snapshot['venue'],
      date: snapshot['date'],
      time: snapshot['time'],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "request_id": request_id,
        "bloodtype": bloodtype,
        "status": status,
        "venue": venue,
        "date": date,
        "time": time,
      };
}
