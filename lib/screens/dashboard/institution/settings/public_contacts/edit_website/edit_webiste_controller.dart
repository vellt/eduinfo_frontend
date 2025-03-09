import 'package:eduinfo/screens/dashboard/institution/settings/public_contacts/edit_website/edit_website_network.dart';
import 'package:eduinfo/models/institution.dart';
import 'package:eduinfo/models/public_website.dart';
import 'package:eduinfo/widgets/contact_bottom_sheet.dart';
import 'package:eduinfo/widgets/row_text_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditWebisteController extends GetxController {
  Institution institution=Get.arguments['institution'] as Institution;
  String token=Get.arguments['token'] as String;

  TextEditingController titleController=TextEditingController();
  TextEditingController websiteController=TextEditingController();

  bool isLoading=false;
  
  void newWebsite() {
    titleController.clear();
    websiteController.clear();
    Get.bottomSheet(isScrollControlled: true,ContactBottomSheet(
      headerTitle: "Weboldal",
      buttonTitle: "Hozzáadás",
      bottomInputName: "Weboldal",
      bottomInputPlaceholder: "Az elérhetőség webcíme",
      titleController: titleController, 
      inputController: websiteController,
      textInputType: TextInputType.text,
      onPressed: () async {
        try {
          isLoading=true;
          update();
          var response = await EditWebsiteNetwork.createWebsite(token, PublicWebsite(id: 0, title: titleController.text.trim(), website: websiteController.text.trim()));
          if (response['code']==200) {
            institution.websites=(response['data'] as List).map((website)=>PublicWebsite.fromJson(website)).toList();
          } else{
            Get.snackbar("Rendszerüzenet",  response['message']);
          }
        } catch (e) {
          print("Hiba történt: $e");
          Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
        } finally{
          isLoading=false;
          update();
        }
      },));
    
  }

  void editWebsite(PublicWebsite website) {
    titleController.text=website.title;
    websiteController.text=website.website;
    Get.bottomSheet(isScrollControlled: true,ContactBottomSheet(
      removePressed: () => deleteWebsite(website),
      headerTitle: "Weboldal",
      buttonTitle: "Módosítás",
      bottomInputName: "Weboldal",
      bottomInputPlaceholder: "Az elérhetőség webcíme",
      titleController: titleController, 
      inputController: websiteController,
      textInputType: TextInputType.text,
      onPressed: () async {
        try {
          isLoading=true;
          update();
          var response = await EditWebsiteNetwork.updateWebsite(token, PublicWebsite(id: website.id, title: titleController.text.trim(), website: websiteController.text.trim()));
          if(response['code']==200) {
            institution.websites=(response['data'] as List).map((website)=>PublicWebsite.fromJson(website)).toList();
          } else{
            Get.snackbar("Rendszerüzenet",  response['message']);
          }
        } catch (e) {
          print("Hiba történt: $e");
          Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
        } finally{
          isLoading=false;
          update();
        }
      },));
  }

  void deleteWebsite(PublicWebsite website)async{
    try {
      Get.back();
      isLoading=true;
      update();
      var response = await EditWebsiteNetwork.deleteWebsite(token, website);
      if (response['code']==200) {
        institution.websites.removeWhere((x)=>x.id==website.id);
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
  
  List<Widget> websites() {
    return institution.websites.map((website)=>RowTextContent(
      title: website.title,
      details: website.website,
      icon: Icon(Icons.edit, color: Colors.grey),
      onPressed: () =>editWebsite(website),
      outerOnPressed: () =>editWebsite(website),
    )).toList();
  }
}