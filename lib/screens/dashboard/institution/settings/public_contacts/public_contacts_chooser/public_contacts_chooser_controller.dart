import 'package:eduinfo/models/institution.dart';
import 'package:get/get.dart';

class PublicContactsChooserController extends GetxController {
  Institution institution=Get.arguments['institution'] as Institution;
  String token=Get.arguments['token'] as String;

  void navigateToEditPhone(){
    Get.toNamed('/edit_phone', arguments: {"institution":institution, "token":token});
  }

  void navigateToEditEmail(){
    Get.toNamed('/edit_email', arguments: {"institution":institution, "token":token});
  }

  void navigateToEditWebsite(){
     Get.toNamed('/edit_website', arguments: {"institution":institution, "token":token});
  }

  void back(){
    Get.back();
  }
}