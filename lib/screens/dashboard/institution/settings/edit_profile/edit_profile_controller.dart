import 'package:eduinfo/screens/dashboard/institution/settings/edit_profile/edit_profile_network.dart';
import 'package:eduinfo/models/institution.dart';
import 'package:eduinfo/widgets/button_sheet.dart';
import 'package:eduinfo/widgets/row_text_content.dart';
import 'package:eduinfo/widgets/row_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eduinfo/services/api_service.dart' as apiUrl;

class EditProfileController extends GetxController {
  Institution institution= Get.arguments['institution'] as Institution;
  String token = Get.arguments["token"] as String;

  bool showNetworkImage=true;
  bool showFileImage=false;

  bool isLoading=false;

  void back(){
    Get.back();
  }

  void openEditBanner() async{
    XFile? image = await  ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      try {
        isLoading=true;
        update();
        var response = await EditProfileNetwork.uploadBanner(token,image.path);
        if (response['code']==200) {
          institution.bannerImage= apiUrl.imageUrl+(response['data']['banner_image'] as String);
          showNetworkImage=true;
        } else{
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

  void openEditAvatar() async{
    XFile? image = await  ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      try {
        isLoading=true;
        update();
        var response = await EditProfileNetwork.uploadAvatar(token,image.path);
        if (response['code']==200) {
          institution.avatarImage= apiUrl.imageUrl+(response['data']['avatar_image'] as String);
          showNetworkImage=true;
          update();
        } else{
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
    TextEditingController nameController = TextEditingController(text: institution.name);
    await Get.bottomSheet(
      isScrollControlled: true,
      ButtonSheet(
        disableAutoGetBack: true,
        title: "Név módosítása",
        children: [
          RowTextContent(title: "Intézmény neve"),
          RowTextField(
            controller: nameController, 
            hintText: "Az intézmény neve", 
          ),
        ],
        buttonTitle: "Módosítás",
        onPressed: () async {
          Get.back();
          try {
            isLoading=true;
            update();
            var response = await EditProfileNetwork.updateName(token,nameController.text.trim());
            if (response['code']==200) {
              institution.name= response['data']['name'] as String;
            } else{
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

  void openEditEmail() async {
    TextEditingController emailController = TextEditingController(text: institution.email);
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
            var response = await EditProfileNetwork.updateEmail(token,emailController.text.trim());
            if (response['code']==200) {
              institution.email= response['data']['email'] as String;
            } else{
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
              physics: BouncingScrollPhysics(),
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
              var response = await EditProfileNetwork.updatePassword(token,oldPasswordController.text.trim(), newPasswordController.text.trim());
              if(response['code']!=200){
                Get.snackbar("Rendszerüzenet", response['message']);
              } else{
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
            Get.snackbar("Rendszerüzenet","A jelszónak és a jelszó megerősítésének egyeznie kell.");
          }
        },
      ),
    );
  }
}



