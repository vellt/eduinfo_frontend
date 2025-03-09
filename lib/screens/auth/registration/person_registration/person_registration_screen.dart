import 'package:eduinfo/screens/auth/registration/person_registration/person_registration_controller.dart';
import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_secondary.dart';
import 'package:eduinfo/widgets/row_button.dart';
import 'package:eduinfo/widgets/row_text_content.dart';
import 'package:eduinfo/widgets/row_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonRegistrationScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(PersonRegistrationController()),
      builder: (controller) {
        return AppBody(
          isFloatingButton: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppHeaderSecondary(text: "Felhasználói regisztráció", backPressed: controller.back),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        RowTextContent(title: "Email", isRequired: true,),
                        RowTextField(controller: controller.email,hintText: "Add meg az e-mail címed",),
                        RowTextContent(title: "Teljes név", isRequired: true,),
                        RowTextField(controller: controller.fullName,hintText: "Add meg az teljes neved"),
                        RowTextContent(title: "Jelszó", isRequired: true,),
                        RowTextField(controller: controller.password1, hintText: "Add meg a fiókod jelszavát",obscureText: true,),
                        RowTextContent(title: "Jelszó megerősítése", isRequired: true,),
                        RowTextField(controller: controller.password2, hintText: "Erősítsd meg a jelszót",obscureText: true,),
                      ],
                    ),
                  ),
                ),
                RowButton(onPressed: controller.Registration,text: "Regisztráció")
              ],
            ),
        );
      },
    );
  }
}
