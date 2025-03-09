import 'package:animate_do/animate_do.dart';
import 'package:eduinfo/screens/dashboard/person/home/home_controller.dart';
import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_primary.dart';
import 'package:eduinfo/widgets/loading_container.dart';
import 'package:eduinfo/widgets/no_content_banner_for_person.dart';
import 'package:eduinfo/widgets/no_message_banner_for_person.dart';
import 'package:eduinfo/widgets/person_home_events.dart';
import 'package:eduinfo/widgets/row_navbar_person.dart';
import 'package:eduinfo/widgets/row_navbar_view.dart';
import 'package:eduinfo/widgets/row_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(HomeController()),
      builder: (controller) {
        return AppBody(
          isFloatingButton: false,
          child: LoadingContainer(
            startLoading: controller.isLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppHeaderPrimary(title: "EduInfo", onLogout: controller.logout),
                RowNavbarView(
                  controller: controller.navBarController,
                  children: (index) {
                    switch (index) {
                      case 0: return [
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: ()=>controller.getHomeData(true),
                            child: NoContentBannerForPerson(
                              contentLength: controller.eventsData.length + controller.storiesData.length,
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: FadeInUp(
                                  duration: Duration(milliseconds: 200),
                                  child: Column(
                                    children: [
                                      PersonHomeEvents(
                                        events: controller.events(),
                                        allEventsOnPressed: controller.openEventsChooser,
                                      ),
                                      NoContentBannerForPerson(
                                        child: Column(children:[...controller.stories()],),
                                        contentLength: controller.stories().length,
                                        showImage: false,
                                      )
                                      ,
                                    ],
                                  ),
                                ),
                              ),
                              
                            ),
                          ),
                        )
                      ];
                      case 1: return [
                        Expanded(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: FadeInUp(
                              duration: Duration(milliseconds: 200),
                              child: Column(
                                children: controller.categories(),
                              ),
                            ),
                          ),
                        ),
                      ];
                      default: return  [
                        NoMessageBannerForPerson(
                          messageLength: controller.messagingRoomData.length,
                          children: [
                            RowTextField(
                              controller: controller.messagesSearchController, 
                              hintText: "Keresés",
                              icon: Icons.search,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: FadeInUp(
                                  duration: Duration(milliseconds: 200),
                                  child: Column(
                                    children: controller.messagingRooms(),
                                  ),
                                ),
                              ))
                            ]
                        )
                      ];
                    }
                  },
                ),
                RowNavbarPerson(
                  controller: controller.navBarController,
                  haveNotification: controller.hasNotification,
                  image: controller.person.avatarImage,
                  imagePressed: controller.navigateToSettings,
                ),
              ],
            ),
          ),
        );
      });
  }
}

