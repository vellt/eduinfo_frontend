import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditEventDescriptionController extends GetxController {
  TextEditingController textEditingController= TextEditingController(text: Get.arguments['event_description'] as String);

  void save(){
    Get.back(result: textEditingController.text);
  }

  void back(){
    Get.back();
  }
}