import 'content.dart';

class Course {
  final String name;
  late List<Content> contents = [];
  Course(this.name);

  addContent(Content content) {
    contents.add(content);
  }

  takeContentList(contents){

  }

  toJson(){
    var newList = contents.map((e) => e.toJson()).toList();
    return{
      "id": name,
      "name":name,
      "courses":newList,
    };
  }

  fromJson(jsonData){
    Course course = Course(jsonData['title']);
    List tempList = jsonData['courses'];
    tempList.map;

    return course;
  }

}
