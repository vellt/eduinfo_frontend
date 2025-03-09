import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eduinfo/screens/dashboard/institution/public_view/public_view_controller.dart';
import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_secondary.dart';
import 'package:eduinfo/widgets/content_container.dart';
import 'package:eduinfo/widgets/loading_container.dart';
import 'package:eduinfo/widgets/no_content_text.dart';
import 'package:eduinfo/widgets/public_header.dart';
import 'package:eduinfo/widgets/row_sub_text_content.dart';
import 'package:eduinfo/widgets/row_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PublicViewScreen extends StatelessWidget {
  const PublicViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(PublicViewController()),
      builder: (controller) {
        return AppBody(
          isFloatingButton: !controller.isLoading,
          floatingActionButtonIcon: (controller.showHeader)?Icons.keyboard_arrow_up_sharp:Icons.keyboard_arrow_down_sharp,
          floatingActionButtonPadding: EdgeInsets.zero,
          floatingActionButtonPressed: controller.changeHeaderVisibility,
          child: LoadingContainer(
            startLoading: controller.isLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppHeaderSecondary(
                  text:  "Adatlap", 
                  image: controller.institution.avatarImage,
                  backPressed: controller.back,
                  actions: [
                    
                    
                    if(controller.institution.phones.length>0)
                    IconButton(
                      onPressed: controller.showPhones, 
                      icon: Icon(Icons.phone, color: Color(0xFF17A436)),
                    ),
                    if(controller.institution.emails.length>0)
                    IconButton(
                      onPressed: controller.showEmails, 
                      icon: Icon(Icons.mail, color: Color(0xFF17A436)),
                    ),
                    if(controller.institution.websites.length>0)
                    IconButton(
                      onPressed: controller.showWebsites, 
                      icon: Icon(Icons.language, color: Color(0xFF17A436)),
                    ),
                  ],
                ),
                (controller.showHeader)?
                FadeInRight(
                  duration: Duration(milliseconds: 100),
                  child: publicHeader(
                    bannerImage: controller.institution.bannerImage,
                    avatarImage: controller.institution.avatarImage,
                    title: controller.institution.name,
                    followers: controller.institution.followers,
                    followed: controller.institution.followed,
                    onMessage: controller.role!="person" ? null : controller.navigateToMessageDetails,
                    onFollowing: controller.role!="person" ? null : controller.institution.followed
                      ? controller.unFollow
                      : controller.follow
                  ),
                ):Container(),
                RowTab(
                  tabs: [
                    Tab(text: "Hírfolyam"),
                    Tab(text: "Események"),
                    Tab(text: "Rólunk"),
                  ],
                  tabController: controller.tabController,
                  tabAlignment: (controller.showHeader)? TabAlignment.center: TabAlignment.start,
                  color: Color(0xFF17A436),
                ),
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      // Bejegyzések Tab Tartalma
                      FadeInUp(
                        duration: Duration(milliseconds: 100),
                        animate: controller.animate,
                        child: ContentContainer(
                          noContentWidget: NoContentText(text: "Az intézménynek nincs bejegyzése"),
                          children: controller.stories(),
                        ),
                      ),
                      // Események Tab Tartalma
                      FadeInUp(
                        duration: Duration(milliseconds: 100),
                        animate: controller.animate,
                        child: ContentContainer(
                          noContentWidget: NoContentText(text: "Az intézménynek nincs eseménye"),
                          children: controller.events(),
                        ),
                      ),
                      // leírás
                      FadeInUp(
                        duration: Duration(milliseconds: 100),
                        animate: controller.animate,
                        child: ContentContainer(
                          noContentWidget: NoContentText(text: "Az intézménynek nincs leírása"),
                          children: [
                            if(controller.institution.description.trim()!="")
                            RowSubTextContent(title: controller.institution.description)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              
              ],
            ),
          ),
        );
      }
    );
  }
}





