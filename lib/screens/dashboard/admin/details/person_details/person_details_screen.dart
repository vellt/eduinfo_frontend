import 'package:eduinfo/screens/dashboard/admin/details/person_details/person_details_controller.dart';
import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_secondary.dart';
import 'package:eduinfo/widgets/loading_container.dart';
import 'package:eduinfo/widgets/row_button.dart';
import 'package:eduinfo/widgets/row_image_content.dart';
import 'package:eduinfo/widgets/row_space.dart';
import 'package:eduinfo/widgets/row_text_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonDetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(PersonDetailsController()),
      builder: (controller) {
        return AppBody(
          isFloatingButton: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppHeaderSecondary(text: "Felhasználói regisztráció",backPressed: controller.back),
              Expanded(
                child: LoadingContainer(
                  startLoading: controller.isLoading,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RowImageContent(
                        text: controller.person.name,
                        isAccepted: controller.person.isAccepted,
                        isDisabled: !controller.person.isEnabled,
                        image: controller.person.avatarImage,
                      ),
                      RowTextContent(
                        title: "Email",
                        details: controller.person.email,
                        icon: Icon(Icons.mail, color: Color(0xFF17A436)),
                        outerOnPressed: controller.sendMail,
                      ),
                      RowSpace(),
                      (!controller.person.isEnabled)
                        ? RowButton(text: "fiók feloldása", onPressed: controller.enablePerson)
                        : RowButton(
                          text: "fiók tiltása",
                          color: Color(0xFFE74C3C),
                          onPressed: controller.disablePerson)
                    ],
                  ),
                ),
              )
              ],
          ),
        );
      }
    );
  }
}
