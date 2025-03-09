import 'package:eduinfo/screens/dashboard/institution/story/create_story/create_story_network.dart';
import 'package:eduinfo/models/institution.dart';
import 'package:eduinfo/models/story.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateStoryController extends GetxController {
  Institution institution= Get.arguments['institution'] as Institution;
  String token = Get.arguments["token"] as String;

  TextEditingController textEditingController= TextEditingController();
  XFile? image;
  bool showFileImage=false;

  bool isLoading=false;

  
  void back(){
    Get.back();
  }

  void createStory()async{
    if(textEditingController.text.trim()!="" || image!=null){
      try {
        isLoading=true;
        update();
        var response = await CreateStoryNetwork.createStory(
          token: token,
          image: image,
          description: textEditingController.text.trim(),
        );
        if (response['code']==200) {
          institution.stories=(response['data'] as List).map((x)=>Story.fromJson(x)).toList();
          Get.back();
        }  
      } catch (e) {
        print("Hiba történt: $e");
        Get.snackbar("Rendszerüzenet", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
      } finally {
        isLoading=false;
        update();
      }
    }else{
      Get.snackbar("Rendszerüzenet", "Kötelező szöveges leírást és/vagy képet megadni.");
    }
    
  }

  void removeBanner(){
    image=null;
    showFileImage=false;
    update();
  }

  void openEditBanner()async{
    XFile? temp= await  ImagePicker().pickImage(source: ImageSource.gallery);
    if(temp!=null){
      showFileImage=true;
      image=temp;
    }
    
    update();
  }
}