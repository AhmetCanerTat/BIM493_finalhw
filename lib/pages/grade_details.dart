import 'package:bim493_finalhw/model/course.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_constants.dart';
import '../model/content.dart';
import '../model/course.dart';

class GradeDetails extends StatelessWidget {
  final Course course;

  GradeDetails({super.key, required this.course});

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
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text("100%",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Color.fromRGBO(48, 64, 98, 1),
                                fontSize: 40,
                                fontWeight: FontWeight.w700),
                          )),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        course.name,
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Color.fromRGBO(48, 64, 98, 1),
                                fontSize: 30,
                                fontWeight: FontWeight.w700)),
                      ),
                    ))
                  ],
                )),
          ),
          Expanded(
            flex: 3,
            child: !course.contents.isEmpty
                ? ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: course.contents.length,
                    itemBuilder: (context, index) =>
                        GradeCard(content: course.contents[index]),
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
  const GradeCard({super.key, required this.content});

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
        trailing: Container(
          width: 50,
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
                            });
                          },
                        )
                      : Text(
                          widget.content.grade.toString(),
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
