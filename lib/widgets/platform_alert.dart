import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformAlert {
  final String title;
  final String message;
  final int type;

  PlatformAlert(
      {required this.title, required this.message, required this.type});

  void show(BuildContext context) {
    final platform = Theme.of(context).platform;

    if (platform == TargetPlatform.iOS) {
      _buildCupertinoAlert(context);
    } else {
      _buildMaterialAlert(context);
    }
  }

  void _buildMaterialAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return type == 0
              ? AlertDialog(
                  title: Text(title),
                  content: Text(message),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Evet')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Hayır'))
                  ],
                )
              : AlertDialog(
                  title: Text(title),
                  content: Text(message),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Tamam')),
                  ],
                );
        });
  }

  void _buildCupertinoAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return type == 0
              ? CupertinoAlertDialog(
                  title: Text(title),
                  content: Text(message),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Evet')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Hayır'))
                  ],
                )
              : CupertinoAlertDialog(
                  title: Text(title),
                  content: Text(message),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Tamam')),
                  ],
                );
        });
  }
}
