import 'package:eduinfo/screens/dashboard/institution/settings/settings_chooser/settings_chooser_network.dart';
import 'package:eduinfo/models/institution.dart';
import 'package:eduinfo/widgets/confirm_dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsChooserController extends GetxController {
  Institution institution=Get.arguments['institution'] as Institution;
  String token=Get.arguments['token'] as String;
  bool isLoading=false;
  GetStorage storage = GetStorage();

  void navigateToProfileEdit() async{
    await Get.toNamed('/edit_profile', arguments: {"institution":institution, "token":token});
    update();
  }

  void navigateToPublicContacts(){
    Get.toNamed('/institution_contacts_screen', arguments: {"institution":institution, "token":token});
  }

  void navigateToPublicDescription(){
    Get.toNamed('/edit_description', arguments: {"institution":institution, "token":token});
  }

  void navigateToInstitutionCategories(){
    Get.toNamed('/edit_category', arguments: {"institution":institution, "token":token});
  } 

  void navigateToPublicView(){
    Get.toNamed('/public_view', arguments: {"institution":institution, "token":token, "institution_id": institution.id});
  } 
  
  void back(){
    Get.back();
  }

  void deleteProfile(){
    Get.dialog(ConfirmDialog(title: "Fiók törlése", description: "Biztosan törölni szeretné fiókját?", onConfirm: () async{
      try {
        isLoading = true;
        update();
        await SettingsChooserNetwork.deleteProfile(token);
        storage.erase();
        Get.offAllNamed("login");
      } catch (e) {
        print("Hiba történt: $e");
        Get.snackbar("Hiba", "Hálózati hiba történt. Ellenőrízd az internetkapcsolatod.");
      } finally {
        isLoading = false;
        update();
      }
    }),
    barrierDismissible: false);
  }
}