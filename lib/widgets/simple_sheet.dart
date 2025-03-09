import 'package:eduinfo/widgets/app_header_secondary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SimpleSheet extends StatelessWidget {
  SimpleSheet({
    super.key,
    required this.children,
    required this.title,
  });
  List<Widget> children;
  String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: AppHeaderSecondary(
                text: title,
                backPressed: Get.back,
              ),
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}