import 'package:bim493_finalhw/main.dart';
import 'package:bim493_finalhw/widgets/enter_course.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_constants.dart';
import '../helper/data_helper.dart';
import '../model/course.dart';
import '../model/ders.dart';
import '../widgets/ortalama_goster.dart';

class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  List<Course> allCourses = [];
  bool courseSave = false;
  var formKey = GlobalKey<FormState>();
  List<Ders> tumDersler = [];

  double secilen = 1;
  double secilenKredi = 1;
  String girilenDersAdi = 'Ders Adı Girilmemiş';
  double krediDegeri = 1;
  double notDegeri = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            'Ortalama Hesapla',
            style: Sabitler.textStyle(24, FontWeight.w900, Sabitler.anaRenk),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: myForm()),
          Expanded(
            flex: 10,
            child: tumDersler.length > 0
                ? ListView.builder(
                    itemBuilder: (context, index) => Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (a) {
                        setState(() {
                          tumDersler.removeAt(index);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Card(
                          child: ListTile(
                            title: Text(tumDersler[index].ad),
                            leading: CircleAvatar(
                              backgroundColor: Sabitler.anaRenk,
                              child: Text('' +
                                  (tumDersler[index].krediDegeri *
                                          tumDersler[index].harfDegeri)
                                      .toStringAsFixed(0)),
                            ),
                            subtitle: Text(
                                '${tumDersler[index].krediDegeri} Kredi, Not Değeri ${tumDersler[index].harfDegeri}'),
                          ),
                        ),
                      ),
                    ),
                    itemCount: tumDersler.length,
                  )
                : Container(
                    margin: const EdgeInsets.all(24),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text('Lütfen ders ekleyiniz',
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
                      setState(() {
                        courseSave = true;
                      });
                    }),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Text("Kaydet", style: TextStyle(color: Colors.white)),
                          Expanded(
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
                          child: _buildHarfler(),
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
                            var eklenecekDers =
                                Ders(girilenDersAdi, secilen, secilenKredi);
                            tumDersler.insert(0, eklenecekDers);
                            ortalamaHesapla();
                            setState(() {});
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
              : Spacer()
        ],
      ),
    );
  }

  TextFormField _buildTextFormField() {
    return TextFormField(
      onSaved: (deger) {
        girilenDersAdi = deger!;
      },
      validator: (s) {
        if (s!.length <= 0) {
          return 'Boş bırakma ders adını';
        } else
          return null;
      },
      decoration: InputDecoration(
          hintText: 'Matematik',
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

  Widget _buildHarfler() {
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
        items: DataHelper.tumDersHarfleri(),
        underline: Container(),
        onChanged: (dd) {
          setState(() {
            secilen = dd!;
            print(dd);
          });
        },
        value: secilen,
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
        items: DataHelper.tumKrediler(),
        underline: Container(),
        onChanged: (dd) {
          setState(() {
            secilenKredi = dd!;
            print(dd);
          });
        },
        value: secilenKredi,
      ),
    );
  }

  double ortalamaHesapla() {
    double toplamNot = 0;
    double toplamKredi = 0;
    tumDersler.forEach((element) {
      toplamNot = toplamNot + (element.krediDegeri * element.harfDegeri);
      toplamKredi = toplamKredi + element.krediDegeri;
    });
    return toplamNot / toplamKredi;
  }
}
// class Course extends StatefulWidget {
//   const Course({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<Course> createState() => _CourseState();
// }

// class _CourseState extends State<Course> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text("Lineer Algebra",
//                 style: GoogleFonts.montserrat(
//                   textStyle: const TextStyle(
//                       color: Color.fromRGBO(48, 64, 98, 1),
//                       fontSize: 20,
//                       fontWeight: FontWeight.w500),
//                 )),
//             Text("49%",
//                 style: GoogleFonts.montserrat(
//                   textStyle: const TextStyle(
//                       color: Color.fromRGBO(48, 64, 98, 1),
//                       fontSize: 20,
//                       fontWeight: FontWeight.w700),
//                 ))
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 10),
//           child: Container(
//             decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade300),
//                 borderRadius: BorderRadius.circular(10)),
//             height: 10,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: const LinearProgressIndicator(
//                 backgroundColor: Colors.white,
//                 color: Color.fromRGBO(33, 217, 233, 1),
//                 value: 0.8,
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
