import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RowCheckBoxController extends GetxController{
    RowCheckBoxController({required this.isChecked});
    bool isChecked;
    void switchTo(bool? value){
      isChecked=value??false;
      update();
    }
}