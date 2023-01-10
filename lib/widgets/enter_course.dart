import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class EnterCourse extends StatefulWidget {
  const EnterCourse({super.key});

  @override
  State<EnterCourse> createState() => _EnterCourseState();
}

class _EnterCourseState extends State<EnterCourse> {
  static List<String> courseContents = ["Final", "Vize", "Quiz", "Ödev"];
  String selectedContent = "";
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
              hintText: 'Ders Ismi',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              fillColor: Colors.grey.shade200),
        ),
        Row(
          children: [
            Expanded(child: _buildContents()),
            Expanded(
                child: TextFormField(
              decoration: InputDecoration(
                  hintText: 'Yüzdeliği',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200),
            ))
          ],
        )
      ],
    ));
  }

  Widget _buildContents() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DropdownButton<String>(
        value: courseContents.first,
        elevation: 16,
        items: courseContents
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
            .toList(),
        underline: Container(),
        onChanged: (String? value) {
          setState(() {
            selectedContent = value!;
          });
        },
      ),
    );
  }
}
