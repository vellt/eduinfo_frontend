import 'package:eduinfo/screens/auth/registration/person_registration/person_registration_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonRegistrationController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();

  void Registration() async {
    if(password1.text.trim() == password2.text.trim()){
      try {
        var responseData = await PersonRegistrationNetwork.registration(email.text.trim(), fullName.text.trim(), password1.text.trim());
        if (responseData["code"] == 200) {
          Get.snackbar(responseData['message'], "Jelentkezz be!");
          Get.offAllNamed('/login');
        } else if (responseData['errors'].isNotEmpty) {
          Get.snackbar(responseData['message'], responseData['errors']['errors'][0]['msg']);
        } else {
          Get.snackbar("Hiba", responseData['message']);
        }
      } catch (e) {
        print("Hiba történt: $e");
        Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
      }
    }else{
      Get.snackbar("Hiba", "A jelszó és a jelszó megerősítésnek egyeznie kell.");
    }
  } 

  void back(){
    Get.back();
  }
}