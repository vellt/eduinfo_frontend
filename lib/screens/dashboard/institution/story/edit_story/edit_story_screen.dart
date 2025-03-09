import 'package:eduinfo/screens/dashboard/institution/story/edit_story/edit_story_controller.dart';
import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_secondary.dart';
import 'package:eduinfo/widgets/big_text_input.dart';
import 'package:eduinfo/widgets/edit_banner_image.dart';
import 'package:eduinfo/widgets/loading_container.dart';
import 'package:eduinfo/widgets/row_text_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditStoryScreen extends StatelessWidget {
  const EditStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(EditStoryController()),
      builder: (controller) {
        return AppBody(
          floatingActionButtonPadding: EdgeInsets.zero,
          isFloatingButton: !controller.isLoading,
          floatingActionButtonIcon: Icons.send,
          floatingActionButtonPressed: controller.updateStory,
          child: LoadingContainer(
            startLoading: controller.isLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppHeaderSecondary(
                  text: "Bejegyzés módosítása",
                  backPressed: controller.back,
                ),
                EditBannerImage(
                  title: "Borítókép",
                  showNetworkImage: false,
                  showFileImage: controller.showFileImage,
                  image : controller.institution.bannerImage,
                  fileImage: controller.image!=null? controller.image!.path:null,
                  outerOnPressed: controller.openEditBanner,
                  innerOnPressed: controller.removeBanner,
                ),
                RowTextContent(
                  title: "Bejegyzés leírása", 
                  prefixIcon: Icon(Icons.subject_outlined,color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: BigTextInput(
                      controller: controller.textEditingController, 
                      hintText: "Bejegyzés szöveges tartalma..",
                    ),
                  ) 
                ),
              ],
            ),
          ),
        );
      });
  }
}