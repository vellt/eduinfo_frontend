import 'package:eduinfo/screens/auth/login/login_network.dart';
import 'package:eduinfo/widgets/row_check_box_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RowCheckBoxController checkBoxController= RowCheckBoxController(isChecked: true);
  bool isLoading=false;
  GetStorage storage = GetStorage();

  void login() async {
    if (email.text.trim().isNotEmpty && password.text.trim().isNotEmpty) {
      try {
        isLoading=true;
        update();
        var logResponseData = await LoginNetwork.sendLogin(email.text.trim(), password.text.trim());
        print(logResponseData);
        switch (logResponseData["code"]) {
          case 200:
            var token = logResponseData['data']['token'];
            if(checkBoxController.isChecked){
                storage.write('token', token); 
            }

            var roleResponseDate = await LoginNetwork.getRole(token);
            
            if (roleResponseDate["code"] == 200) {
              print(roleResponseDate['data']['role']);
              navigateToDashboard(roleResponseDate['data']['role'], token);
            } else {
              Get.snackbar("Rendszerüzenet", roleResponseDate['message']);
            }
            break;
          default:
            if (logResponseData['errors'].isNotEmpty) {
              Get.snackbar(logResponseData['message'], logResponseData['errors']['errors'][0]['msg']);
            } else {
              Get.snackbar("Rendszerüzenet", logResponseData['message']);
            }
            break;
        }
      } catch (e) {
        print("Hiba történt: $e");
        Get.snackbar("Rendszerüzenet", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
      } finally{
        isLoading=false;
        update();
      }
    } else {
      Get.snackbar("Rendszerüzenet", "Kérem adja meg e-mail-címét és jelszavát.");
    }
  }

  void navigateToDashboard(String role,String token) {
    Get.offAllNamed('/${role}_dashboard', arguments: {"token":token});
    print(role);
  }

  void navigateToRegistrationChooser() {
    Get.toNamed('/registration_chooser');
  }

  @override
  void onReady() async{
    super.onReady();
    String? token = storage.read('token'); // Token kiolvasása
    if (token != null && token.isNotEmpty) {
      // Token létezik, irányítsd a felhasználót a kezdőképernyőre
      try {
        var roleResponseDate = await LoginNetwork.getRole(token);
        if (roleResponseDate["code"] == 200) {
          navigateToDashboard(roleResponseDate['data']['role'], token);
        } else {
          Get.snackbar("Rendszerüzenet", roleResponseDate['message']);
        }
      } catch (e) {
        print("Hiba történt: $e");
        Get.snackbar("Rendszerüzenet","Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
      }

    }
  }
}
