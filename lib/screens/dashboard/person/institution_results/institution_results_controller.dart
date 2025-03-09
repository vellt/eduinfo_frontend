import 'package:eduinfo/screens/dashboard/person/institution_results/institution_results_network.dart';
import 'package:eduinfo/models/institution.dart';
import 'package:eduinfo/models/institution_category.dart';
import 'package:eduinfo/models/person.dart';
import 'package:eduinfo/widgets/row_image_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InstitutionResultsController extends GetxController {
  String token = Get.arguments["token"] as String;
  InstitutionCategory category = Get.arguments["category"] as InstitutionCategory;
  Person person= Get.arguments["person"] as Person;

  TextEditingController searchEventController =TextEditingController();
  bool isLoading = false;

  List<Institution> institutionsData= [];
  List<Institution> selectedInstitutionsData= [];

  @override
  void onInit()async {
    super.onInit();
    await loadInstitutionData();
    searchEventController.addListener((){
      selectedInstitutionsData=List.from(institutionsData.where((x)=>x.name.toLowerCase().contains(searchEventController.text.toLowerCase())).toList());
      update();
    });
  }

  void back(){
    Get.back();
  }

  void navigateToPublicView(int id)async{
    await Get.toNamed('/public_view', arguments: {"token":token, "institution_id":id});
  }

  void getPersonData() async {
    try {
      isLoading = true;
      update();
      var response = await InstitutionResultsNetwork.getProfile(token);
      if (response['code'] == 200) {
        Person temp = Person.fromJsonOfProfile(response['data']);
        person.followedInstitutions=temp.followedInstitutions;
        print("firss ${person.followedInstitutions.length}");
      }
    } catch (e) {
      print("Hiba történt: $e");
      Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> loadInstitutionData() async {
    try {
      isLoading = true;
      update();
      var response = await InstitutionResultsNetwork.getInstitutions(token, category.id);
      if(response['code']==200) {
        institutionsData= (response['data'] as List).map((item)=>Institution.fromJsonOfStories(item)).toList();
        selectedInstitutionsData=List.from(institutionsData);
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