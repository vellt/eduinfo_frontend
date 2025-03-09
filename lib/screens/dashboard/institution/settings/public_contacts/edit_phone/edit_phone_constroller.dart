import 'package:eduinfo/screens/dashboard/institution/settings/public_contacts/edit_phone/edit_phone_network.dart';
import 'package:eduinfo/models/institution.dart';
import 'package:eduinfo/models/public_phone.dart';
import 'package:eduinfo/widgets/contact_bottom_sheet.dart';
import 'package:eduinfo/widgets/row_text_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPhoneConstroller extends GetxController {
  Institution institution=Get.arguments['institution'] as Institution;
  String token=Get.arguments['token'] as String;

  TextEditingController titleController=TextEditingController();
  TextEditingController phoneController=TextEditingController();

  bool isLoading=false;
  
  void newPhone(){
    titleController.clear();
    phoneController.clear();
    Get.bottomSheet(isScrollControlled: true,ContactBottomSheet(
      headerTitle: "Telefonszám",
      buttonTitle: "Hozzáadás",
      bottomInputName: "Telefonszám",
      bottomInputPlaceholder: "Az elérhetőség telefonszáma",
      titleController: titleController, 
      inputController: phoneController,
      textInputType: TextInputType.phone,
      onPressed: () async {
        try {
          isLoading=true;
          update();
          var response = await EditPhoneNetwork.createPhone(token, PublicPhone(id: 0, title: titleController.text.trim(), phone: phoneController.text.trim()));
          if (response['code']==200) {
            institution.phones=(response['data'] as List).map((phone)=>PublicPhone.fromJson(phone)).toList();
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
      }),
    );
  }

  void editPhone(PublicPhone phone){
    titleController.text=phone.title;
    phoneController.text=phone.phone;
    Get.bottomSheet(isScrollControlled: true,ContactBottomSheet(
      removePressed: () => deletePhone(phone),
      headerTitle: "Telefonszám",
      buttonTitle: "Módosítás",
      bottomInputName: "Telefonszám",
      bottomInputPlaceholder: "Az elérhetőség telefonszáma",
      titleController: titleController, 
      inputController: phoneController,
      textInputType: TextInputType.phone,
      onPressed: () async{
        try {
          isLoading=true;
          update();
          var response = await EditPhoneNetwork.updatePhone(token, PublicPhone(id: phone.id, title: titleController.text.trim(), phone: phoneController.text.trim()));
          if (response['code'] == 200) {
            institution.phones=(response['data'] as List).map((phone)=>PublicPhone.fromJson(phone)).toList();
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
      }),
    );
  }

  void deletePhone(PublicPhone phone)async{
    try {
      Get.back();
      isLoading=true;
      update();
      var response = await EditPhoneNetwork.deletePhone(token, phone);
      if (response['code']==200) {
        institution.phones.removeWhere((x)=>x.id==phone.id); /* optimalizálás */
      } else{
        Get.snackbar("Rendszerüzenet",  response['message']);
      }
    } catch (e) {
      print("Hiba történt: $e");
      Get.snackbar( "Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
    } finally {
      isLoading=false;
      update();
    }
  }

  void back(){
    Get.back();
  }
  
  List<Widget> phones() {
    return institution.phones.map((phone)=> RowTextContent(
      title: phone.title,
      details: phone.phone,
      icon: Icon(Icons.edit, color: Colors.grey),
      onPressed: () => editPhone(phone),
      outerOnPressed: () => editPhone(phone),
    )).toList();
  }

}

