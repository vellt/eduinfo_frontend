import 'package:eduinfo/screens/dashboard/institution/story/create_story/create_story_controller.dart';
import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_secondary.dart';
import 'package:eduinfo/widgets/big_text_input.dart';
import 'package:eduinfo/widgets/edit_banner_image.dart';
import 'package:eduinfo/widgets/loading_container.dart';
import 'package:eduinfo/widgets/row_text_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateStoryScreen extends StatelessWidget {
  const CreateStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
    init: Get.put(CreateStoryController()),
    builder: (controller) {
      return AppBody(
        floatingActionButtonPadding: EdgeInsets.zero,
        isFloatingButton: !controller.isLoading,
        floatingActionButtonIcon: Icons.send,
        floatingActionButtonPressed: controller.createStory,
        child: LoadingContainer(
          startLoading: controller.isLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppHeaderSecondary(
                text: "Bejegyzés létrehozása",
                backPressed: controller.back,
              ),
              EditBannerImage(
                title: "Borítókép",
                showFileImage: controller.showFileImage,
                showNetworkImage: false,
                image : controller.institution.bannerImage,
                fileImage:controller.image!=null? controller.image!.path:null,
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