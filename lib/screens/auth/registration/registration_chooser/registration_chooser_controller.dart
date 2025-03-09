import 'package:get/get.dart';

class RegistrationChooserController extends GetxController {
  void navigateToRegistrationInstitution(){
    Get.toNamed('/institution_registration');
  }

  void navigateToRegistrationPerson(){
    Get.toNamed('/person_registration');
  }

  void back(){
    Get.back();
  }
}
