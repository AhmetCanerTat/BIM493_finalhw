import 'package:bim493_finalhw/model/course.dart';


class Content extends Course {
  final String name;
  final double ratio;
  double grade = 0;

  Content(
    this.name,
    this.ratio,
  ) : super('');

  double calculate() {
    return grade * ratio;
  }

  void setGrade(double grade) {
    this.grade = grade;
  }

  Map toJson() {
    return {
      "name": name,
      "ratio": ratio,
      "grade": grade,
    };
  }

  factory Content.fromJson(dynamic json) {
    Content content = Content(json['name'] as String, json['ratio'] as double);
    content.setGrade(json['grade'] as double);
    return content;
  }
}
