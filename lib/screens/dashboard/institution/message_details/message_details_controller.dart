import 'dart:async';

import 'package:eduinfo/models/message.dart';
import 'package:eduinfo/models/person.dart';
import 'package:eduinfo/screens/dashboard/institution/message_details/message_details_network.dart';
import 'package:eduinfo/models/message_details.dart';
import 'package:flutter/material.dart';
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
  void onReady() {
    super.onReady();
    loadMessageVersion();
    loadMessages(true);

    startTimer();
    startTimer2();
    scrollToBottom();
  }

  @override
  void onClose() {
    timer?.cancel(); // Timer leállítása
    super.onClose();
  }

  void back(){
    Get.back();
  }
  
  void loadMessages(bool hasLoadingScreen) async {
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
    timer = Timer.periodic(Duration(milliseconds: 100), (_) {
      isScrollable = scrollController.hasClients && scrollController.position.maxScrollExtent > 0;
      print(isScrollable);
      update();
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

