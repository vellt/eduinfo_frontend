import 'package:eduinfo/screens/dashboard/institution/public_view/public_view_network.dart';
import 'package:eduinfo/models/institution.dart';
import 'package:eduinfo/models/institution_event.dart';
import 'package:eduinfo/widgets/row_event.dart';
import 'package:eduinfo/widgets/row_link_text.dart';
import 'package:eduinfo/widgets/row_story.dart';
import 'package:eduinfo/widgets/row_text_content.dart';
import 'package:eduinfo/widgets/simple_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PublicViewController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  Institution institution=Institution.none();
  int institutionId=Get.arguments['institution_id'] as int;
  String token=Get.arguments['token'] as String;
  String role="";
  bool isLoading=true;
  bool showHeader=true;
  bool animate=true;
  
  @override
  void onInit()async {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    await getRole();
    print(role);
    switch(role){
      case "institution": institution=Get.arguments['institution'] as Institution; break;
      case "person": await loadInstitution();  break;
    }
    isLoading=false;
    update();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void back(){
    Get.back();
  }

  void changeHeaderVisibility()async{
    animate=false;
    update();
    await Future.delayed(Duration(milliseconds: 100)); 
    showHeader=!showHeader;
    animate=true;
    update();
  }

  Future<void> getRole() async {
    try {
      var response = await PublicViewNetwork.getRole(token);
      if (response['code'] == 200) {
        role= response['data']['role'].toString();
      }
    } catch (e) {
      print("Hiba történt: $e");
      Get.back();
      Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
    } 
  }

  Future<void> loadInstitution () async {
    try {
      var response = await PublicViewNetwork.getInstitution(token, institutionId);
      print(response);
      if (response['code'] == 200) {
        institution = Institution.fromJsonForPerson(response['data']);
      }
    } catch (e) {
      print("Hiba történt: $e");
      Get.back();
      Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
    } 
  }



  void like(int storyId)async {
    int likeCount= institution.stories.where((x)=>x.id==storyId).first.likes;
    bool liked=institution.stories.where((x)=>x.id==storyId).first.liked;
    try {
      if(!liked){
        institution.stories.where((x)=>x.id==storyId).first.likes=likeCount+1;
        institution.stories.where((x)=>x.id==storyId).first.liked=true;
        update();
      }
      var response = await PublicViewNetwork.like(token, storyId);
      print('response: ${response}');
      if (response['code']==200) {
        institution.stories.where((x)=>x.id==storyId).first.likes=response['data']['like_count'];
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
    int likeCount= institution.stories.where((x)=>x.id==storyId).first.likes;
    bool liked=institution.stories.where((x)=>x.id==storyId).first.liked;
    try {
      if(liked){
        institution.stories.where((x)=>x.id==storyId).first.likes=likeCount-1;
        institution.stories.where((x)=>x.id==storyId).first.liked=false;
        update();
      }
      var response = await PublicViewNetwork.unLike(token, storyId);
      print('response: ${response}');
      if (response['code']==200) {
        institution.stories.where((x)=>x.id==storyId).first.likes=response['data']['like_count'];
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
    institution.stories.where((x)=>x.id==storyId).first.likes=likeCount;
    institution.stories.where((x)=>x.id==storyId).first.liked=liked;
  }

   void follow()async {
    // lementjük az állapotot
    int followerCount=institution.followers;
    bool followed=institution.followed;
    try {
      // megelőlegezzük a követést
      if(!followed){
        institution.followers=followerCount+1;
        institution.followed=true;
        update();
      }
      var response = await PublicViewNetwork.follow(token, institutionId);
      print('response: ${response}');
      if (response['code']==200) {
        institution.followers=response['data']['follower_count'];
      } else {
        resetFollowState(followerCount, followed);
      }
    } catch (e) {
      print("Hiba történt: $e");
      Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
      resetFollowState(followerCount, followed);
    } finally {
      update();
    }
  }

  void unFollow()async {
    int followerCount=institution.followers;
    bool followed=institution.followed;
    try {
      if(followed){
        institution.followers=followerCount-1;
        institution.followed=false;
        update();
      }
      var response = await PublicViewNetwork.unFollow(token, institutionId);
      print('response: ${response}');
      if (response['code']==200) {
        institution.followers=response['data']['follower_count'];
      } else {
        resetFollowState(followerCount, followed);
      }
    } catch (e) {
      print("Hiba történt: $e");
      Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
      resetFollowState(followerCount, followed);
    } finally {
      update();
    }
  }

  void resetFollowState(int followerCount, bool followed){
    institution.followers=followerCount;
    institution.followed=followed;
  }

  void showWebsites(){
    Get.bottomSheet(
      SimpleSheet(
        title: "Weboldalak",
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: institution.websites.map((website)=>RowLinkText(text: website.title, link: website.website)).toList(),
              ),
            ),
          ),
        ], 
      ),
    );
  }

  void showEmails(){
    Get.bottomSheet(
      SimpleSheet(
        title: "E-mail-címek",
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: institution.emails.map((email)=>RowTextContent(title: email.title,details: email.email, icon: Icon(Icons.mail, color: Color(0xFF17A436)),
                outerOnPressed: () {
                  sendMail(email.email, email.title);
                },)).toList(),
              ),
            ),
          ),
        ], 
      ),
    );
  }

  void showPhones(){
    Get.bottomSheet(
      SimpleSheet(
        title: "Telefonszámok",
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                 children: institution.phones.map((phone)=>RowTextContent(title: phone.title,details: phone.phone, icon: Icon(Icons.phone, color: Color(0xFF17A436)),
                outerOnPressed: () {
                  dialPhoneNumber(phone.phone);
                },)).toList(),
              ),
            ),
          ),
        ], 
      ),
    );
  }

  void sendMail(String mail, String title) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: mail,
      queryParameters: {
        'subject': "EduInfo",
        'body': "Kedves ${title}!",
      },
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        Get.snackbar("Hiba","Nem sikerült megnyitni az e-mail küldő alkalmazást.");
      }
    } catch (e) {
      print("Hiba történt: $e");
    }
  }

  void dialPhoneNumber(String phoneNumber) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        Get.snackbar("Hiba","Nem sikerült megnyitni a tárcsázót.");
      }
    } catch (e) {
      print("Hiba történt a tárcsázó megnyitásakor: $e");
    }
  }

  

  List<Widget> stories() {
    return institution.stories.map((item)=> RowStory(
      avatarImage: institution.avatarImage,
      formattedDate: item.formattedDate,
      institutionName: institution.name,
      likeCount: item.likes,
      textContent: item.description,
      imageContent: item.bannerImage,    
      liked: item.liked,  
      onLikePressed: (role!="person")?null:item.liked ? ()=>unLike(item.id) : ()=>like(item.id),
    )).toList();
  }

  List<Widget> events(){
    institution.events.sort((a, b) => b.id.compareTo(a.id));
    return institution.events.toList().map((item)=>RowEvent(
      avatarImage: institution.avatarImage,
      coverImage: item.bannerImage?? institution.bannerImage,
      title: item.title,
      formattedTimeInterval: item.time,
      month: item.month.toUpperCase(),
      day: item.day.toString(),
      onPressed: ()=>navigateToEventDetails(item),
    )).toList();
  }

  void navigateToEventDetails(InstitutionEvent event){
    if(role=="person"){
      Get.toNamed('/event_details', arguments: {"event":event,"institution":institution, "token":token });
    }else{
      Get.toNamed('/event_details', arguments: {"event":event,"institution":institution });
    }
  }

  void navigateToMessageDetails() async {
    await Get.toNamed('/person_message_details', arguments: {"institution_id":institutionId,"token":token });
  }

}