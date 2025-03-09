import 'package:eduinfo/screens/dashboard/institution/settings/edit_category/edit_category_network.dart';
import 'package:eduinfo/models/institution.dart';
import 'package:eduinfo/models/institution_category.dart';
import 'package:eduinfo/widgets/row_check_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditCategoryController extends GetxController {
  Institution institution=Get.arguments['institution'] as Institution;
  String token=Get.arguments['token'] as String;

  TextEditingController textEditingController= TextEditingController();
  List<InstitutionCategory> allCategory=[];
  bool isLoading=false;
  List<RowCheckBox> categories=[];

  @override
  void onReady(){
    super.onReady();
    getCategories();
  }

  void getCategories () async {
    try {
      isLoading = true;
      update();
      var response = await EditCategoryNetwork.getCategories();
      if (response['code'] == 200) {
        allCategory = (response['data'] as List).map((category)=>InstitutionCategory.fromJson(category)).toList();
        allCategory.forEach((category){
          bool isChecked=institution.InstitutionCategories.any((x)=>x.category==category.category);
          categories.add( RowCheckBox(isChecked: isChecked, title: category.category));
        });
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

  void saveSetup() async {
    var selectedCategories= categories.where((x)=>x.isChecked).map((x)=>allCategory.firstWhere((y)=>y.category==x.title));
    try {
      isLoading = true;
      update();
      var response = await EditCategoryNetwork.updateCategories(token,selectedCategories.map((category) => category.toJson()).toList());
      if (response['code'] == 200) {
        institution.InstitutionCategories = (response['data'] as List).map((category)=>InstitutionCategory.fromJson(category)).toList();
      }
    } catch (e) {
      print("Hiba történt: $e");
      Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
    } finally {
      isLoading = false;
      update();
      Get.back();
    }
  }
  
  void back(){
    Get.back();
  }
}