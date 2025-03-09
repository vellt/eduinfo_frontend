import 'dart:async';

import 'package:eduinfo/screens/others/not_accepted_user/not_accepted_user_network.dart';
import 'package:eduinfo/widgets/confirm_dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NotAcceptedUserController extends GetxController {
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
        await NotAcceptedUserNetwork.logout(token);
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
      var response = await NotAcceptedUserNetwork.checkAccepted(token, redirect.split('_')[0]);
      if(response['code']==200) {
        redirectToDashboard(); 
      }
    } catch (e) {
      print("Hiba történt: $e");
    }
  }
}