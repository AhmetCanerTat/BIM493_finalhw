import 'package:bim493_finalhw/pages/courses.dart';


import 'package:flutter/material.dart';

import '../home_screen.dart';
import '../widgets/error_dialog.dart';

import '../widgets/reuseable_widget.dart';
import 'signup_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  formValidation() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      // login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (c) => const Courses(),
        ),
      );
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return const ErrorDialog(
              message: "Please write email/password.",
            );
          });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.12, 20, 0),
          child: Column(
            children: <Widget>[
              logoImage("assets/images/BikeAnimated.png"),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  ' ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontFamily: "Monoton",
                    letterSpacing: 3,
                  ),
                ),
              ),
              SizedBox(height: 20),
              reuseableTextField('Email', Icons.person_outline, false, true,
                  _emailTextController),
              SizedBox(height: 20),
              reuseableTextField('Password', Icons.lock_outline, true, true,
                  _passwordTextController),
              SizedBox(height: 40),
              signInSignOutButton(context, true, () {

                formValidation();
              }),
              SizedBox(height: 10),
              signUpOption(context)
            ],
          ),
        ),
      ),
    );
  }
}

Row signUpOption(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Don't have Account? ",
        style: TextStyle(color: Colors.black),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUpScreen()));
        },
        child: Text(
          "Sign Up",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}
