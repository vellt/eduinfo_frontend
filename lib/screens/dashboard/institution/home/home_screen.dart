import 'package:animate_do/animate_do.dart';
import 'package:eduinfo/screens/dashboard/institution/home/home_controller.dart';
import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_primary.dart';
import 'package:eduinfo/widgets/loading_container.dart';
import 'package:eduinfo/widgets/no_event_banner_for_institution.dart';
import 'package:eduinfo/widgets/no_message_banner_for_institution.dart';
import 'package:eduinfo/widgets/no_story_banner_for_institution.dart';
import 'package:eduinfo/widgets/row_navbar_institution.dart';
import 'package:eduinfo/widgets/row_navbar_view.dart';
import 'package:eduinfo/widgets/row_tab.dart';
import 'package:eduinfo/widgets/row_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Get.put(HomeController()),
        builder: (controller) {
          return AppBody(
            isFloatingButton: controller.isFloatingButton && controller.isLoading==false,
            floatingActionButtonPressed: controller.floatingActionButtonClick,
            child: LoadingContainer(
              startLoading: controller.isLoading,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppHeaderPrimary(title: "EduInfo", onLogout: controller.logout),
                  RowNavbarView(
                    controller: controller.navBarController,
                    children: (index) {
                      if (index == 0) {
                        return [
                          RowTab(
                            tabs: [
                              Tab(text: "Bejegyzések"),
                              Tab(text: "Események"),
                            ],
                            tabController: controller.tabController,
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: controller.tabController,
                              children: [
                                // Bejegyzések Tab Tartalma
                                NoStoryBannerForInstitution(
                                  storiesLength: controller.institution.stories.length,
                                  child: RefreshIndicator(
                                    onRefresh: controller.loadProfileData,
                                    child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: FadeInUp(
                                        duration: Duration(milliseconds: 200),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: controller.stories(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // Események Tab Tartalma
                                NoEventBannerForInstitution(
                                  eventLength: controller.institution.events.length,
                                  child:RefreshIndicator(
                                    onRefresh: controller.loadProfileData,
                                    child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: FadeInUp(
                                        duration: Duration(milliseconds: 200),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: controller.events()
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ];
                      } else {
                        // messages
                        return [
                          NoMessageBannerForInstitution(
                            messageLength: controller.messagingRoomData.length,
                            children: [
                              RowTextField(
                                controller: controller.messagesSearchController, 
                                hintText: "Keresés",
                                icon: Icons.search,
                              ),
                              Expanded(
                                child: FadeInUp(
                                  duration: Duration(milliseconds: 200),
                                  child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
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
                  RowNavbarInstitution(
                    controller: controller.navBarController,
                    haveNotification: controller.hasNotification,
                    image: controller.institution.avatarImage,
                    imagePressed: controller.navigateToSettings,
                  ),
                ],
              ),
            ),
          );
        });
  }
}



