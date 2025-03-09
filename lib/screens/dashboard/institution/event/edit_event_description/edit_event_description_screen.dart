import 'package:eduinfo/screens/dashboard/institution/event/edit_event_description/edit_event_description_controller.dart';
import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_secondary.dart';
import 'package:eduinfo/widgets/big_text_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditEventDescriptionScreen extends StatelessWidget {
  const EditEventDescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(EditEventDescriptionController()),
      builder: (controller) {
        return AppBody(
          floatingActionButtonPadding: EdgeInsets.zero,
          isFloatingButton: true,
          floatingActionButtonIcon: Icons.save,
          floatingActionButtonPressed: controller.save,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppHeaderSecondary(
                text: "Esemény leírása",
                backPressed: controller.back,
              ),
              Expanded(
                child: BigTextInput(
                  controller: controller.textEditingController, 
                  hintText: "Az esemény szöveges leírása..",
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}