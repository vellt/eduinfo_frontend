import 'package:eduinfo/screens/dashboard/institution/event/edit_event_links/edit_event_links_controller.dart';
import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_secondary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditEventLinksScreen extends StatelessWidget {
  const EditEventLinksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(EditEventLinksController()),
      builder: (controller) {
        return AppBody(
          floatingActionButtonPadding: EdgeInsets.zero,
          isFloatingButton: true,
          floatingActionButtonPressed: controller.add,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppHeaderSecondary(
                text: "Esemény linkek",
                backPressed: controller.back,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: controller.linksWidgets(),
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