import 'dart:convert';

import 'package:bim493_finalhw/pages/courses.dart';
import 'package:bim493_finalhw/pages/grade_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Authentication/signin_screen.dart';
import '../constants/app_constants.dart';
import '../helper/data_helper.dart';
import '../model/content.dart';
import '../model/course.dart';
import '../model/ders.dart';
import '../widgets/ortalama_goster.dart';

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
  List<Ders> tumDersler = [];

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
        title:  Text(
            'Ders Ekle',
            style: Sabitler.textStyle(24, FontWeight.w900, Sabitler.anaRenk),
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
                        setState(() {
                          allContents.removeAt(index);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Card(
                          child: ListTile(
                            title: Text(allContents[index].name),
                            leading: CircleAvatar(
                              backgroundColor: Sabitler.anaRenk,
                              child: Text('' + (allContents.length).toString()),
                            ),
                            subtitle: Text(
                                'Etkileme Orani ${allContents[index].ratio}'),
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
                                      ? ('Lutfen ders iceriklerini seciniz')
                                      : ('Lütfen ders ismi giriniz'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(color: Sabitler.anaRenk)),
                            ),
                          ),
                        ),
                      ),

                  ],
                ),
          ),Padding(padding: EdgeInsets.only(bottom: 20),
            child: Center(
              child: ElevatedButton(

                onPressed: (() {
                  allCourses.insert(0, chosenCourse!);
                  saveCourses();
                  formReset();
                }), //ekleme yapilacak
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Sabitler.anaRenk)),  child: Text("Dersi Kaydet"),
              ),
            ),)

        ],
      ),

      floatingActionButton: SpeedDial(
        animationCurve: Curves.bounceInOut,
        childMargin: EdgeInsets.symmetric(vertical: 20),
        animatedIcon: AnimatedIcons.view_list,
        backgroundColor: Sabitler.anaRenk,
        children: [

          SpeedDialChild(
              child: Icon(Icons.add),
              backgroundColor: Colors.green,
              label: 'Ders Ekle',
              onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (c)=> const AddCourse()));}
          ),
          SpeedDialChild(
            child: Icon(Icons.remove_red_eye_outlined),
            backgroundColor: Colors.purple,
            label: 'Dersleri gör',
              onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (c)=>  Courses()));}
          ),
          SpeedDialChild(
              child: Icon(Icons.logout),
              backgroundColor: Colors.grey,
              label: 'Çıkış Yap',
              onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (c)=> const SignInScreen()));}
          ),

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
                            MaterialStateProperty.all<Color>(Sabitler.anaRenk),
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
                          Text(courseSave ? ("Sifirla") : ("Kaydet"),
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
                          child: _buildKrediler(),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            var content =
                                Content(chosenContentName, chosenContentRatio);
                            chosenCourse?.addContent(content);
                            setState(() {
                              allContents.insert(0, content);
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Sabitler.anaRenk,
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
      // validator: (s) {
      //   if (s!.length <= 0) {
      //     return 'Boş bırakma ders adını';
      //   } else
      //     return null;
      // },
      enabled: !courseSave,
      controller: fieldText,
      decoration: InputDecoration(
          hintText: 'Ders Ismi',
          border: OutlineInputBorder(
            borderRadius: Sabitler.borderRadius,
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          fillColor: Sabitler.anaRenk.withOpacity(0.3)),
    );
  }

  Widget _buildContents() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Sabitler.anaRenk.withOpacity(0.4),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DropdownButton<String>(
        iconEnabledColor: Sabitler.anaRenk,
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

  Widget _buildKrediler() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Sabitler.anaRenk.withOpacity(0.4),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DropdownButton<double>(
        iconEnabledColor: Sabitler.anaRenk,
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
}
