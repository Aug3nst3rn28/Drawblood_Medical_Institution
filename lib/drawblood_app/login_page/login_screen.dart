import 'package:drawblood_medicalinstitution_app/drawblood_app/drawblood_app_home_screen.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/login_page/components/body/body_mobile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DrawBloodAppHomeScreen();
        } else {
          return Login_page();
        }
      },
    ));
  }
}
