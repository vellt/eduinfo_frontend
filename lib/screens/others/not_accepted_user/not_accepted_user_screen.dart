import 'package:eduinfo/screens/others/not_accepted_user/not_accepted_user_controller.dart';
import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_primary.dart';
import 'package:eduinfo/widgets/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class NotAcceptedUserScreen extends StatelessWidget {
  const NotAcceptedUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(NotAcceptedUserController()),
      builder: (controller) {
        return AppBody(
            floatingActionButtonPadding: EdgeInsets.zero,
            isFloatingButton: false,
            child: LoadingContainer(
              startLoading: controller.isLoading,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppHeaderPrimary(title: "EduInfo", onLogout: controller.logout),
                  Expanded(
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/images/banned.svg', // Az elérési útvonal
                        ),
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Kérem várjon",  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: Text("Az adminisztrátor hamarosan felveszi Önnel a kapcsolatot.", textAlign: TextAlign.center,style: TextStyle(color: Colors.grey, fontSize: 16),),
                                ),
                              ],
                            ),
                          ),
                        )
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