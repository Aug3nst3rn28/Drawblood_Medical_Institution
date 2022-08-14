import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/models/medical_data.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/models/request_appoinment_data.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/models/reward_list_data.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/models/user_appointment_list_data.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/models/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

String? useruid() {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final user = auth.currentUser;
  final uid = user?.uid;
  return uid;
}

String? useremail() {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final user = auth.currentUser;
  final email = user?.email;
  return email;
}

class FirestoreQuery {
  static Future<UserModel?> readUserInfo(uid) async {
    final medicalCollection =
        FirebaseFirestore.instance.collection("user").doc(uid);
    final snapshot = await medicalCollection.get();
    if (snapshot.exists) {
      return UserModel.fromJson(snapshot.data()!);
    }
  }

  static Future<MedicalModel?> readMedicalInfo(uid) async {
    final medicalCollection =
        FirebaseFirestore.instance.collection("user").doc(uid);
    final snapshot = await medicalCollection.get();
    if (snapshot.exists) {
      return MedicalModel.fromJson(snapshot.data()!);
    }
  }

  static Future<appoint?> readUserapp(uid) async {
    final userCollection = FirebaseFirestore.instance
        .collection("user")
        .doc(uid)
        .collection("appointment")
        .doc('appoit');
    final snapshot = await userCollection.get();
    if (snapshot.exists) {
      return appoint.fromJson(snapshot.data()!);
    }
  }

  static Future createRequstAppoiment(
      RequestAppointmentList requestAppointmentList) async {
    final requestAppointmentCollection =
        FirebaseFirestore.instance.collection("request_appointment");
    final docRef = requestAppointmentCollection.doc();

    final newrequestAppointment = RequestAppointmentList(
            uid: requestAppointmentList.uid,
            request_id: requestAppointmentList.request_id,
            bloodtype: requestAppointmentList.bloodtype,
            status: requestAppointmentList.status,
            date: requestAppointmentList.date,
            time: requestAppointmentList.time,
            venue: requestAppointmentList.venue)
        .toJson();

    try {
      await docRef.set(newrequestAppointment);
    } catch (e) {
      print("Some error occured: $e");
    }
  }

  static Stream<List<AppoinmentList>> getUserAppointmentList(
      medicalInformation) {
    final appointmentCollection = FirebaseFirestore.instance
        .collection("appoinment")
        .where('vanue', isEqualTo: medicalInformation)
        .orderBy('date', descending: true);
    return appointmentCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => AppoinmentList.fromSnapshot(e)).toList());
  }

  static Future updateRequestStatus(uid, request_id, status) async {
    dynamic documentID = '';
    final data = await FirebaseFirestore.instance
        .collection("request_appointment")
        .where('uid', isEqualTo: uid)
        .where('request_id', isEqualTo: request_id)
        .get();

    if (data.docs.isNotEmpty) {
      documentID = data.docs[0].id;
      final requestCollection =
          FirebaseFirestore.instance.collection("request_appointment");
      final docRef = requestCollection.doc(documentID);

      try {
        await docRef.update({"status": status});
      } catch (e) {
        print("Some error occured: $e");
      }
    }
  }
}
