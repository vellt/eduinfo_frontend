import 'package:eduinfo/screens/auth/registration/registration_chooser/registration_chooser_controller.dart';
import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_secondary.dart';
import 'package:eduinfo/widgets/row_space.dart';
import 'package:eduinfo/widgets/row_text_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationChooserScreen extends StatelessWidget {
  const RegistrationChooserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RegistrationChooserController registrationChooserController = Get.put(RegistrationChooserController());
    return GetBuilder(
      init: registrationChooserController,
      builder: (controller) {
        return AppBody(
          isFloatingButton: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppHeaderSecondary(text: "Regisztráció",backPressed: controller.back),
              RowTextContent(title: "Felhasználói", onPressed: controller.navigateToRegistrationPerson),
              RowTextContent(title: "Intézményi", onPressed: controller.navigateToRegistrationInstitution),
              RowSpace(),
            ],
          ),
        );
      },
    );
  }
}