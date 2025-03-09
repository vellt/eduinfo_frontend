import 'package:eduinfo/widgets/app_header_secondary.dart';
import 'package:eduinfo/widgets/row_button.dart';
import 'package:eduinfo/widgets/row_text_content.dart';
import 'package:eduinfo/widgets/row_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactBottomSheet extends StatelessWidget {
  ContactBottomSheet({
    super.key,
    required this.titleController,
    required this.inputController,
    required this.headerTitle,
    required this.buttonTitle,
    required this.onPressed,
    required this.bottomInputName,
    required this.bottomInputPlaceholder,
    this.removePressed,
    this.textInputType,
  });

  final TextEditingController titleController;
  final TextEditingController inputController;
  String headerTitle;
  String buttonTitle;
  Function() onPressed;
  String bottomInputName;
  String bottomInputPlaceholder;
  Function()? removePressed;
  TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: AppHeaderSecondary(
                        text: headerTitle, backPressed: () => Get.back(),
                        actions: [
                          IconButton(
                            onPressed: removePressed, 
                            icon: Icon(Icons.delete, color: Colors.grey,),
                          )
                        ],
                      ),
            ),
             RowTextContent(title: "Megnevezés"),
                    RowTextField(controller: titleController,hintText: "Az elérhetőség neve"),
                    RowTextContent(title: bottomInputName),
                    RowTextField(controller: inputController,hintText: bottomInputPlaceholder,textInputType: textInputType),
            RowButton(text: buttonTitle,isBordered: false,onPressed: () {
                      onPressed();
                      Get.back();
                    })
          ],
        ),
      ),
    );
  }
}