import 'package:eduinfo/screens/dashboard/institution/settings/settings_chooser/settings_chooser_controller.dart';
import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_secondary.dart';
import 'package:eduinfo/widgets/loading_container.dart';
import 'package:eduinfo/widgets/row_button.dart';
import 'package:eduinfo/widgets/row_image_content.dart';
import 'package:eduinfo/widgets/row_text_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsChooserScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(SettingsChooserController()),
      builder: (controller) {
        return AppBody(
          isFloatingButton: false,
          child: LoadingContainer(
            startLoading: controller.isLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppHeaderSecondary(text: "Fiókbeállítások", backPressed: controller.back),
                Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      RowImageContent(
                        image: controller.institution.avatarImage,
                        text: controller.institution.name,
                        isAccepted: true,
                        isDisabled: false,
                        description: "publikus nézet",
                        onPressed: controller.navigateToPublicView,
                      ),
                      RowTextContent(
                        title: "Profile módosítása", 
                        details: 'borítókép, profilkép, név, email, jelszó',
                        onPressed: controller.navigateToProfileEdit,
                        outerOnPressed: controller.navigateToProfileEdit,
                      ),
                      RowTextContent(
                        title: "Publikus elérhetőségek", 
                        details: 'telefon, email, weboldal',
                        onPressed: controller.navigateToPublicContacts,
                        outerOnPressed: controller.navigateToPublicContacts,
                      ),
                      RowTextContent(
                        title: "Intézmény leírása", 
                        details: 'Adj az intéznényről leírást',
                        onPressed: controller.navigateToPublicDescription,
                        outerOnPressed: controller.navigateToPublicDescription,
                      ),
                      RowTextContent(
                        title: "Intézmény besorolása", 
                        details: 'Egyetem, középiskola, gimnázium..',
                        onPressed: controller.navigateToInstitutionCategories,
                        outerOnPressed: controller.navigateToInstitutionCategories,
                      ),
                    ],
                  ),
                ),
              ),
              RowButton(
                text: "fiók törlése",
                color: Color(0xFFE74C3C),
                onPressed: controller.deleteProfile,
              )
              ],
            ),
          ),
        );
      }
    );
  }
}