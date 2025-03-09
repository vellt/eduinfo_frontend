import 'dart:async';

import 'package:eduinfo/screens/dashboard/admin/home/home_network.dart';
import 'package:eduinfo/models/institution.dart';
import 'package:eduinfo/models/person.dart';
import 'package:eduinfo/models/user.dart';
import 'package:eduinfo/widgets/confirm_dialog.dart';
import 'package:eduinfo/widgets/row_image_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  TextEditingController searchInstitution = TextEditingController();
  TextEditingController searchPerson = TextEditingController();
  bool isLoading = false;
  List<Widget> institutionList = [];
  List<Widget> selectedInstitutionList=[];
  List<Widget> personList = [];
  List<Widget> selectedPersonList=[];
  String token = Get.arguments["token"] as String;
  GetStorage storage = GetStorage();
  int usersVersion=0;
  Timer? timer;

  @override
  void onInit()async {
    super.onInit();
    
    searchInstitution.addListener((){
      selectedInstitutionList=List.from(institutionList.where((x)=>(x as RowImageContent).text.toLowerCase().contains(searchInstitution.text.toLowerCase())).toList());
      update();
    });

    searchPerson.addListener((){
      selectedPersonList=List.from(personList.where((x)=>(x as RowImageContent).text.toLowerCase().contains(searchPerson.text.toLowerCase())).toList());
      update();
    });

    await loadHomeData(true);
    startTimer();
  }

  @override
  void onClose() {
    timer?.cancel(); // Timer leállítása
    super.onClose();
  }

  void startTimer() {
     timer = Timer.periodic(Duration(seconds: 5), (_) async{
      int newVersion=await loadUsersVersion();
      if(usersVersion != newVersion){
        await loadHomeData(false);
        update();
      }
    });
  }

  RowImageContent CreateRowImageContent(User institution, Function() onPressed) {
    return RowImageContent(
      image: institution.avatarImage,
      isAccepted: institution.isAccepted,
      isDisabled: !institution.isEnabled,
      text: institution.name,
      onPressed: onPressed,
    );
  }

  void navigateToLogin(){
    Get.offAllNamed("login");
  }

  void navigateToInstitutionDetails(Institution institution){
    Get.toNamed('/admin_institution_details', arguments: {"institution": institution, "token": token});
  }

  void navigateToPersonDetails(Person person) {
    Get.toNamed('/admin_person_details', arguments: {"person": person, "token": token});
  }

  void logout() {
    Get.dialog(
      ConfirmDialog(title: "Kijelentkezés", description: "Biztosan ki szeretne jelentkezni?", onConfirm: () async{
          try {
            isLoading = true;
            update();
            await HomeNetwork.logout(token);
            storage.erase();
            navigateToLogin();
          } catch (e) {
            print("Hiba történt: $e");
            Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
          }
          finally{
            isLoading = false;
            update();
          }
        },
      ),
      barrierDismissible: false, 
    );
  }

  Future<void> loadHomeData(bool hasLoadingScreen) async {
    try {
      institutionList = [];
      personList = [];
      if(hasLoadingScreen){
        isLoading = true;
        update();
      }
      var response = await HomeNetwork.getUsers(token);
      
      if(response['code']== 200) {
          usersVersion=response['data']['version'];

          for (var institutionJSON in response['data']['institution_profiles'] as List) {
            var institution = Institution.fromJsonForAdmin(institutionJSON);
            institutionList.add(CreateRowImageContent(institution, () {
              navigateToInstitutionDetails(institution);
            }));
          }

          for (var personJSON in response['data']['person_profiles'] as List) {
            var person = Person.fromJsonForAdmin(personJSON);
            personList.add(CreateRowImageContent(person, () {
              navigateToPersonDetails(person);
            }));
          }
          selectedPersonList=List.from(personList);
          selectedInstitutionList=List.from(institutionList);
      }
    } catch (e) {
      print("Hiba történt: $e");
        Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
    }
    finally{
      if(hasLoadingScreen){
        isLoading = false;
        update();
      }
    }
  }
  
  Future<int> loadUsersVersion() async{
    try {
      var response = await HomeNetwork.getUsersVersion(token);
      if(response['code']==200) {
        return response['data']['version']; 
      }
    } catch (e) {
      print("Hiba történt: $e");
    } 
    return usersVersion;
  }
}
