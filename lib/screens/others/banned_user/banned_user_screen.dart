import 'package:eduinfo/screens/others/banned_user/banned_user_controller.dart';
import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_primary.dart';
import 'package:eduinfo/widgets/loading_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BannedUserScreen extends StatelessWidget {
  const BannedUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(BannedUserController()),
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
                                Text("Fiókja tiltásra került",  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: Text("Amennyiben tévedés történt, kérjük vegye fel az adminisztrátorral a kapcsolatot. ", textAlign: TextAlign.center,style: TextStyle(color: Colors.grey, fontSize: 16),),
                                ),
                                CupertinoButton(
                                  onPressed: controller.sendMail,
                                  child: Text("admin@eduinfo.hu", style: TextStyle(fontWeight: FontWeight.normal, color: Color(0xFF17A436), decoration: TextDecoration.underline,decorationColor: Color(0xFF17A436)),)
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