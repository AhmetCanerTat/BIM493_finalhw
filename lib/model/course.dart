import 'content.dart';

class Course {
  final String name;
  late List<Content> contents = [];
  double gradeAverage = 0;
  Course(this.name);

  addContent(Content content) {
    contents.add(content);
  }

  takeContentList(contents) {}

  Map toJson() {
    contents != null ? contents.map((e) => e.toJson()).toList() : null;
    return {
      'name': name,
      'gradeAverage': gradeAverage,
      'contents': contents,
    };
  }

  factory Course.fromJson(json) {
    Course course = Course(json['name']);
    course.gradeAverage = json['gradeAverage'] as double;
    var contentObjsJson = json['contents'] as List;
    for (var contentJson in contentObjsJson) {
      Content content = Content.fromJson(contentJson);
      course.addContent(content);
    }
    return course;
  }
}
