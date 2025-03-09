import 'package:eduinfo/screens/dashboard/admin/home/home_controller.dart';
import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_primary.dart';
import 'package:eduinfo/widgets/loading_container.dart';
import 'package:eduinfo/widgets/row_tab.dart';
import 'package:eduinfo/widgets/row_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Két fül van: Intézmények és Felhasználók
      child: GetBuilder(
        init: Get.put(HomeController()),
        builder: (controller) {
          return AppBody(
            isFloatingButton: false,
            child: Column(
              children: [
                AppHeaderPrimary(
                  title: "EduInfo",
                  onLogout: controller.logout,
                ),
                Expanded(
                  child: LoadingContainer(
                    startLoading: controller.isLoading,
                    child: Column(
                      children: [
                        RowTab(
                          tabs: [
                            Tab(text: "Intézmények"),
                            Tab(text: "Felhasználók"),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              // Intézmények Tab Tartalma
                              Column(
                                children: [
                                  RowTextField(
                                    controller: controller.searchInstitution,
                                    icon: Icons.search,
                                    hintText: "Keresés",
                                  ),
                                  Expanded(
                                    child: RefreshIndicator(
                                      onRefresh: ()=>controller.loadHomeData(true),
                                      child: SingleChildScrollView(
                                        physics: BouncingScrollPhysics(),
                                        child: Column(
                                          children: controller.selectedInstitutionList,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Felhasználók Tab Tartalma
                                Column(
                                children: [
                                  RowTextField(
                                    controller: controller.searchPerson,
                                    icon: Icons.search,
                                    hintText: "Keresés",
                                  ),
                                  Expanded(
                                    child: RefreshIndicator(
                                      onRefresh: ()=>controller.loadHomeData(true),
                                      child: SingleChildScrollView(
                                        physics: BouncingScrollPhysics(),
                                        child: Column(
                                          children: controller.selectedPersonList,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
