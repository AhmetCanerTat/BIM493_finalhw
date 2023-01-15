import 'package:flutter/material.dart';

class DataHelper {
  static List<String> _createCourseLetters() {
    return ['AA', 'AB', 'BA', 'BB', 'BC', 'CB', 'CC', 'CD', 'DC', 'DD', 'FF'];
  }

  static List<String> _createcontents() {
    return ["Vize", "Odev", "Quiz", "Final"];
  }

  static List<double> _createRatio() {
    return [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9];
  }

  static double _letterToGrade(String harf) {
    switch (harf) {
      case 'AA':
        return 4;
      case 'AB':
        return 3.7;
      case 'BA':
        return 3.3;
      case 'BB':
        return 3;
      case 'BC':
        return 2.7;
      case 'CB':
        return 2.3;
      case 'CC':
        return 2;
      case 'CD':
        return 1.7;
      case 'DC':
        return 1.3;
      case 'DD':
        return 1;
      case 'FF':
        return 0;
      default:
        return 1;
    }
  }

  static List<DropdownMenuItem<double>> allCourseLetters() {
    return _createCourseLetters()
        .map((e) => DropdownMenuItem<double>(
              child: Text(e),
              value: _letterToGrade(e),
            ))
        .toList();
  }

  static List<DropdownMenuItem<String>> allContents() {
    return _createcontents()
        .map((e) => DropdownMenuItem(
              child: Text(e),
              value: e,
            ))
        .toList();
  }

  static List<DropdownMenuItem<double>> allRatio() {
    return _createRatio()
        .map((e) => DropdownMenuItem<double>(
              child: Text(e.toString()),
              value: e,
            ))
        .toList();
  }

  static List<DropdownMenuItem<double>> allCredits() {
    return List.generate(10, (index) => (index + 1))
        .toList()
        .map((e) => DropdownMenuItem(
              child: Text(e.toString()),
              value: e.toDouble(),
            ))
        .toList();
  }
}
