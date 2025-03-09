import 'package:eduinfo/widgets/button_sheet.dart';
import 'package:eduinfo/widgets/row_link_text.dart';
import 'package:eduinfo/widgets/row_text_content.dart';
import 'package:eduinfo/widgets/row_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../models/event_link.dart';

class EditEventLinksController extends GetxController {
  List<EventLink> links=Get.arguments['event_links'] as List<EventLink>;
  
  void add()async{
    TextEditingController titleController = TextEditingController();
    TextEditingController urlController = TextEditingController();
    var link= await Get.bottomSheet(
      isScrollControlled: true,
      ButtonSheet(
        disableAutoGetBack: true,
        title: "Link hozzáadása",
        children: [
          RowTextContent(title: "Link neve"),
          RowTextField(
            controller: titleController, 
            hintText: "A link neve", 
          ),
          RowTextContent(title: "Link címe"),
          RowTextField(
            controller: urlController, 
            hintText: "https://", 
          ),
        ],
        buttonTitle: "Rögzítés",
        onPressed: () {
          Get.back(result: EventLink(id: links.length+1, title: titleController.text.trim(), link: urlController.text.trim()));
        },
      ),
    );
    if(link!=null){
      links.add(link as EventLink);
      update();
    }
  }

  void removeLink(title, link){
    links.removeWhere((x)=>x.link==link && x.title==title);
    update();
  }

  void back(){
    Get.back(result: links);
  }

  List<Widget> linksWidgets(){
    return  links.map((event)=>RowLinkText(text: event.title, link: event.link, onDeletePressed: ()=>removeLink(event.title, event.link),)).toList();
  }
}