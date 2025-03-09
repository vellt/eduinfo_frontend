import 'dart:async';

import 'package:eduinfo/screens/dashboard/person/following_list/following_list_network.dart';
import 'package:eduinfo/models/institution.dart';
import 'package:eduinfo/models/person.dart';
import 'package:eduinfo/widgets/row_image_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowingListController extends GetxController {
  Timer? timer;
   
  String token = Get.arguments["token"] as String;

  TextEditingController searchEventController =TextEditingController();
  bool isLoading = false;

  Person person= Get.arguments["person"] as Person;
  List<Institution> selectedInstitutionsData= [];

  @override
  void onInit()async {
    super.onInit();
    searchEventController.addListener((){
      selectedInstitutionsData=List.from(person.followedInstitutions.where((x)=>x.name.toLowerCase().contains(searchEventController.text.toLowerCase())).toList());
      update();
    });
    getFollowedInstitutions();
    startTimer();
  }

  @override
  void onClose() {
    timer?.cancel(); // Timer leállítása
    super.onClose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 2), (_) async{
      getFollowedInstitutions();
    });
  }

  void back(){
    Get.back();
  }

  void navigateToPublicView(int id)async{
    await Get.toNamed('/public_view', arguments: {"token":token, "institution_id":id});
    getFollowedInstitutions();
  }

  void getFollowedInstitutions() async {
    selectedInstitutionsData=List.from(person.followedInstitutions);
    update();
  }

  List<Widget> institutions(){
    return selectedInstitutionsData.map((item)=>RowImageContent(
      image: item.avatarImage,
      isAccepted: true,
      isDisabled: false,
      text: item.name,
      disableSecondLine: true,
      onPressed: () =>navigateToPublicView(item.id),
    )).toList();
  }
  
  
}