import 'dart:convert';

import 'package:bim493_finalhw/main.dart';
import 'package:bim493_finalhw/pages/grade_details.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/course.dart';

class Courses extends StatefulWidget {
  const Courses({
    Key? key,
  }) : super(key: key);

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  final List<Course> allCourses = [];
  void getCourses() async {
    final prefs = await SharedPreferences.getInstance();
    String? coursesJson = prefs.getString('courses');
    List coursesList = jsonDecode(coursesJson ?? "");

    for (var course in coursesList) {
      setState(() {
        allCourses.add(Course.fromJson(course));
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text(allCourses.first.contents.first.grade.toString()),
        // ),
        body: !allCourses.isEmpty
            ? ListView.builder(
                itemCount: allCourses.length,
                itemBuilder: ((context, index) =>
                    CourseCard(course: allCourses[index])))
            : null);
  }
}

class CourseCard extends StatefulWidget {
  final Course course;
  const CourseCard({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GradeDetails(course: widget.course)));
      },
      child: Padding(
        padding: EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.course.name,
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Color.fromRGBO(48, 64, 98, 1),
                          fontSize: 15,
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
              padding: const EdgeInsets.only(top: 15),
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
        ),
      ),
    );
  }
}
