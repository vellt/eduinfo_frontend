import 'package:eduinfo/screens/dashboard/institution/settings/public_contacts/public_contacts_chooser/public_contacts_chooser_controller.dart';
import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_secondary.dart';
import 'package:eduinfo/widgets/row_text_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PublicContactsChooserScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(PublicContactsChooserController()),
      builder: (controller) {
        return AppBody(
          isFloatingButton: false,
          child: Column(
            children: [
              AppHeaderSecondary(text: "Publikus elérhetőségek",backPressed: Get.back),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      RowTextContent(
                        title: "Telefonos elérhetőségek", 
                        onPressed: controller.navigateToEditPhone,
                        outerOnPressed: controller.navigateToEditPhone,
                      ),
                      RowTextContent(
                        title: "E-mail-es elérhetőségek", 
                        onPressed: controller.navigateToEditEmail,
                        outerOnPressed: controller.navigateToEditEmail,
                      ),
                      RowTextContent(
                        title: "Weboldalak", 
                        onPressed: controller.navigateToEditWebsite,
                        outerOnPressed: controller.navigateToEditWebsite,
                      ),
                    ],
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