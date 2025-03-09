import 'package:eduinfo/screens/dashboard/institution/event/edit_event/edit_event_controller.dart';
import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_secondary.dart';
import 'package:eduinfo/widgets/date_time_picker_row.dart';
import 'package:eduinfo/widgets/date_time_picker_text.dart';
import 'package:eduinfo/widgets/edit_banner_image.dart';
import 'package:eduinfo/widgets/loading_container.dart';
import 'package:eduinfo/widgets/row_text_content.dart';
import 'package:eduinfo/widgets/row_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditEventScreen extends StatelessWidget {
  const EditEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
    init: Get.put(EditEventController()),
    builder: (controller) {
      return AppBody(
        floatingActionButtonPadding: EdgeInsets.zero,
        isFloatingButton: !controller.isLoading,
        floatingActionButtonIcon: Icons.send,
        floatingActionButtonPressed: controller.updateEvent,
        child: LoadingContainer(
          startLoading: controller.isLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppHeaderSecondary(
                text: "Esemény szerkesztése",
                backPressed: controller.back,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      EditBannerImage(
                        title: "Borítókép",
                        showFileImage: controller.showFileImage,
                        showNetworkImage: controller.showNetworkImage,
                        image : controller.event.bannerImage!="" && controller.image==null?controller.institution.bannerImage:controller.event.bannerImage??controller.institution.bannerImage,
                        fileImage:controller.image!=null? controller.image!.path:null,
                        outerOnPressed: controller.openEditBanner,
                        innerOnPressed: controller.restoreBanner,
                      ),
                      RowTextContent(title: "Esemény címe"),
                      RowTextField(controller: controller.titleController, hintText: "Cím"),
                      RowTextContent(title: "Esemény időpontja"),
                      DateTimePickerRow(
                        row: [
                          DateTimePickerText(
                            onPressed: controller.openDayChooser,
                            icon: Icons.date_range,
                            text: controller.getFormattedDate(),
                          ),
                          DateTimePickerText(
                            onPressed: controller.openTimeChooser, 
                            icon: Icons.access_time, 
                            text: controller.getFormattedTime(),
                          )
                        ],
                      ),
                      RowTextContent(title: "Esemény helyszíne"),
                      RowTextField(
                        controller: controller.locationController, 
                        hintText: "Helyszín",
                      ),
                      RowTextContent(
                        title: "Esemény leírása",
                        prefixIcon: Icon(Icons.subject_outlined, color: Colors.grey,),
                        onPressed: controller.openEventDescription,
                      ),
                      RowTextContent(
                        title: "Linkek",
                        prefixIcon: Icon(Icons.language,color: Colors.grey),
                        onPressed: controller.openEventLinks,
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