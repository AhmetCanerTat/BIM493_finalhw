import 'package:flutter/material.dart';

class DataHelper {
  static List<String> _createDersHarfNotlari() {
    return ['AA', 'BA', 'BB', 'CB', 'CC', 'DC', 'DD', 'FD', 'FF'];
  }

  static List<String> _createcontents() {
    return ["Vize", "Odev", "Quiz", "Final"];
  }

  static List<double> _createRatio() {
    return [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9];
  }

  static double _harfiNotaCevir(String harf) {
    switch (harf) {
      case 'AA':
        return 4;
      case 'BA':
        return 3.5;
      case 'BB':
        return 3;
      case 'CB':
        return 2.5;
      case 'CC':
        return 2;
      case 'DC':
        return 1.5;
      case 'DD':
        return 1;
      case 'FD':
        return 0.5;
      case 'FF':
        return 0.0;
      default:
        return 1;
    }
  }

  static List<int> _tumKrediler() {
    return List.generate(10, (index) => index + 1).toList();
  }

  static List<DropdownMenuItem<double>> tumDersHarfleri() {
    return _createDersHarfNotlari()
        .map((e) => DropdownMenuItem<double>(
              child: Text(e),
              value: _harfiNotaCevir(e),
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

  static List<DropdownMenuItem<double>> tumKrediler() {
    return List.generate(10, (index) => (index + 1))
        .toList()
        .map((e) => DropdownMenuItem(
              child: Text(e.toString()),
              value: e.toDouble(),
            ))
        .toList();
  }
}
