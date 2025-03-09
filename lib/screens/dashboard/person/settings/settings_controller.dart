import 'package:eduinfo/screens/dashboard/person/settings/settings_network.dart';
import 'package:eduinfo/models/person.dart';
import 'package:eduinfo/widgets/button_sheet.dart';
import 'package:eduinfo/widgets/confirm_dialog.dart';
import 'package:eduinfo/widgets/row_text_content.dart';
import 'package:eduinfo/widgets/row_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eduinfo/services/api_service.dart' as apiUrl;

class SettingsController extends GetxController {
  Person person=Get.arguments['person'] as Person;
  String token=Get.arguments['token'] as String;

  bool showNetworkImage=true;
  bool showFileImage=false;

  bool isLoading=false;
  GetStorage storage = GetStorage();
  
  void back(){
    Get.back();
  }

  void navigateToFollowingList()async{
    await Get.toNamed('/following_list', arguments: {"token":token, "person":person});
    update();
  }



  void openEditAvatar() async{
    XFile? image = await  ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      try {
        isLoading=true;
        update();
        var response = await SettingsNetwork.uploadAvatar(token,image.path);
        if (response['code']==200) {
          person.avatarImage= apiUrl.imageUrl+(response['data']['avatar_image'] as String);
          showNetworkImage=true;
          update();
        }  else{
          Get.snackbar("Rendszerüzenet",  response['message']);
        }
      } catch (e) {
        print("Hiba történt: $e");
        Get.snackbar("Rendszerüzenet", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
      } finally {
        isLoading=false;
        update();
      }
    } else {
      print('Nem választottál képet.');
    }
  }

  void openEditName() async {
    TextEditingController nameController = TextEditingController(text: person.name);
    await Get.bottomSheet(
      isScrollControlled: true,
      ButtonSheet(
        disableAutoGetBack: true,
        title: "Név módosítása",
        children: [
          RowTextContent(title: "Teljes név"),
          RowTextField(
            controller: nameController, 
            hintText: "Add meg a teljes neved", 
          ),
        ],
        buttonTitle: "Módosítás",
        onPressed: () async {
          Get.back();
          try {
            isLoading=true;
            update();
            var response = await SettingsNetwork.updateName(token,nameController.text.trim());
            if (response['code']==200) {
              person.name= response['data']['name'] as String;
              Get.snackbar("Rendszerüzenet",  "Sikeres adatmódosítás");
            }  else{
              Get.snackbar("Rendszerüzenet",  response['message']);
            }
          } catch (e) {
            print("Hiba történt: $e");
            Get.snackbar("Rendszerüzenet",  "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
          } finally {
            isLoading=false;
            update();
          }
        },
      ),
    );
  }

  void openEditEmail() async {
    TextEditingController emailController = TextEditingController(text: person.email);
    await Get.bottomSheet(
      isScrollControlled: true,
      ButtonSheet(
        disableAutoGetBack: true,
        title: "E-mail módosítása",
        children: [
          RowTextContent(title: "Regisztrációs e-mail"),
          RowTextField(
            controller: emailController, 
            hintText: "E-mail megadása", 
            textInputType: TextInputType.emailAddress,
          ),
        ],
        buttonTitle: "Módosítás",
        onPressed: () async {
          Get.back();
          try {
            isLoading=true;
            update();
            var response = await SettingsNetwork.updateEmail(token,emailController.text.trim());
            if (response['code']==200) {
              person.email= response['data']['email'] as String;
              Get.snackbar("Rendszerüzenet",  "Sikeres adatmódosítás");
            }  else{
              Get.snackbar("Rendszerüzenet",  response['message']);
            }
          } catch (e) {
            print("Hiba történt: $e");
            Get.snackbar("Rendszerüzenet", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
          } finally {
            isLoading=false;
            update();
          }
        },
      ),
    );
  }

  void openEditPassword() async {
    TextEditingController oldPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmPassowordController = TextEditingController();
    await Get.bottomSheet(
      ButtonSheet(
        disableAutoGetBack: true,
        title: "Jelszó módosítása",
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  RowTextContent(
                    title: "Régi jelszó megadása",
                  ),
                  RowTextField(
                    controller: oldPasswordController, 
                    hintText: "Jelszó megadása",
                    obscureText: true,
                  ),
                  RowTextContent(
                    title: "Új jelszó megadása",
                  ),
                  RowTextField(
                    controller: newPasswordController,
                    hintText: "Jelszó megadása",
                    obscureText: true,
                  ),
                  RowTextContent(
                    title: "Új jelszó megerősítése",
                  ),
                  RowTextField(
                    controller: confirmPassowordController, 
                    hintText: "Jelszó megadása",
                    obscureText: true,
                  ),
                ],
              ),
            )
          )
        ],
        buttonTitle: "Módosítás",
        onPressed: () async {
          Get.back();
          if(newPasswordController.text.trim()==confirmPassowordController.text.trim()){
            try {
              isLoading=true;
              update();
              var response = await SettingsNetwork.updatePassword(token,oldPasswordController.text.trim(), newPasswordController.text.trim());
              
              if(response['code']!=200){
                 Get.snackbar("Rendszerüzenet", response['message']);
              } else{
                Get.snackbar("Rendszerüzenet",  "Sikeres adatmódosítás");
              }
            } catch (e) {
              print("Hiba történt: $e");
              Get.snackbar("Rendszerüzenet",  "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
            } finally {
              isLoading=false;
              update();
            }
          } else {
            Get.snackbar("Rendszerüzenet", "A jelszónak és a jelszó megerősítésének egyeznie kell.");
          }
        },
      ),
    );
  }

  void deleteProfile(){
    Get.dialog(ConfirmDialog(title: "Fiók törlése", description: "Biztosan törölni szeretné fiókját?", onConfirm: () async{
      try {
        isLoading = true;
        update();
        await SettingsNetwork.deleteProfile(token);
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
}