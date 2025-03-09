import 'package:eduinfo/screens/dashboard/institution/settings/public_contacts/edit_email/edit_email_network.dart';
import 'package:eduinfo/models/public_email.dart';
import 'package:eduinfo/models/institution.dart';
import 'package:eduinfo/widgets/contact_bottom_sheet.dart';
import 'package:eduinfo/widgets/row_text_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditEmailController  extends GetxController{
  Institution institution=Get.arguments['institution'] as Institution;
  String token=Get.arguments['token'] as String;

  TextEditingController titleController=TextEditingController();
  TextEditingController emailController=TextEditingController();

  bool isLoading=false;
  
  void newEmail(){
    titleController.clear();
    emailController.clear();
    Get.bottomSheet(isScrollControlled: true,ContactBottomSheet(
      headerTitle: "E-mail",
      buttonTitle: "Hozzáadás",
      bottomInputName: "E-mail",
      bottomInputPlaceholder: "Az elérhetőség e-mail-címe",
      titleController: titleController, 
      inputController: emailController,
      textInputType: TextInputType.text,
      onPressed: () async {
        try {
          isLoading=true;
          update();
          var response = await EditEmailNetwork.createEmail(token, PublicEmail(id: 0, title: titleController.text.trim(), email: emailController.text.trim()));
          if (response['code'] == 200) {
            institution.emails=(response['data'] as List).map((email)=>PublicEmail.fromJson(email)).toList();
          } else{
            Get.snackbar("Rendszerüzenet",  response['message']);
          }
        } catch (e) {
          print("Hiba történt: $e");
          Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
        } finally {
          isLoading=false;
          update();
        }
      },));
  }

  void editEmail(PublicEmail email){
    titleController.text=email.title;
    emailController.text=email.email;
    Get.bottomSheet(isScrollControlled: true,ContactBottomSheet(
      removePressed: () => deleteEmail(email),
      headerTitle: "E-mail",
      buttonTitle: "Módosítás",
      bottomInputName: "E-mail",
      bottomInputPlaceholder: "Az elérhetőség e-mail-címe",
      titleController: titleController, 
      inputController: emailController,
      textInputType: TextInputType.text,
      onPressed: () async {
        try {
          isLoading=true;
          update();
          var response = await EditEmailNetwork.updateEmail(token, PublicEmail(id: email.id, title: titleController.text.trim(), email: emailController.text.trim()));
          if (response['code']==200) {
            institution.emails=(response['data'] as List).map((email)=>PublicEmail.fromJson(email)).toList();
          } else{
            Get.snackbar("Rendszerüzenet",  response['message']);
          }
        } catch (e) {
          print("Hiba történt: $e");
          Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
        } finally {
          isLoading=false;
          update();
        }
      },));
  }

  void deleteEmail(PublicEmail email) async {
    try {
      Get.back();
      isLoading=true;
      update();
      var response = await EditEmailNetwork.deleteEmail(token, email);
      if (response['code']==200) {
        institution.emails.removeWhere((x)=>x.id==email.id); /* optimalizálás */
      } else{
        Get.snackbar("Rendszerüzenet",  response['message']);
      }
    } catch (e) {
      print("Hiba történt: $e");
      Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
    } finally {
      isLoading=false;
      update();
    }
  }

  void back(){
    Get.back();
  }
  
  List<Widget> emails() {
    return institution.emails.map((email)=>RowTextContent(
      title: email.title,
      details: email.email,
      icon: Icon(Icons.edit, color: Colors.grey),
      outerOnPressed: () =>editEmail(email),
      onPressed: () =>editEmail(email),
    )).toList();
  }
}