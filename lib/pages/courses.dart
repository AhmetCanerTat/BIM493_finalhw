import 'package:bim493_finalhw/main.dart';
import 'package:bim493_finalhw/widgets/enter_course.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class Courses extends StatelessWidget {
  const Courses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Course(),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class Course extends StatefulWidget {
  const Course({
    Key? key,
  }) : super(key: key);

  @override
  State<Course> createState() => _CourseState();
}

class _CourseState extends State<Course> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Lineer Algebra",
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      color: Color.fromRGBO(48, 64, 98, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                )),
            Text("49%",
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      color: Color.fromRGBO(48, 64, 98, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ))
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10)),
            height: 10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const LinearProgressIndicator(
                backgroundColor: Colors.white,
                color: Color.fromRGBO(33, 217, 233, 1),
                value: 0.8,
              ),
            ),
          ),
        )
      ],
    );
  }
}
