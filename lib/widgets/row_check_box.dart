  import 'package:eduinfo/widgets/row_check_box_controller.dart';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';

  class RowCheckBox extends StatelessWidget {
    RowCheckBox({
      super.key,
      required this.isChecked,
      required this.title,
      this.controller,
    });
    bool isChecked;
    String title;
    RowCheckBoxController? controller;

    @override
    Widget build(BuildContext context) {
      return GetBuilder(
        init: controller?? RowCheckBoxController(isChecked: isChecked),
        global: false,
        builder: (controller) {
          return Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(255, 235, 235, 235), width: 0.5)),
            child: GestureDetector(
              onTap: () => controller.switchTo(!controller.isChecked),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                child: ListTile(
                  leading: Checkbox(value: controller.isChecked, activeColor: Color(0xFF17A436),onChanged: (value) {
                    controller.switchTo(value);
                    isChecked=controller.isChecked;
                  },),
                  title: Text(title,
                          style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.normal),),
                  
                  contentPadding: EdgeInsets.all(0),
                ),
              ),
            ),
          );
        }
      );
    }
  }