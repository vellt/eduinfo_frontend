import 'package:eduinfo/screens/dashboard/institution/story/edit_story/edit_story_network.dart';
import 'package:eduinfo/models/institution.dart';
import 'package:eduinfo/models/story.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditStoryController extends GetxController {
  Institution institution= Get.arguments['institution'] as Institution;
  String token = Get.arguments["token"] as String;
  Story story = Get.arguments["story"] as Story;

  TextEditingController textEditingController= TextEditingController();
  XFile? image;
  bool showFileImage=false;

  bool isLoading=false;

  @override
  void onReady()async {
    super.onReady();
    print(Get.arguments);
    textEditingController.text=story.description;
    try {
      if(story.bannerImage!=null) {
        image=await EditStoryNetwork.downloadImageAndCreateXFile(story.bannerImage!);
        if(image!=null){
          showFileImage=true;
        }
      }
    } catch (e) {
      print('Error downloading image: $e');
    } finally{
      update();
    }
    
  }
  
  void back(){
    Get.back();
  }

  void updateStory()async{
    if(textEditingController.text.trim()!="" || image!=null){
      try {
        isLoading=true;
        update();
        var response = await EditStoryNetwork.updateStory(
          token: token,
          image: image,
          description: textEditingController.text.trim(),
          id: story.id
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
    } else{
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