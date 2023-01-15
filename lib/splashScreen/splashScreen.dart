import 'dart:async';

import 'package:bim493_finalhw/pages/courses.dart';
import 'package:flutter/material.dart';

import '../Authentication/signin_screen.dart';
import '../global/global.dart';
import '../home_screen.dart';



class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

  startTimer(){


    Timer(Duration(seconds: 3), () async {


        Navigator.push(context, MaterialPageRoute(builder: (c)=> const SignInScreen()));



    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white70,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/BikeAnimated.png", width: 219, height: 182,),
              const SizedBox(height: 10,),
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(' ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontFamily:   "SedgwickAveDisplay",
                  letterSpacing: 3,
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
