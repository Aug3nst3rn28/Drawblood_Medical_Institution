import 'package:drawblood_medicalinstitution_app/drawblood_app/addinfo/components/body/body_mobile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class addinfoScreen extends StatelessWidget {
  const addinfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: addinfo());
  }
}
