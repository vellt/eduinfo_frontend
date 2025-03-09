import 'dart:async';

import 'package:eduinfo/screens/dashboard/person/home/home_network.dart';
import 'package:eduinfo/models/institution.dart';
import 'package:eduinfo/models/institution_category.dart';
import 'package:eduinfo/models/institution_event.dart';
import 'package:eduinfo/models/institution_event_with_institution.dart';
import 'package:eduinfo/models/message_room.dart';
import 'package:eduinfo/models/story_with_institution.dart';
import 'package:eduinfo/models/person.dart';
import 'package:eduinfo/widgets/button_sheet.dart';
import 'package:eduinfo/widgets/confirm_dialog.dart';
import 'package:eduinfo/widgets/message_preview.dart';
import 'package:eduinfo/widgets/nav_bar_controller.dart';
import 'package:eduinfo/widgets/row_event.dart';
import 'package:eduinfo/widgets/row_story.dart';
import 'package:eduinfo/widgets/row_svg_button.dart';
import 'package:eduinfo/widgets/row_text_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

class HomeController extends GetxController{
  Timer? timer;

  bool isLoading = false;
  String token = Get.arguments["token"] as String;
  GetStorage storage = GetStorage();
  NavBarController navBarController = Get.put(NavBarController());
  
  List<InstitutionEventWithInstitution> eventsData= [];
  List<StroyWithInstitution> storiesData=[];
  
  TextEditingController messagesSearchController= TextEditingController();
  List<MessagingRoom> messagingRoomData=[];
  List<MessagingRoom> selectedMessagingRoomData=[];

  List<InstitutionCategory> allCategory=[];

  bool hasNotification=false;
  int messageVersion=0;
  int homeVersion=0;

  Person person=Person.none();

  @override
  void onInit()async {
    super.onInit();
    await getHomeData(true);
    getPersonData();
    getCategories();
    getMessagingRooms();

    startTimer();
    messagesSearchController.addListener((){
      selectedMessagingRoomData=List.from(messagingRoomData.where((x)=>x.institution.name.toLowerCase().contains(messagesSearchController.text.toLowerCase())).toList());
      update();
    });
  }

   @override
  void onClose() {
    timer?.cancel(); // Timer leállítása
    super.onClose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 3), (_) async{
      loadMessagesVersion();
      loadHomeVersion();
      loadFollowesVersion();
    });
  }

  void logout() {
    Get.dialog(ConfirmDialog(title: "Kijelentkezés", description: "Biztosan ki szeretne jelentkezni?", onConfirm: () async{
      try {
        isLoading = true;
        update();
        await HomeNetwork.logout(token);
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

  void loadMessagesVersion() async {
    try {
      var response = await HomeNetwork.getMessagesVersion(token);
      switch(response['code']) {
        case 200: 
          int version = response['data']['version']; 
          if(version!=messageVersion){
            messageVersion=version;
            getMessagingRooms();
          }
          break;
        case 405: navigateToNotAcceptedUser(); break;
        case 406: navigateToBannedUser(); break;
      }
    } catch (e) {
      print("Hiba történt: $e");
    }
  }

  void loadHomeVersion() async {
    try {
      var response = await HomeNetwork.getHomeVersion(token);
      if(response['code']==200) {
        int version = response['data']['version']; 
          if(version!=homeVersion){
            homeVersion=version;
            await getHomeData(false);
            print("FRISSÍTÉSSS");
            update();
          }
      }
    } catch (e) {
      print("Hiba történt: $e");
    }
  }

  void loadFollowesVersion()async {
    try {
      var response = await HomeNetwork.getFollowesVersion(token);
      if(response['code']==200) {
        int newVersion = response['data']['version']; 
        print("new: ${newVersion}, old ${person.followedInstitutions.length}");
          if(newVersion!=person.followedInstitutions.length){
            getFollowes();
          }
      }
    } catch (e) {
      print("Hiba történt: $e");
    }
  }

  Future<void> getHomeData(bool hasLoadingScreen) async {
    try {
      if(hasLoadingScreen){
        isLoading = true;
        update();
      }
      
      var response = await HomeNetwork.getHome(token);
      if(response['code']==200) {
        storiesData= (response['data']['stories'] as List).map((item)=>StroyWithInstitution.fromJson(item)).toList();
        eventsData= (response['data']['events'] as List).map((item)=>InstitutionEventWithInstitution.fromJson(item)).toList();
        print("érdeklődök: ${response['data']['events']}");
      }
    } catch (e) {
      print("Hiba történt: $e");
      Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
      homeVersion=0;
    } finally {
      if(hasLoadingScreen){
        isLoading = false;
      }
      update();
    }
  }

  void getMessagingRooms()async {
    try {
      messagingRoomData=[];
      selectedMessagingRoomData=[];
      var response = await HomeNetwork.getMessagingRooms(token);
      print('response: ${response}');
      if (response['code']==200) {
        var data=response['data'];
        for(var messagingRoom in data){
          print(messagingRoom);
          messagingRoomData.add(MessagingRoom.fromJsonOfPerson(messagingRoom));
        }
        selectedMessagingRoomData=List.from(messagingRoomData);
        hasNotification= messagingRoomData.any((x)=>x.dontAnswered);
      }
    } catch (e) {
      print("Hiba történt: $e");
      Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
      messageVersion=0;
    } finally {
      update();
    }
  }

  void getFollowes()async {
    try {
      var response = await HomeNetwork.getFollowes(token);
      print('response: ${response}');
      if (response['code']==200) {
        person.followedInstitutions=(response['data'] as List).map((item)=>Institution.fromJsonOfStories(item)).toList();
      }
    } catch (e) {
      print("Hiba történt: $e");
      Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
    } finally {
      update();
    }
  }

  void like(int storyId)async {
    int likeCount= storiesData.where((x)=>x.id==storyId).first.likes;
    bool liked=storiesData.where((x)=>x.id==storyId).first.liked;
    try {
      if(!liked){
        storiesData.where((x)=>x.id==storyId).first.likes=likeCount+1;
        storiesData.where((x)=>x.id==storyId).first.liked=true;
        update();
      }
      var response = await HomeNetwork.like(token, storyId);
      print('response: ${response}');
      if (response['code']==200) {
        storiesData.where((x)=>x.id==storyId).first.likes=response['data']['like_count'];
      } else{
        resetLikeState(storyId, likeCount, liked);
      }
    } catch (e) {
      print("Hiba történt: $e");
      Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
      resetLikeState(storyId, likeCount, liked);
    } finally {
      update();
    }
  }

  void unLike(int storyId)async {
    int likeCount= storiesData.where((x)=>x.id==storyId).first.likes;
    bool liked=storiesData.where((x)=>x.id==storyId).first.liked;
    try {
      if(liked){
        storiesData.where((x)=>x.id==storyId).first.likes=likeCount-1;
        storiesData.where((x)=>x.id==storyId).first.liked=false;
        update();
      }
      var response = await HomeNetwork.unLike(token, storyId);
      print('response: ${response}');
      if (response['code']==200) {
        storiesData.where((x)=>x.id==storyId).first.likes=response['data']['like_count'];
      } else{
        resetLikeState(storyId, likeCount, liked);
      }
    } catch (e) {
      print("Hiba történt: $e");
      Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
      resetLikeState(storyId, likeCount, liked);
    } finally {
      update();
    }
  }

  void resetLikeState(int storyId, int likeCount, bool liked){
    storiesData.where((x)=>x.id==storyId).first.likes=likeCount;
    storiesData.where((x)=>x.id==storyId).first.liked=liked;
  }

  void getCategories () async {
    try {
      isLoading = true;
      update();
      var response = await HomeNetwork.getCategories();
      if (response['code'] == 200) {
        allCategory = (response['data'] as List).map((category)=>InstitutionCategory.fromJson(category)).toList();
      }
    } catch (e) {
      print("Hiba történt: $e");
      Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
    } finally {
      isLoading = false;
      update();
    }
  }

  void getPersonData() async {
    try {
      isLoading = true;
      update();
      var response = await HomeNetwork.getProfile(token);
      if (response['code'] == 200) {
        person = Person.fromJsonOfProfile(response['data']);
      }
    } catch (e) {
      print("Hiba történt: $e");
      Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
    } finally {
      isLoading = false;
      update();
    }
  }

  void navigateToSettings() async{
    await Get.toNamed('/person_settings', arguments: {"person":person, "token":token});
    update();
  }

  void navigateToEventDetails(InstitutionEvent event, Institution institution){
    Get.toNamed('/event_details', arguments: {"event":event,"institution":institution, "token":token });
  }

  void navigateToMessageDetails(int id) async {
    await Get.toNamed('/person_message_details', arguments: {"institution_id":id,"token":token });
    // frissíteni kell az üneneteimet
    //loadMessagingRooms();
    //update();
  }

  void navigateToAllEvent(bool interested){
    Get.toNamed('/all_events', arguments: {"token":token, "interested":interested});
  }

  void navigateToInstitutionResults(InstitutionCategory category)async{
    await Get.toNamed('/institution_results', arguments: {"token":token, "category":category, "person":person});
    print(person.followedInstitutions.length);
    update();
  }

  void navigateToBannedUser()async{
    await Get.offAllNamed('/banned_user', arguments: {"redirect":"/person_dashboard", "token":token});
  }

  void navigateToNotAcceptedUser()async{
    await Get.offAllNamed('/not_accepted_user', arguments: {"redirect":"/person_dashboard", "token":token});
  }

  List<RowStory> stories() {
    return storiesData.map((item)=> RowStory(
      avatarImage: item.institution.avatarImage,
      formattedDate: item.formattedDate,
      institutionName: item.institution.name,
      likeCount: item.likes,
      textContent: item.description,
      imageContent: item.bannerImage,     
      liked: item.liked,
      onLikePressed: () =>item.liked ? unLike(item.id) : like(item.id),
    )).toList();
  }

  List<Widget> events(){
    return eventsData.map((item)=>SizedBox(
      width: 300,
      child: RowEvent(
        avatarImage: item.institution.avatarImage,
        coverImage: item.bannerImage?? item.institution.bannerImage,
        title: item.title,
        formattedTimeInterval: item.time,
        month: item.month.toUpperCase(),
        day: item.day.toString(),
        onPressed: ()=>navigateToEventDetails(item, item.institution),
        padding: EdgeInsets.only(right: 0,left: 15, top: 15, bottom: 15 ),
      ),
    )).toList();
  }

  List<RowTextContent> categories() {
    return allCategory.map((item)=> RowTextContent(
      title: item.category,
      onPressed: ()=>navigateToInstitutionResults(item),
      outerOnPressed: ()=>navigateToInstitutionResults(item),
    )).toList();
  }

  List<Widget> messagingRooms() {
    return selectedMessagingRoomData.map((data)=>MessagePreview(
        image: data.institution.avatarImage,
        name: data.institution.name,
        message: data.lastMessage,
        dontAnswered: data.dontAnswered,
        formattedDate: data.formattedDate,
        onPressed: () =>navigateToMessageDetails(data.institution.id),
      )).toList();
  }
  
  void openEventsChooser() async {
    await Get.bottomSheet(
      isScrollControlled: true,
      ButtonSheet(
        disableAutoGetBack: true,
        title: "Események",
        children: [
          RowSvgButton(
            text: "Összes esemény", 
            details: "Követett intézmények",
            image: "assets/images/calendar.svg",
            onPressed: (){
              Get.back();
              navigateToAllEvent(false);
            },
          ),
          RowSvgButton(
            text: "Érdeklődött események", 
            details: "Nem csak a követett intézmények",
            image: "assets/images/calendar.svg",
            onPressed: (){
              Get.back();
              navigateToAllEvent(true);
            },
          ),
          SizedBox(height: 50,)
        ],

      ),
    );
  }
  
}