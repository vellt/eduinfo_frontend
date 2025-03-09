import 'package:eduinfo/screens/dashboard/institution/settings/edit_description/edit_description_controller.dart';
import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_secondary.dart';
import 'package:eduinfo/widgets/big_text_input.dart';
import 'package:eduinfo/widgets/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditDescriptionScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(EditDescriptionController()),
      builder: (controller) {
        return AppBody(
          floatingActionButtonPadding: EdgeInsets.zero,
          isFloatingButton: !controller.isLoading,
          floatingActionButtonIcon: Icons.save,
          floatingActionButtonPressed: controller.save,
          child: LoadingContainer(
            startLoading: controller.isLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppHeaderSecondary(
                  text: "Intézmény leírása",
                  backPressed: controller.back,
                ),
                Expanded(
                  child: BigTextInput(
                    controller: controller.textEditingController, 
                    hintText: "Az intézmény szöveges leírása..",
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}

