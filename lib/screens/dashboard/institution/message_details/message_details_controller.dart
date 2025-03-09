import 'dart:async';

import 'package:eduinfo/models/message.dart';
import 'package:eduinfo/models/person.dart';
import 'package:eduinfo/screens/dashboard/institution/message_details/message_details_network.dart';
import 'package:eduinfo/models/message_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class MessageDetailsController extends GetxController {
  Timer? timer;
  Timer? timer2;
  bool isScrollable=true;

  String token = Get.arguments["token"] as String;
  int messageRoomId = Get.arguments["message_room_id"] as int;

  bool isLoading=false;
  MessageDetails messageDetails=MessageDetails.none();

  TextEditingController messageController=TextEditingController();
  ScrollController scrollController = ScrollController();

  int messageVersion=0;

  @override
  void onReady() async {
    super.onReady();
    isLoading = true;
    update();

    loadMessageVersion();
    await loadMessages(false);

    /// Scroll a lista aljára az első betöltésnél
    SchedulerBinding.instance.addPostFrameCallback((_) {
      scrollToBottom();
    });

    startTimer();
    startTimer2(); // Indítjuk az állapotfigyelőt is

    isLoading = false;
    update();

    // Figyeljük a scroll állapotát, ha a user görget
    scrollController.addListener(() {
      bool newScrollable = scrollController.position.maxScrollExtent > 0;
      if (newScrollable != isScrollable) {
        isScrollable = newScrollable;
        update();
      }
    });
  }

  @override
  void onClose() {
    timer?.cancel(); // Timer leállítása
    super.onClose();
  }

  void back(){
    Get.back();
  }
  
  Future<void> loadMessages(bool hasLoadingScreen) async {
    try {
      if (hasLoadingScreen) isLoading = true;
      update();
      var response = await MessageDetailsNetwork.getMessagingRooms(messageRoomId, token);
      if (response['code']==200) {
          var data = response['data'];
          messageDetails=MessageDetails.fromJsonOfInstitution(data);
          messageVersion=messageDetails.messages.length;
      }
    } catch (e) {
      print("Hiba történt: $e");
      if(hasLoadingScreen) Get.back();
      Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
    } finally {
      if (hasLoadingScreen){
        isLoading = false;
      } 
      update();
    }
  }

  void sendMessages()async {
    String message=messageController.text.trim();
    if(message!="") {
      Message m= Message(id: -1, message: message, formattedDate: "(küldés)", isMine: true);
      messageDetails.messages.insert(0,m);
      scrollToBottom();
      update();
      try {
        messageController.clear();
        var response= await MessageDetailsNetwork.sendMessage(messageDetails.person.id,message,token);
        if(response['code']!=200){
          messageDetails.messages.removeWhere((x)=>x.id==-1);
        }
      } catch (e) {
        print("Hiba történt: $e");
        Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
        messageController.text=message;
        messageDetails.messages.removeWhere((x)=>x.id==-1);
      } finally {
        update();
      }
    }
    
  }

  void scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.jumpTo(0);
      }
    });
  }
  
  void startTimer(){
    timer = Timer.periodic(Duration(seconds: 3), (_) {
      loadMessageVersion();
    });
  }

   void startTimer2() {
    timer2 = Timer.periodic(Duration(milliseconds: 2), (_) {
      if (scrollController.hasClients) {
        bool newScrollable = scrollController.position.maxScrollExtent > 0;
        if (newScrollable != isScrollable) {
          isScrollable = newScrollable;
          update();
        }
      }
    });
  }
  
  void loadMessageVersion() async{
     try {
      var response = await MessageDetailsNetwork.getMessagesVersionById(token,messageRoomId);
      if(response['code']==200) {
        int version = response['data']['version']; 
        if(version!=messageVersion){
          messageVersion=version;
          loadMessages(false);
          scrollToBottom();
        }
      }
    } catch (e) {
      print("Hiba történt: $e");
    }    
  }
}

