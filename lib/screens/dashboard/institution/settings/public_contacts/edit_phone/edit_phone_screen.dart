import 'package:eduinfo/screens/dashboard/institution/settings/public_contacts/edit_phone/edit_phone_constroller.dart';
import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_secondary.dart';
import 'package:eduinfo/widgets/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPhoneScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Get.put(EditPhoneConstroller()),
        builder: (controller) {
          return AppBody(
            floatingActionButtonPadding: EdgeInsets.zero,
            isFloatingButton: !controller.isLoading,
            floatingActionButtonPressed: controller.newPhone,
            child: LoadingContainer(
              startLoading: controller.isLoading,
              child: Column(
                children: [
                  AppHeaderSecondary(
                    text: "Telefonos elérhetőségek",
                    backPressed: controller.back,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: controller.phones(),
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
