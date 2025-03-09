import 'package:eduinfo/screens/dashboard/admin/details/institution_details/institution_details_network.dart';
import 'package:eduinfo/models/institution.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class InstitutionDetailsController extends GetxController {
  Institution institution=Get.arguments["institution"] as Institution;
  String token=Get.arguments["token"] as String;
  bool isLoading=false;

  void acceptRegistration() async {
    try {
      isLoading = true;
      update();
      var response =await InstitutionDetailsNetwork.acceptInstitutiobRegistration(token, institution.id);
      if (response["code"]==200) {
        institution.isAccepted=true;
      }
    } catch (e) {
      print("Hiba történt: $e");
      Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
    } finally {
      isLoading = false;
      update();
    }
  }

  void disableInstitution() async {
    try {
      isLoading = true;
      update();
      var response =await InstitutionDetailsNetwork.disableInstitution(token, institution.id);
      if (response["code"]==200) {
        institution.isEnabled=false;
      }
    } catch (e) {
      print("Hiba történt: $e");
      Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
    } finally {
      isLoading = false;
      update();
    }
  }

  void enableInstitution() async {
    try {
      isLoading = true;
      update();
      var response = await InstitutionDetailsNetwork.enableInstitution(token, institution.id);
      if (response["code"] == 200) {
        institution.isEnabled = true;
      }
    } catch (e) {
      print("Hiba történt: $e");
      Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
    } finally {
      isLoading = false;
      update();
    }
  }

  void sendMail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: institution.email,
      queryParameters: {
        'subject': "EduInfo",
        'body': "Kedves ${institution.name}!",
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