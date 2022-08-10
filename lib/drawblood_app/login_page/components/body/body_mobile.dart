import 'package:drawblood_medicalinstitution_app/drawblood_app/Signup/signup_screen.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/components/rounded_button.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/components/rounded_input_field.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/components/rounded_password_field.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/drawbood_app_theme.dart';
import 'package:drawblood_medicalinstitution_app/drawblood_app/login_page/components/background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Login_page extends StatefulWidget {
  const Login_page({
    Key? key,
  }) : super(key: key);

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  final emailController = TextEditingController();
  final pssController = TextEditingController();
  String email = "";
  String pss = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Log In",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
            ),
            Image.asset(
              'assets/introduction/Logo.png',
              width: size.width * 0.6,
            ),
            SizedBox(height: size.height * 0.03),
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
            RoundedButton(text: "LOGIN", press: signIn),
            SizedBox(height: size.height * 0.03),
            RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.grey, fontSize: 20.0),
                  children: <TextSpan>[
                    TextSpan(text: "Haven't create account? "),
                    TextSpan(
                        text: "Sign Up",
                        style: TextStyle(color: drawbloodAppTheme.red),
                        recognizer: TapGestureRecognizer()
                          ..onTap = (() => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const SignUpScreen();
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

  Future signIn() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pss);
    } on FirebaseAuthException catch (error) {
      print(error);
      Opendialog(error.toString());
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
