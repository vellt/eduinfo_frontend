import 'package:eduinfo/screens/dashboard/person/institution_results/institution_results_controller.dart';
import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_secondary.dart';
import 'package:eduinfo/widgets/loading_container.dart';
import 'package:eduinfo/widgets/row_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InstitutionResultsScreen extends StatelessWidget {
  const InstitutionResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(InstitutionResultsController()),
      builder: (controller) {
        return AppBody(
          floatingActionButtonPadding: EdgeInsets.zero,
          isFloatingButton: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppHeaderSecondary(
                text: controller.category.category,
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
                        child: (controller.institutionsData.length==0)
                        ? Center(child: Text("Nincs találat.", style: TextStyle(color: Colors.grey),),)
                        : SingleChildScrollView(
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