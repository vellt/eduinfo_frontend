import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eduinfo/widgets/row_text_content.dart';
import 'package:flutter/material.dart';

class EditBannerImage extends StatelessWidget {
  EditBannerImage({
    super.key,
    required this.title,
    required this.image,
    this.onPressed,
    this.fileImage,
    this.innerOnPressed,
    this.outerOnPressed,
    required this.showNetworkImage,
    required this.showFileImage,
  });

  final String title;
  final String image; // URL kép esetén
  final String? fileImage; // Fájl elérési út helyi kép esetén
  final Function()? onPressed;
  final Function()? innerOnPressed;
  final Function()? outerOnPressed;
  bool showNetworkImage;
  bool showFileImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RowTextContent(
          title: title,
          icon: Icon(Icons.edit, color: Colors.white),
          iconBackground: const Color(0xFF17A436), 
          onPressed: onPressed,
          innerOnPressed: innerOnPressed,
          outerOnPressed: outerOnPressed,
        ),
        (showNetworkImage==false)
            ? Container()
            : Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white, // Keret színe
                  width: 4.0, // Keret vastagsága
                ),
              ),
              child: CachedNetworkImage(
                        imageUrl: image, 
                        width: double.infinity,
                        height: 100,
                        fit: BoxFit.cover,
                        placeholder: (context, url)=>Center(child: SizedBox(width: 25,height: 25,child: CircularProgressIndicator())),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )
            ),
        (showFileImage==false)
            ? Container()
            : Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white, // Keret színe
                  width: 4.0, // Keret vastagsága
                ),
              ),
              child: Image.file(
                  File(fileImage!), // Helyi fájl útját használja
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
            ),
      ],
    );
  }
}
