import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_primary.dart';
import 'package:eduinfo/widgets/dont_have_account.dart';
import 'package:eduinfo/widgets/loading_container.dart';
import 'package:eduinfo/widgets/row_button.dart';
import 'package:eduinfo/widgets/row_check_box.dart';
import 'package:eduinfo/widgets/row_space.dart';
import 'package:eduinfo/widgets/row_text_content.dart';
import 'package:eduinfo/widgets/row_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(LoginController()),
      builder: (controller) {
        return AppBody(
          isFloatingButton: false,
          child: LoadingContainer(
            startLoading: controller.isLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppHeaderPrimary(title: "Belépés"),
                RowTextContent(title: "Email"),
                RowTextField(controller: controller.email,hintText: "Add meg az e-mail címed"),
                RowTextContent(title: "Jelszó"),
                RowTextField(controller: controller.password,hintText: "Add meg a jelszavad", obscureText: true),
                RowCheckBox(
                  title: 'Emlékezz rám',
                  isChecked: controller.checkBoxController.isChecked,
                  controller: controller.checkBoxController,
                ),
                RowButton(text: "Belépés",onPressed: controller.login),
                RowSpace(),
                DontHaveAccount(onPressed: controller.navigateToRegistrationChooser),
              ],
            ),
          ),
        );
      },
    );
  }
}

