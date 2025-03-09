import 'package:eduinfo/screens/dashboard/admin/details/institution_details/institution_details_controller.dart';
import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_secondary.dart';
import 'package:eduinfo/widgets/loading_container.dart';
import 'package:eduinfo/widgets/row_button.dart';
import 'package:eduinfo/widgets/row_image_content.dart';
import 'package:eduinfo/widgets/row_space.dart';
import 'package:eduinfo/widgets/row_text_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InstitutionDetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(InstitutionDetailsController()),
      builder: (controller) {
        return AppBody(
          isFloatingButton: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppHeaderSecondary(text: "Intézményi regisztráció",backPressed: controller.back),
              Expanded(
                child: LoadingContainer(
                  startLoading: controller.isLoading,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RowImageContent(
                        text: controller.institution.name,
                        isAccepted: controller.institution.isAccepted,
                        isDisabled: !controller.institution.isEnabled,
                        image: controller.institution.avatarImage,
                      ),
                      RowTextContent(
                        title: "Email",
                        details: controller.institution.email,
                        icon: Icon(Icons.mail, color: Color(0xFF17A436)),
                        outerOnPressed: controller.sendMail,
                      ),
                      RowSpace(),
                      (!controller.institution.isAccepted)
                          ? RowButton(text: "regisztráció jóváhagyása", onPressed: controller.acceptRegistration)
                          : Container(),
                      (controller.institution.isAccepted && !controller.institution.isEnabled)
                          ? RowButton(text: "fiók feloldása", onPressed: controller.enableInstitution)
                          : (controller.institution.isAccepted && controller.institution.isEnabled)
                              ? RowButton(
                                  text: "fiók tiltása",
                                  color: Color(0xFFE74C3C),
                                  onPressed: controller.disableInstitution)
                              : Container(),
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
