
import 'package:eduinfo/screens/dashboard/institution/settings/edit_description/edit_description_network.dart';
import 'package:eduinfo/models/institution.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class EditDescriptionController extends GetxController {
  String token=Get.arguments['token'] as String;
  Institution institution=Get.arguments['institution'] as Institution;
  
  TextEditingController textEditingController= TextEditingController();
  bool isLoading=false;

  @override
  void onReady() {
    super.onReady();
    textEditingController.text=institution.description;
  }

  void back(){
    Get.back();
  }

  void save () async {
    try {
      isLoading = true;
      update();
      var response = await EditDescriptionNetwork.updateDescription(token, textEditingController.text.trim());
      if (response['code']==200) {
        institution.description=response['data']['description'];
        back();
      } 
    } catch (e) {
      print("Hiba történt: $e");
      Get.snackbar("Rendszerüzenet", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
    } finally {
      isLoading = false;
      update();
    }
  }

}