import 'package:eduinfo/screens/dashboard/institution/event/edit_event/edit_event_network.dart';
import 'package:eduinfo/models/institution.dart';
import 'package:eduinfo/models/institution_event.dart';
import 'package:eduinfo/models/event_link.dart';
import 'package:eduinfo/widgets/button_sheet.dart';
import 'package:eduinfo/widgets/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditEventController extends GetxController {
  Institution institution= Get.arguments['institution'] as Institution;
  String token = Get.arguments["token"] as String;
  InstitutionEvent event= Get.arguments['event'] as InstitutionEvent;

  TextEditingController titleController=TextEditingController();
  TextEditingController locationController=TextEditingController();
  DateTime startDateTime= DateTime.now();
  DateTime endDateTime= DateTime.now();
  String eventDescription="";
  List<EventLink> links=[];
  XFile? image;

  bool showFileImage=false;
  bool showNetworkImage=false;

  bool isLoading=false;

  @override
  void onReady()async {
    super.onReady();
    titleController.text=event.title;
    locationController.text=event.location;
    startDateTime=event.start;
    endDateTime=event.end;
    eventDescription=event.description;
    links=List.from(event.links);
    showNetworkImage=true;
    try {
      print(event.bannerImage);
      if(event.bannerImage!=null) {
        image=await EditEventNetwork.downloadImageAndCreateXFile(event.bannerImage!);
        showFileImage=true;
        showNetworkImage=false;
      }
    } catch (e) {
      print('Error downloading image: $e');
    } finally{
      update();
    }

  }

  void updateEvent()async {
    try {
      isLoading=true;
      update();
      var response = await EditEventNetwork.updateEvent(
        id: event.id,
        token: token,
        image: image,
        description: eventDescription,
        eventEnd: endDateTime,
        eventStart: startDateTime,
        links: links,
        location: locationController.text,
        title: titleController.text,
      );
      if (response['code']==200) {
        institution.events=(response['data'] as List).map((x)=>InstitutionEvent.fromJsonOfInstitution(x)).toList();
        print(institution.events);
        Get.back();
      }  
      Get.snackbar("Rendszerüzenet", response['message']);
    } catch (e) {
      print("Hiba történt: $e");
      Get.snackbar("Rendszerüzenet", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
    } finally {
      isLoading=false;
      update();
    }
  } 

  void openEditBanner()async{
    XFile? temp = await  ImagePicker().pickImage(source: ImageSource.gallery);
    if(temp!=null){
      showFileImage=true;
      showNetworkImage=false;
      image=temp;
    }
    update();
  }

  void restoreBanner(){
    image=null;
    showFileImage=false;
    showNetworkImage=true;
    update();
  }

  void back() {
    Get.back(); 
  }

  void openDayChooser()async{
    await Get.bottomSheet(
      ButtonSheet(
        disableAutoGetBack: true,
        title: "Esemény napja",
        children: [
          DateTimePicker(
            initialDateTime: startDateTime,
            height: 200,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (dateTime) => startDateTime=DateTime(dateTime.year, dateTime.month, dateTime.day, startDateTime.hour, startDateTime.minute),
          ),
        ],
        buttonTitle: "Rögzítés",
        onPressed: () {
          Get.back();
          
        },
      ),
    );
    update();
  }

  void openTimeChooser()async{
    await Get.bottomSheet(
      ButtonSheet(
        disableAutoGetBack: true,
        title: "Esemény időtartama",
        children: [
          Row(
            children: [
              Expanded(
                child: DateTimePicker(
                  initialDateTime: startDateTime,
                  height: 200,
                  mode: CupertinoDatePickerMode.time,
                  onDateTimeChanged: (dateTime) => startDateTime=DateTime(startDateTime.year,startDateTime.month,startDateTime.day,dateTime.hour,dateTime.minute),
                ),
              ),
              Expanded(
                child: DateTimePicker(
                  initialDateTime: endDateTime,
                  height: 200,
                  mode: CupertinoDatePickerMode.time,
                  onDateTimeChanged: (dateTime) => endDateTime=DateTime(startDateTime.year,startDateTime.month,startDateTime.day,dateTime.hour,dateTime.minute),
                ),
              ),
            ],
          )
        ],
        buttonTitle: "Rögzítés",
        onPressed: () {
          Get.back();
        },
      ),
    );
    update();
  }

  void openEventDescription() async {
    var result= await Get.toNamed('/edit_event_description', arguments: {"event_description":eventDescription});
    if(result!=null){
      eventDescription=result as String;
    }
  }

  void openEventLinks() async {
    var result= await Get.toNamed('/edit_event_links', arguments: {"event_links":links});
     if(result!=null){
      links=result as List<EventLink>;
    }
  }

  String getFormattedTime(){
    return "${startDateTime.toString().split(':')[0].split(' ')[1]}:${startDateTime.toString().split(':')[1]} - ${endDateTime.toString().split(':')[0].split(' ')[1]}:${endDateTime.toString().split(':')[1]}";
  }

  String getFormattedDate(){
    return "${startDateTime.toString().split(' ')[0].replaceAll('-', '.')}.";
  }

}