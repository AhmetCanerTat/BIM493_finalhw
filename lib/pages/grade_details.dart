import 'dart:ffi';

import 'package:bim493_finalhw/model/course.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_constants.dart';
import '../helper/data_helper.dart';
import '../model/content.dart';

class GradeDetails extends StatefulWidget {
  final Course course;

  GradeDetails({super.key, required this.course});

  @override
  State<GradeDetails> createState() => _GradeDetailsState();
}

class _GradeDetailsState extends State<GradeDetails> {
  late bool AllGradesEntered = false;

  double credit = 1;
  double gradeAverage() {
    double gradeAverage = 0;
    for (Content content in widget.course.contents) {
      gradeAverage += content.calculate();
    }
    widget.course.gradeAverage = gradeAverage;
    return gradeAverage;
  }

  void isAllGradesEntered() {
    for (Content content in widget.course.contents) {
      if (content.grade == 0.0) {
        AllGradesEntered = false;
      } else {
        AllGradesEntered = true;
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    isAllGradesEntered();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text("NOTLAR",
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
            flex: 2,
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
                    const Spacer(
                      flex: 2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: AllGradesEntered
                          ? (Text((gradeAverage().toStringAsFixed(2)),
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Color.fromRGBO(48, 64, 98, 1),
                                    fontSize: 40,
                                    fontWeight: FontWeight.w700),
                              )))
                          : null,
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        widget.course.name,
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Color.fromRGBO(48, 64, 98, 1),
                                fontSize: 30,
                                fontWeight: FontWeight.w700)),
                      ),
                    )),
                    Row(
                      children: [
                        Spacer(),
                        Column(
                          children: [
                            Text('Harf Notu'),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                alignment: Alignment.bottomRight,
                                decoration: BoxDecoration(
                                  color: Sabitler.anaRenk.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: DropdownButton<double>(
                                  iconEnabledColor: Sabitler.anaRenk,
                                  elevation: 16,
                                  items: DataHelper.allCourseLetters(),
                                  underline: Container(),
                                  onChanged: (letter) {
                                    setState(() {
                                      widget.course.letter = letter!;
                                    });
                                  },
                                  value: widget.course.letter,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text('Kredi'),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Sabitler.anaRenk.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: DropdownButton<double>(
                                  iconEnabledColor: Sabitler.anaRenk,
                                  elevation: 16,
                                  items: DataHelper.allCredits(),
                                  underline: Container(),
                                  onChanged: (credit) {
                                    setState(() {
                                      widget.course.credit = credit!;
                                    });
                                  },
                                  value: widget.course.credit,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                )),
          ),
          Expanded(
            flex: 3,
            child: !widget.course.contents.isEmpty
                ? ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: widget.course.contents.length,
                    itemBuilder: (context, index) => GradeCard(
                        content: widget.course.contents[index],
                        function: isAllGradesEntered),
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}

class GradeCard extends StatefulWidget {
  final Content content;
  final void Function() function;
  const GradeCard({super.key, required this.content, required this.function});

  @override
  State<GradeCard> createState() => _GradeCardState();
}

class _GradeCardState extends State<GradeCard> {
  bool gradeSave = false;
  final fieldText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.content.name),
        subtitle: Text("Etkileme orani: ${widget.content.ratio}"),
        trailing: SizedBox(
          width: 120,
          height: 50,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Expanded(
                  child: gradeSave
                      ? TextFormField(
                          controller: fieldText,
                          keyboardType: TextInputType.number,
                          onEditingComplete: () {
                            widget.content.grade = double.parse(fieldText.text);

                            setState(() {
                              gradeSave = false;
                              widget.function();
                            });
                          },
                        )
                      : Text(
                          "${widget.content.grade.toString()}/100",
                        )),
              Expanded(
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        gradeSave = true;
                      });
                    },
                    icon: Icon(
                      Icons.edit,
                      size: 20,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
