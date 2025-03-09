import 'package:eduinfo/screens/dashboard/institution/settings/public_contacts/edit_website/edit_webiste_controller.dart';
import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_secondary.dart';
import 'package:eduinfo/widgets/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditWebsiteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
    init: Get.put(EditWebisteController()),
    builder: (controller) {
      return AppBody(
        floatingActionButtonPadding: EdgeInsets.zero,
        isFloatingButton: !controller.isLoading,
        floatingActionButtonPressed: controller.newWebsite,
        child: LoadingContainer(
          startLoading: controller.isLoading,
          child: Column(
            children: [
              AppHeaderSecondary(
                text: "Weboldalak",
                backPressed: controller.back,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: controller.websites(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}