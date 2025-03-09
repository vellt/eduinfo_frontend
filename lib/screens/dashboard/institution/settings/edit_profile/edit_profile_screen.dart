import 'package:eduinfo/screens/dashboard/institution/settings/edit_profile/edit_profile_controller.dart';
import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_secondary.dart';
import 'package:eduinfo/widgets/edit_avatar_image.dart';
import 'package:eduinfo/widgets/edit_banner_image.dart';
import 'package:eduinfo/widgets/loading_container.dart';
import 'package:eduinfo/widgets/row_text_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
    init: Get.put(EditProfileController()),
    builder: (controller) {
      return AppBody(
        floatingActionButtonPadding: EdgeInsets.zero,
        isFloatingButton: false,
        child: LoadingContainer(
          startLoading: controller.isLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppHeaderSecondary(
                text: "Profil módosítása",
                backPressed: controller.back,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      EditBannerImage(
                        title: "Borítókép módosítása",
                        showNetworkImage: controller.showNetworkImage,
                        showFileImage: false,
                        image: controller.institution.bannerImage,
                        outerOnPressed: controller.openEditBanner,
                      ),
                      EditAvatarImage(
                        title: "Profilkép módosítása",
                        image: controller.institution.avatarImage,
                        onPressed: controller.openEditAvatar,
                      ),
                      RowTextContent(
                        title: "Név módosítása",
                        details: controller.institution.name,
                        icon: Icon(Icons.edit, color: Colors.grey,),
                        onPressed: controller.openEditName,
                        outerOnPressed: controller.openEditName,
                      ),
                      RowTextContent(
                        title: "Email módosítása",
                        details: controller.institution.email,
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
            ],
          ),
        ),
      );
    });
  }
}