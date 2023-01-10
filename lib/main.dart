import 'package:bim493_finalhw/pages/add_course.dart';
import 'package:bim493_finalhw/pages/courses.dart';
import 'package:bim493_finalhw/widgets/enter_course.dart';
import 'package:bim493_finalhw/widgets/ortalama_app.dart';
import 'package:flutter/material.dart';
import 'pages/grade_details.dart';

import 'constants/app_constants.dart';

void main() {
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
      home: Courses(),
    );
  }
}
