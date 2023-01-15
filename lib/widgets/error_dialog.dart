


import '../widgets/reuseable_widget.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {

  final String? message;
   const ErrorDialog({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message!),
      actions: [
        button(context, (){ Navigator.pop(context);} ,Text('Ok'))
      ],
    );
  }
}
