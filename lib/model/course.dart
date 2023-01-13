import 'content.dart';

class Course {
  final String name;
  late List<Content> contents = [];
  Course(this.name);

  addContent(Content content) {
    contents.add(content);
  }

  takeContentList(contents) {}

  Map toJson() {
    contents != null ? contents.map((e) => e.toJson()).toList() : null;
    return {
      'name': name,
      'contents': contents,
    };
  }

  factory Course.fromJson(json) {
    Course course = Course(json['name']);
    var contentObjsJson = json['contents'] as List;
    print(contentObjsJson);
    for (var contentJson in contentObjsJson) {
      Content content = Content.fromJson(contentJson);
      course.addContent(content);
    }
    return course;
  }
}
