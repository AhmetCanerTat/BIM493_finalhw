import 'content.dart';

class Course {
  final String name;
  late List<Content> contents = [];

  Course(this.name);

  addContent(Content content) {
    contents.add(content);
  }
}
