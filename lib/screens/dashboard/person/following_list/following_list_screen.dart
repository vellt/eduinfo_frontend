import 'package:eduinfo/screens/dashboard/person/following_list/following_list_controller.dart';
import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_secondary.dart';
import 'package:eduinfo/widgets/loading_container.dart';
import 'package:eduinfo/widgets/row_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowingListScreen extends StatelessWidget {
  const FollowingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(FollowingListController()),
      builder: (controller) {
        return AppBody(
          floatingActionButtonPadding: EdgeInsets.zero,
          isFloatingButton: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppHeaderSecondary(
                text: "Követések",
                backPressed: controller.back,
              ),
              Expanded(
                child: LoadingContainer(
                  startLoading: controller.isLoading,
                  child: Column(
                    children: [
                      RowTextField(
                        controller: controller.searchEventController, 
                        hintText: "Keresés",
                        icon: Icons.search,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children:controller.institutions(),
                          )
                        ),
                  ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      });
  }
}