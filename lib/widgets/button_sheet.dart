import 'package:eduinfo/widgets/app_header_secondary.dart';
import 'package:eduinfo/widgets/row_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonSheet extends StatelessWidget {
  ButtonSheet({
    super.key,
    required this.children,
    required this.title,
     this.buttonTitle,
     this.onPressed,
    this.disableAutoGetBack,
  });
  List<Widget> children;
  String title;
  String? buttonTitle;
  Function()? onPressed;
  bool? disableAutoGetBack;

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
            ...children, // Dinamikus gyermek widgetek hozzáadása
            if(onPressed!=null  && buttonTitle!=null)RowButton(
              onPressed: () {
                onPressed!();
                if(disableAutoGetBack==null || disableAutoGetBack==false) {
                  Get.back();
                }
              },
              text: buttonTitle!,
              isBordered: false,
            ),
          ],
        ),
      ),
    );
  }
}

