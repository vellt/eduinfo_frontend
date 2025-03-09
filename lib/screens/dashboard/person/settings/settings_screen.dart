import 'package:eduinfo/screens/dashboard/person/settings/settings_controller.dart';
import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_secondary.dart';
import 'package:eduinfo/widgets/edit_avatar_image.dart';
import 'package:eduinfo/widgets/following_header.dart';
import 'package:eduinfo/widgets/loading_container.dart';
import 'package:eduinfo/widgets/row_button.dart';
import 'package:eduinfo/widgets/row_text_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(SettingsController()),
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
                      FollowingHeader(
                        image: controller.person.avatarImage,
                        email: controller.person.email,
                        name: controller.person.name,
                        followerCount: controller.person.followedInstitutions.length,
                        onPressed: controller.navigateToFollowingList,
                      ),
                      EditAvatarImage(
                        title: "Profilkép módosítása",
                        image: controller.person.avatarImage,
                        onPressed: controller.openEditAvatar,
                      ),
                      RowTextContent(
                        title: "Név módosítása",
                        details: controller.person.name,
                        icon: Icon(Icons.edit, color: Colors.grey,),
                        onPressed: controller.openEditName,
                        outerOnPressed: controller.openEditName,
                      ),
                      RowTextContent(
                        title: "Email módosítása",
                        details: controller.person.email,
                        icon: Icon(Icons.edit, color: Colors.grey,),
                        onPressed: controller.openEditEmail,
                        outerOnPressed: controller.openEditEmail,
                      ),
                      RowTextContent(
                        title: "Jelszó módosítása",
                        details: "●●●●●●●●●●",
                        icon: Icon(Icons.edit, color: Colors.grey,),
                        onPressed: controller.openEditPassword,
                        outerOnPressed: controller.openEditPassword,
                      ),
                    ],
                  ),
                ),
              ),
              RowButton(
                text: "fiók törlése",
                color: Color(0xFFE74C3C),
                onPressed: controller.deleteProfile,
              ),
              ],
            ),
          ),
        );
      }
    );
  }
}

