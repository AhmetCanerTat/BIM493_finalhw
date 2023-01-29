import 'content.dart';

class Course {
  final String name;
  late List<Content> contents = [];
  double gradeAverage = 0;
  double letter = 1;
  double credit = 1;
  Course(this.name);

  addContent(Content content) {
    contents.add(content);
  }

  removeContent(Content content) {
    contents.remove(content);
  }

  takeContentList(contents) {}

  Map toJson() {
    contents != null ? contents.map((e) => e.toJson()).toList() : null;
    return {
      'name': name,
      'gradeAverage': gradeAverage,
      'letter': letter,
      'credit': credit,
      'contents': contents,
    };
  }

  factory Course.fromJson(json) {
    Course course = Course(json['name']);
    course.gradeAverage = json['gradeAverage'] as double;
    course.letter = json['letter'] as double;
    course.credit = json['credit'] as double;
    var contentObjsJson = json['contents'] as List;
    for (var contentJson in contentObjsJson) {
      Content content = Content.fromJson(contentJson);
      course.addContent(content);
    }
    return course;
  }
}
