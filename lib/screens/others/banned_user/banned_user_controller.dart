import 'dart:async';

import 'package:eduinfo/screens/others/banned_user/banned_user_network.dart';
import 'package:eduinfo/widgets/confirm_dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class BannedUserController extends GetxController{
  Timer? timer;

  String token = Get.arguments["token"] as String;
  String redirect = Get.arguments["redirect"] as String;

  bool isLoading=false;
  GetStorage storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    startAutoRefresh();
  }

  @override
  void onClose() {
    timer?.cancel(); // Timer leállítása
    super.onClose();
  }

  void startAutoRefresh() {
    timer = Timer.periodic(Duration(seconds: 5), (_) {
      checkUserStatus();
    });
  }


  void redirectToDashboard(){
    Get.offAllNamed(redirect, arguments: {
      "token":token
    });
  }

  void logout(){
    Get.dialog(ConfirmDialog(title: "Kijelentkezés", description: "Biztosan ki szeretne jelentkezni?", onConfirm: () async{
      try {
        isLoading = true;
        update();
        await BannedUserNetwork.logout(token);
        storage.erase();
        Get.offAllNamed("login");
      } catch (e) {
        print("Hiba történt: $e");
        Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
      } finally {
        isLoading = false;
        update();
      }
    }),
    barrierDismissible: false);
  }
  
  void checkUserStatus() async {
    try {
      var response = await BannedUserNetwork.checkEnabled(token, redirect.split('_')[0]);
      if(response['code']== 200) {
        redirectToDashboard();
      }
    } catch (e) {
      print("Hiba történt: $e");
    }
  }

  void sendMail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'admin@eduinfo.hu',
      queryParameters: {
        'subject': "Tiltás feloldása",
        'body': "Kedves Admin!",
      },
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        throw "Nem sikerült megnyitni az e-mail küldő alkalmazást.";
      }
    } catch (e) {
      print("Hiba történt: $e");
    }
  }
}