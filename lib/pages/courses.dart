import 'dart:convert';

import 'package:bim493_finalhw/main.dart';
import 'package:bim493_finalhw/pages/grade_details.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
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
    if (coursesJson != null) {
      List coursesList = jsonDecode(coursesJson);

      for (var course in coursesList) {
        setState(() {
          allCourses.add(Course.fromJson(course));
        });
      }
    }
  }

  double calculateAverage() {
    double gradeSum = 0;
    double creditSum = 0;
    allCourses.forEach((element) {
      gradeSum = gradeSum + (element.credit * element.letter);
      creditSum = creditSum + element.credit;
    });
    setState(() {});
    return (gradeSum / creditSum);
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text("DERSLER",
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ))),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Color.fromRGBO(33, 217, 233, 1),
                    Colors.white
                  ]),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(
                  flex: 2,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(('Genel Not'),
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Color.fromRGBO(48, 64, 98, 1),
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700),
                            )),
                        Text(
                            'Ortalamasi : ${calculateAverage().toStringAsFixed(2)}',
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Color.fromRGBO(48, 64, 98, 1),
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
          Expanded(
            flex: 3,
            child: allCourses.isNotEmpty
                ? ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: allCourses.length,
                    itemBuilder: ((context, index) => CourseCard(
                          course: allCourses[index],
                          allCourses: allCourses,
                          function: calculateAverage,
                        )))
                : Container(
                    margin: const EdgeInsets.all(24),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(('Lutfen ders ekleyiniz'),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: Sabitler.anaRenk)),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class CourseCard extends StatefulWidget {
  final Course course;
  final List<Course> allCourses;
  final void Function() function;
  const CourseCard({
    Key? key,
    required this.course,
    required this.allCourses,
    required this.function,
  }) : super(key: key);

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  Future<void> saveCourses() async {
    final prefs = await SharedPreferences.getInstance();
    List courses = widget.allCourses.map((e) => e.toJson()).toList();
    prefs.setString("courses", jsonEncode(courses));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GradeDetails(course: widget.course)))
            .then((value) {
          saveCourses();
          widget.function();
          setState(() {});
        });
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
                widget.course.gradeAverage != 0
                    ? (Text(widget.course.gradeAverage.toString(),
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: Color.fromRGBO(48, 64, 98, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        )))
                    : Text("tum notlar girilmemis")
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(top: 15),
                child: widget.course.gradeAverage != 0
                    ? (Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10)),
                        height: 10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.white,
                            color: Color.fromRGBO(33, 217, 233, 1),
                            value: widget.course.gradeAverage / 100,
                          ),
                        ),
                      ))
                    : null),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: widget.course.contents
                      .map((e) => Column(
                            children: [
                              Stack(alignment: Alignment.center, children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: CircularProgressIndicator(
                                    color: Color.fromRGBO(33, 217, 233, 1),
                                    value: e.grade / 100,
                                  ),
                                ),
                                Center(child: Text(e.grade.round().toString()))
                              ]),
                              Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(e.name))
                            ],
                          ))
                      .toList()),
            )
          ],
        ),
      ),
    );
  }
}
