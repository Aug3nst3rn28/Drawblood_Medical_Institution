import 'package:cloud_firestore/cloud_firestore.dart';

class MedicalModel {
  final String? name;
  final String? phonenumber;
  final String? apositive;
  final String? anegative;
  final String? bpositive;
  final String? bnegative;
  final String? abpositive;
  final String? abnegative;
  final String? opositive;
  final String? onegative;

  MedicalModel({
    this.name,
    this.phonenumber,
    this.apositive,
    this.anegative,
    this.bpositive,
    this.bnegative,
    this.abpositive,
    this.abnegative,
    this.opositive,
    this.onegative,
  });

  static MedicalModel fromJson(Map<String, dynamic> snapshot) => MedicalModel(
        name: snapshot['name'],
        phonenumber: snapshot['phonenumber'],
        apositive: snapshot['apositive'],
        anegative: snapshot['anegative'],
        bpositive: snapshot['bpositive'],
        bnegative: snapshot['bnegative'],
        abpositive: snapshot['abpositive'],
        abnegative: snapshot['abnegative'],
        opositive: snapshot['opositive'],
        onegative: snapshot['onegative'],
      );

  factory MedicalModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return MedicalModel(
      name: data?['name'],
      phonenumber: data?['phonenumber'],
      apositive: data?['apositive'],
      anegative: data?['anegative'],
      bpositive: data?['bpositive'],
      bnegative: data?['bnegative'],
      abpositive: data?['abpositive'],
      abnegative: data?['abnegative'],
      opositive: data?['opositive'],
      onegative: data?['onegative'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (phonenumber != null) "phonenumber": phonenumber,
      if (apositive != null) "apositive": apositive,
      if (anegative != null) "anegative": anegative,
      if (bpositive != null) "bpositive": bpositive,
      if (bnegative != null) "bnegative": bnegative,
      if (abpositive != null) "bpositive": bpositive,
      if (abnegative != null) "bnegative": bnegative,
      if (opositive != null) "bpositive": bpositive,
      if (onegative != null) "bnegative": bnegative,
    };
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "phonenumber": phonenumber,
        "apositive": apositive,
        "anegative": anegative,
        "bpositive": bpositive,
        "bnegative": bnegative,
        "abpositive": abpositive,
        "abnegative": abnegative,
        "opositive": opositive,
        "onegative": onegative
      };
}
