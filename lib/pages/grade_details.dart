import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_constants.dart';

class GradeDetails extends StatelessWidget {
  const GradeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Expanded(
                      child: Center(
                        child: Text("NOTLAR",
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            )),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text("100%",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Color.fromRGBO(48, 64, 98, 1),
                                fontSize: 50,
                                fontWeight: FontWeight.w700),
                          )),
                    )),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        "Lineer Algebra",
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Color.fromRGBO(48, 64, 98, 1),
                                fontSize: 40,
                                fontWeight: FontWeight.w700)),
                      ),
                    ))
                  ],
                )),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
