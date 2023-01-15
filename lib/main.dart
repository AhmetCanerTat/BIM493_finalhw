
import 'package:bim493_finalhw/splashScreen/splashScreen.dart';

import 'package:flutter/material.dart';
import 'pages/grade_details.dart';

import 'constants/app_constants.dart';

void main() async {

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
      //themeMode: ThemeMode.dark,
      home: MySplashScreen(),
    );
  }
}
