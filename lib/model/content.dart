import 'package:bim493_finalhw/model/course.dart';

class Content extends Course {
  final String name;
  final double ratio;
  late double grade;

  Content(this.name, this.ratio) : super('');

  double calculate(double ratio, int grade) {
    return grade / ratio;
  }
}
