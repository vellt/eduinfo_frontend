import 'package:eduinfo/screens/dashboard/admin/details/person_details/person_details_network.dart';
import 'package:eduinfo/models/person.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonDetailsController extends GetxController {
  Person person=Get.arguments["person"] as Person;
  String token=Get.arguments["token"] as String;
  bool isLoading=false;

  void disablePerson() async {
    try {
      isLoading = true;
      update();
      var response =await PersonDetailsNetwork.disablePerson(token, person.id);
      if (response["code"]==200) {
        person.isEnabled=false;
      }
    } catch (e) {
      print("Hiba történt: $e");
      Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
    } finally {
      isLoading = false;
      update();
    }
    
  }

  void enablePerson() async {
    try {
      isLoading = true;
      update();
      var response =await PersonDetailsNetwork.enablePerson(token, person.id);
      if (response["code"]==200) {
        person.isEnabled=true;
      }
    } catch (e) {
      print("Hiba történt: $e");
      Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
    } finally {
      isLoading = false;
      update();
    }
    
  }
  
  void sendMail()async{
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: person.email,
      queryParameters: {
        'subject': "EduInfo",
        'body': "Kedves ${person.name}!",
      },
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        throw "Nem sikerült megnyitni az e-mail küldő alkalmazást.";
      }
    } catch (e) {
      print("Hiba történt: $e");
    }
  }

  void back(){
    Get.back();
  }
}