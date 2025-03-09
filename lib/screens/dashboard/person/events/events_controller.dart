import 'package:eduinfo/screens/dashboard/person/events/events_netwok.dart';
import 'package:eduinfo/models/institution.dart';
import 'package:eduinfo/models/institution_event.dart';
import 'package:eduinfo/models/institution_event_with_institution.dart';
import 'package:eduinfo/widgets/row_event.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventsController extends GetxController {
  String token = Get.arguments["token"] as String;
  bool interested = Get.arguments['interested'] as bool;

  bool isLoading = false;
  TextEditingController searchEventController =TextEditingController();
  List<InstitutionEventWithInstitution> eventsData= [];
  List<InstitutionEventWithInstitution> selectedEventsData= [];

  @override
  void onInit()async {
    super.onInit();
    await loadHomeData();
    searchEventController.addListener((){
      selectedEventsData=List.from(eventsData.where((x)=>x.title.toLowerCase().contains(searchEventController.text.toLowerCase())).toList());
      update();
    });
  }

  void back(){
    Get.back();
  }

  Future<void> loadHomeData() async {
    try {
      isLoading = true;
      update();
      var response = await EventsNetwok.getEvents(token, interested);
      if(response['code']==200) {
        eventsData= (response['data'] as List).map((item)=>InstitutionEventWithInstitution.fromJson(item)).toList();
        selectedEventsData=List.from(eventsData);
      }
    } catch (e) {
      print("Hiba történt: $e");
      Get.back();
      Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
    } finally {
      isLoading = false;
      update();
    }
  }

  void navigateToEventDetails(InstitutionEvent event, Institution institution)async{
    await Get.toNamed('/event_details', arguments: {"event":event,"institution":institution, "token":token });
    if(interested && !event.interested){
      eventsData.removeWhere((x)=>x.id==event.id);
      selectedEventsData=List.from(eventsData);
      update();
    }
  }

  List<Widget> events(){
    return selectedEventsData.map((item)=>RowEvent(
      avatarImage: item.institution.avatarImage,
      coverImage: item.bannerImage?? item.institution.bannerImage,
      title: item.title,
      formattedTimeInterval: item.time,
      month: item.month.toUpperCase(),
      day: item.day.toString(),
      onPressed: ()=>navigateToEventDetails(item, item.institution),
    )).toList();
  }

}