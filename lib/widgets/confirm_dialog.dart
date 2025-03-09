import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmDialog extends StatelessWidget {
  ConfirmDialog({
    super.key,
    required this.title,
    required this.description,
    required this.onConfirm,
  });
  String title;
  String description;
  Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
        title: Text(title),
        content: Text(description),
        actions: [
          CupertinoDialogAction(
            onPressed: Get.back,
            child: Text("Mégse"),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Get.back(); 
              onConfirm(); 
            },
            isDestructiveAction: true,
            child: Text("Igen"),
          ),
        ],
    );
  }
}