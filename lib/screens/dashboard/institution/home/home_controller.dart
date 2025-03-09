import 'dart:async';

import 'package:eduinfo/screens/dashboard/institution/home/home_network.dart';
import 'package:eduinfo/models/institution.dart';
import 'package:eduinfo/models/institution_event.dart';
import 'package:eduinfo/models/message_room.dart';
import 'package:eduinfo/models/story.dart';
import 'package:eduinfo/widgets/confirm_dialog.dart';
import 'package:eduinfo/widgets/message_preview.dart';
import 'package:eduinfo/widgets/nav_bar_controller.dart';
import 'package:eduinfo/widgets/row_edit_event.dart';
import 'package:eduinfo/widgets/row_edit_story.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  Timer? timer;

  bool isLoading = false;
  bool isFloatingButton=true;
  String token = Get.arguments["token"] as String;
  GetStorage storage = GetStorage();
  NavBarController navBarController = Get.put(NavBarController());
  late TabController tabController;

  Institution institution= Institution.none();
  TextEditingController messagesSearchController= TextEditingController();
  List<MessagingRoom> messagingRoomData=[];
  List<MessagingRoom> selectedMessagingRoomData=[];

  bool hasNotification=false;
  int messagesVersion=0;

  @override
  void onInit() {
    super.onInit();
    loadMessagesVersion();
    loadProfileData();
    startTimer();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        print("Aktuális tab index: ${tabController.index}");
        update(); // Frissítjük a nézetet
      }
    });
    navBarController.addListener((){
      isFloatingButton=navBarController.index==0;
      update();
    });
    messagesSearchController.addListener((){
      selectedMessagingRoomData=List.from(messagingRoomData.where((x)=>x.person.name.toLowerCase().contains(messagesSearchController.text.toLowerCase())).toList());
      update();
    });
  }

  @override
  void onClose() {
    timer?.cancel(); // Timer leállítása
    super.onClose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 3), (_) {
      loadMessagesVersion();
    });
  }

  void floatingActionButtonClick() {
    switch(tabController.index){
      case 0: navigateToCreateStory(); break;
      case 1: navigateToCreateEvent(); break;
    }
  }

  void logout() {
    Get.dialog(ConfirmDialog(title: "Kijelentkezés", description: "Biztosan ki szeretne jelentkezni?", onConfirm: () async{
      try {
        isLoading = true;
        update();
        await HomeNetwork.logout(token);
        storage.erase();
        navigateToLogin();
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
          if(version!=messagesVersion){
            messagesVersion=version;
            loadMessagingRooms();
          }
          break;
        case 405: navigateToNotAcceptedUser(); break;
        case 406: navigateToBannedUser(); break;
      }
    } catch (e) {
      print("Hiba történt: $e");
    }
  }

  Future<void> loadProfileData() async {
    try {
      isLoading = true;
      update();
      var response = await HomeNetwork.getProfile(token);
      if(response['code']==200) {
        institution = Institution.fromJsonOfInstitution(response['data']);
        print("SIKER");
      }
    } catch (e) {
      print("Hiba történt: $e");
      Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
    } finally {
      isLoading = false;
      update();
    }
  }

  void loadMessagingRooms()async {
    try {
      print("messages loading stared");
      messagingRoomData=[];
      var response = await HomeNetwork.getMessagingRooms(token);
      
      print('response: ${response}');
      if (response['code']==200) {
        var data=response['data'];
        for(var messagingRoom in data){
          messagingRoomData.add(MessagingRoom.fromJsonOfInstitution(messagingRoom));
        }
        selectedMessagingRoomData=List.from(messagingRoomData);
        hasNotification= messagingRoomData.any((x)=>x.dontAnswered);
      }
    } catch (e) {
      print("Hiba történt: $e");
      Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
      messagesVersion=0;
    } finally {
      update();
    }
  }

  void navigateToLogin(){
    Get.offAllNamed("login");
  }

  void navigateToSettings() async{
    await Get.toNamed('/settings', arguments: {"institution":institution, "token":token});
    update();
  }

  void navigateToCreateEvent() async{
    await Get.toNamed('/create_event', arguments: {"institution":institution, "token":token});
    update();
  }

  void navigateToEditEvents(InstitutionEvent event)async {
    await Get.toNamed('/edit_event', arguments: {"event":event,"institution":institution,"token":token });
    update();
  }

  void navigateToEventDetails(InstitutionEvent event){
    Get.toNamed('/event_details', arguments: {"event":event,"institution":institution });
  }

  void navigateToCreateStory()async{
    await Get.toNamed('/create_story', arguments: {"institution":institution, "token":token});
    update();
  }

  
  void navigateToEditStory(Story story)async {
    await Get.toNamed('/edit_story', arguments: {"story":story,"institution":institution,"token":token });
    update();
  }

  void navigateToMessageDetails(int id) async {
    await Get.toNamed('/institution_message_details', arguments: {"message_room_id":id,"token":token });
  }

  void navigateToBannedUser()async{
    await Get.offAllNamed('/banned_user', arguments: {"redirect":"/institution_dashboard", "token":token});
  }

  void navigateToNotAcceptedUser()async{
    await Get.offAllNamed('/not_accepted_user', arguments: {"redirect":"/institution_dashboard", "token":token});
  }

  void deleteStory(int id){
    Get.dialog(ConfirmDialog(title: "Bejegyzés törlése", description: "Biztosan törölni szeretné?", onConfirm: () async {
      try {
        isLoading = true;
        update();
        var response= await HomeNetwork.deleteStory(token, id);
        if (response['code']==200) {
          institution.stories.removeWhere((x)=>x.id==id); /* optimalizált */
        }
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

  void deleteEvents(int id){
    Get.dialog(ConfirmDialog(title: "Esemény törlése", description: "Biztosan törölni szeretné?", onConfirm: () async {
      try {
        isLoading = true;
        update();
        var response= await HomeNetwork.deleteEvents(token, id);
        if (response['code']==200) {
          institution.events.removeWhere((x)=>x.id==id); /* optimalizálva */
        }
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
  
  List<Widget> messagingRooms() {
    return selectedMessagingRoomData.map((data)=>MessagePreview(
        image: data.person.avatarImage,
        name: data.person.name,
        message: data.lastMessage,
        dontAnswered: data.dontAnswered,
        formattedDate: data.formattedDate,
        onPressed: () =>navigateToMessageDetails(data.id),
      )).toList();
  }

  List<Widget> stories() {
    return institution.stories.map((item)=> RowEditStory(
      avatarImage: institution.avatarImage,
      formattedDate: item.formattedDate,
      institutionName: institution.name,
      likeCount: item.likes,
      textContent: item.description,
      imageContent: item.bannerImage,
      onDeletePressed: () =>deleteStory(item.id),
      onEditPressed: () =>navigateToEditStory(item),
    )).toList();
  }

  List<Widget> events(){
    institution.events.sort((a, b) => b.id.compareTo(a.id));
    return institution.events.toList().map((item)=>RowEditEvent(
      avatarImage: institution.avatarImage,
      coverImage: item.bannerImage?? institution.bannerImage,
      title: item.title,
      formattedTimeInterval: item.time,
      month: item.month.toUpperCase(),
      day: item.day.toString(),
      onPressed: ()=>navigateToEventDetails(item),
      onDeletePressed: ()=>deleteEvents(item.id),
      onEditPressed: () =>navigateToEditEvents(item),
    )).toList();
  }

}
