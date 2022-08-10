import 'package:drawblood_medicalinstitution_app/drawblood_app/Signup/components/background.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/addinfo/addinfo.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/components/rounded_button.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/components/rounded_input_field.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/components/rounded_password_field.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/drawbood_app_theme.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/login_page/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  String email = "";
  String pss = "";

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final pssController = TextEditingController();
    final database = FirebaseDatabase.instance.reference();
    final userRef = database.child('user');
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Drawblood",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              icon: Icons.person,
              hintText: "Your Email",
              onChanged: (text) {
                email = text;
              },
              controller: emailController,
            ),
            RoundedPasswordField(
              onChanged: (text) {
                pss = text;
              },
              controller: pssController,
            ),
            RoundedButton(
              text: "SIGNUP",
              press: signUp,
            ),
            SizedBox(height: size.height * 0.03),
            RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.grey, fontSize: 20.0),
                  children: <TextSpan>[
                    TextSpan(text: "Already have account? "),
                    TextSpan(
                        text: "Log In",
                        style: TextStyle(color: drawbloodAppTheme.red),
                        recognizer: TapGestureRecognizer()
                          ..onTap = (() => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const LoginScreen();
                                  },
                                ),
                              )))
                  ]),
            )
          ],
        ),
      ),
    );
  }

  Future signUp() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pss);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => addinfoScreen()),
      );
    } on FirebaseAuthException catch (e) {
      Opendialog(e.toString());
      Fluttertoast.showToast(msg: e.toString(), timeInSecForIosWeb: 25);
    }
  }

  Future Opendialog(e) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(e),
            actions: [TextButton(onPressed: close, child: Text('close'))],
          ));

  void close() {
    Navigator.of(context).pop();
  }
}
