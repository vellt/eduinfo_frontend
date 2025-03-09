import 'package:eduinfo/models/institution.dart';
import 'package:eduinfo/models/institution_event.dart';
import 'package:eduinfo/screens/dashboard/institution/event/event_details/event_details_network.dart';
import 'package:eduinfo/widgets/row_link_text.dart';
import 'package:eduinfo/widgets/simple_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventDetailsController extends GetxController {
  InstitutionEvent event= Get.arguments['event'] as InstitutionEvent;
  Institution institution= Get.arguments['institution'] as Institution;
  String token="";

  @override
  void onReady() {
    super.onReady();
    if(Get.arguments['token'] is String){
      token=Get.arguments['token'] as String;

      update();
    }
    
  }

  void back(){
    Get.back();
  }

  bool showFloatingButton(){
    return event.links.length>0;
  }

  void showLinks(){
    Get.bottomSheet(
      SimpleSheet(
        title: "Linkek",
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: event.links.map((event)=>RowLinkText(text: event.title, link: event.link)).toList(),
              ),
            ),
          ),
        ], 
      ),
    );
  }

  void interest() async {
    int interestedCount=event.interestedCount;
    bool interested=event.interested;
    try {
      if(!interested){
        event.interestedCount=interestedCount+1;
        event.interested=true;
        update();
      }

      var response = await EventDetailsNetwork.interest(token, event.id);
      print('response: ${response}');
      if (response['code']==200) {
        event.interestedCount=response['data']['interested_count'];
      } else {
        resetInterestState(interestedCount, interested);
      }
    } catch (e) {
      print("Hiba történt: $e");
      Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
      resetInterestState(interestedCount, interested);
    } finally {
      update();
    }
  }

  void unInterest()async {
    int interestedCount=event.interestedCount;
    bool interested=event.interested;
    try {
      if(interested){
        event.interestedCount=interestedCount-1;
        event.interested=false;
        update();
      }

      var response = await EventDetailsNetwork.unInterest(token, event.id);
      print('response: ${response}');
      if (response['code']==200) {
        event.interestedCount=response['data']['interested_count'];
      } else {
        resetInterestState(interestedCount, interested);
      }
    } catch (e) {
      print("Hiba történt: $e");
      Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
      resetInterestState(interestedCount, interested);
    } finally {
      update();
    }
  }

  void resetInterestState(int interestedCount, bool interested){
    event.interestedCount=interestedCount;
    event.interested=interested;
  }
}

