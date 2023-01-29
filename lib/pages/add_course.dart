import 'dart:convert';

import 'package:bim493_finalhw/pages/courses.dart';
import 'package:bim493_finalhw/widgets/platform_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import '../helper/data_helper.dart';
import '../model/content.dart';
import '../model/course.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({super.key});

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final fieldText = TextEditingController();
  List<Course> allCourses = [];
  List<Content> allContents = [];
  bool courseSave = false;
  var formKey = GlobalKey<FormState>();

  String chosenContentName = "Vize";
  double chosenContentRatio = 0.5;
  Course? chosenCourse;
  String? enteredCourseName;

  void saveCourses() async {
    final SharedPreferences prefs = await _prefs;
    List courses = allCourses.map((e) => e.toJson()).toList();
    prefs.setString("courses", jsonEncode(courses));
  }

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

  void formReset() {
    fieldText.clear();
    courseSave = false;
    allContents = [];
    setState(() {});
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            'Ders Ekle',
            style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                  color: Constants.anaRenk,
                  fontSize: 24,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: myForm()),
          Expanded(
            flex: 10,
            child: allContents.length > 0
                ? ListView.builder(
                    itemBuilder: (context, index) => Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (a) {
                        chosenCourse?.removeContent(allContents[index]);
                        setState(() {
                          allContents.removeAt(index);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Card(
                          child: ListTile(
                            title: Text(allContents[index].name,
                                style: const TextStyle(
                                    color: Color.fromRGBO(48, 64, 98, 1),
                                    fontWeight: FontWeight.w600)),
                            leading: CircleAvatar(
                              backgroundColor: Constants.anaRenk,
                              child: Text(
                                '' + (allContents.length).toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                            subtitle: Text(
                                'Etkileme Oranı ${allContents[index].ratio}',
                                style: const TextStyle(
                                    color: Color.fromRGBO(48, 64, 98, 1),
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                      ),
                    ),
                    itemCount: allContents.length,
                  )
                : Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(24),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                  courseSave
                                      ? ('Lütfen ders içeriklerini seçiniz')
                                      : ('Lütfen ders ismi giriniz'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(color: Constants.anaRenk)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(
              child: ElevatedButton(
                onPressed: (() {
                  allCourses.insert(0, chosenCourse!);
                  saveCourses();
                  formReset();
                }), //ekleme yapilacak
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Constants.anaRenk)),
                child: const Text("Dersi Kaydet"),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: SpeedDial(
        animationCurve: Curves.bounceInOut,
        childMargin: const EdgeInsets.symmetric(vertical: 20),
        animatedIcon: AnimatedIcons.view_list,
        backgroundColor: Constants.anaRenk,
        children: [
          SpeedDialChild(
              child: const Icon(Icons.add),
              backgroundColor: Colors.green,
              label: 'Ders Ekle',
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (c) => const AddCourse()));
              }),
          SpeedDialChild(
              child: const Icon(Icons.remove_red_eye_outlined),
              backgroundColor: Colors.purple,
              label: 'Dersleri gör',
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (c) => const Courses()));
              }),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Form myForm() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: _buildTextFormField(),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Constants.anaRenk),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ))),
                    onPressed: (() {
                      if (formKey.currentState!.validate() && !courseSave) {
                        formKey.currentState!.save();
                        chosenCourse = Course(enteredCourseName!);
                        courseSave = true;
                      } else {
                        formReset();
                      }
                      setState(() {});
                    }),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(courseSave ? ("Sıfırla") : ("Kaydet"),
                              style: const TextStyle(color: Colors.white)),
                          const Expanded(
                            child: Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Colors.white,
                            ),
                          ),
                        ]),
                  ),
                ))
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          courseSave
              ? (Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: _buildContents(),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: _buildRatio(),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (!checkRatio()) {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              var content = Content(
                                  chosenContentName, chosenContentRatio);
                              chosenCourse?.addContent(content);
                              setState(() {
                                allContents.insert(0, content);
                              });
                            }
                          } else {
                            var alert = PlatformAlert(
                                title: "Oran 1'in üstünde",
                                message: "Oran 1'in üstünde olamaz",
                                type: 1);
                            alert.show(context);
                          }
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Constants.anaRenk,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ))
              : const Spacer()
        ],
      ),
    );
  }

  TextFormField _buildTextFormField() {
    return TextFormField(
      onSaved: (name) {
        enteredCourseName = name!;
      },
      enabled: !courseSave,
      controller: fieldText,
      decoration: InputDecoration(
          hintText: 'Ders İsmi',
          border: OutlineInputBorder(
            borderRadius: Constants.borderRadius,
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          fillColor: Constants.anaRenk.withOpacity(0.3)),
    );
  }

  Widget _buildContents() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Constants.anaRenk.withOpacity(0.4),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DropdownButton<String>(
        iconEnabledColor: Constants.anaRenk,
        elevation: 16,
        items: DataHelper.allContents(),
        underline: Container(),
        onChanged: (content) {
          setState(() {
            chosenContentName = content!;
          });
        },
        value: chosenContentName,
      ),
    );
  }

  Widget _buildRatio() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Constants.anaRenk.withOpacity(0.4),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DropdownButton<double>(
        iconEnabledColor: Constants.anaRenk,
        elevation: 16,
        items: DataHelper.allRatio(),
        underline: Container(),
        onChanged: (ratio) {
          setState(() {
            chosenContentRatio = ratio!;
          });
        },
        value: chosenContentRatio,
      ),
    );
  }

  bool checkRatio() {
    double ratiosum = 0;
    for (Content content in allContents) {
      ratiosum += content.ratio;
    }
    if (ratiosum == 1) {
      return true;
    } else {
      return false;
    }
  }
}
