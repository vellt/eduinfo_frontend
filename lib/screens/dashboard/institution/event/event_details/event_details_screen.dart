import 'package:eduinfo/screens/dashboard/institution/event/event_details/event_details_controller.dart';
import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_secondary.dart';
import 'package:eduinfo/widgets/event_header.dart';
import 'package:eduinfo/widgets/flat_bordered_button.dart';
import 'package:eduinfo/widgets/row_sub_text_content.dart';
import 'package:eduinfo/widgets/row_sub_text_icon_content.dart';
import 'package:eduinfo/widgets/row_text_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
    init: Get.put(EventDetailsController()),
    builder: (controller) {
      return AppBody(
        floatingActionButtonPadding: EdgeInsets.zero,
        isFloatingButton: controller.showFloatingButton(),
        floatingActionButtonIcon: Icons.link,
        floatingActionButtonPressed: controller.showLinks,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppHeaderSecondary(
              text: "Esemény",
              backPressed: controller.back,
              actions: [
                FlatBorderedButton(
                  text: "Érdeklődöm",
                  disable: controller.token.isEmpty,
                  color: controller.event.interested?Color(0xFF17A436):null,
                  onPressed: () {
                    if(controller.event.interested){
                      controller.unInterest();
                    }else{
                      controller.interest();
                    }
                  },
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    EventHeader(
                      avatarImage: controller.institution.avatarImage,
                      coverImage: controller.event.bannerImage?? controller.institution.bannerImage,
                      day: controller.event.day.toString(),
                      month: controller.event.month.toUpperCase(),
                    ),
                    RowTextContent(title: controller.event.title==""?"Névtelen esemény":controller.event.title),
                    RowSubTextIconContent(
                      icon: Icons.access_time,
                      title: controller.event.time,
                    ),
                    RowSubTextIconContent(
                      icon: Icons.place_outlined,
                      title: controller.event.location==""?"nincs megadva":controller.event.location,
                    ),
                    RowSubTextIconContent(
                      icon: Icons.people_alt_outlined,
                      title: "${controller.event.interestedCount} érdeklődő",
                    ),
                    RowSubTextContent(title: controller.event.description),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}





