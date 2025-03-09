import 'package:eduinfo/screens/dashboard/institution/settings/edit_category/edit_category_controller.dart';
import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_secondary.dart';
import 'package:eduinfo/widgets/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditCategoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(EditCategoryController()),
      builder: (controller) {
        return AppBody(
          floatingActionButtonPadding: EdgeInsets.zero,
          isFloatingButton: true,
          floatingActionButtonPressed: controller.saveSetup,
          floatingActionButtonIcon: Icons.save,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppHeaderSecondary(
                text: "Intézmény besorolása",
                backPressed: controller.back,
              ),
              Expanded(
                child: LoadingContainer(
                  startLoading: controller.isLoading,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: controller.categories,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}



