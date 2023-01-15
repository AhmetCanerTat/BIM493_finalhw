import 'package:bim493_finalhw/Authentication/signin_screen.dart';
import 'package:bim493_finalhw/pages/add_course.dart';
import 'package:bim493_finalhw/pages/courses.dart';

import 'package:bim493_finalhw/firebase_options.dart';
import 'package:bim493_finalhw/splashScreen/splashScreen.dart';
import 'package:bim493_finalhw/widgets/ortalama_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages/grade_details.dart';

import 'constants/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ortalama Hesapla',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Sabitler.anaRenk,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      darkTheme: ThemeData.dark(),
      home: SignInScreen(),
    );
  }
}
