import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class RowLinkText extends StatelessWidget {
  RowLinkText({
    super.key,
    required this.text,
    required this.link,
    this.onDeletePressed,
  });

  String text;
  String link;
  Function()? onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
          onPressed: ()async {
            final Uri url = Uri.parse(link);
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.inAppBrowserView);
              } else {
                Get.snackbar("Hiba", 'Nem sikerült megnyitni: $url');
              }
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(255, 235, 235, 235), width: 0.5)),
            child: Padding(
              padding: EdgeInsets.only(left: 15,right: 5, top: 2, bottom: 2),
              child: ListTile(
    leading: Icon(Icons.language, color: Color(0xFF17A436),),
                title:Text(text,
      style:
          TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Color(0xFF17A436), decoration: TextDecoration.underline,decorationColor: Color(0xFF17A436)),),
              trailing: onDeletePressed==null?null: IconButton(onPressed: onDeletePressed, icon: Icon(Icons.delete, color: Color.fromARGB(255, 214, 214, 214),)),
              ),
            ),
          ),
        );
  }
}