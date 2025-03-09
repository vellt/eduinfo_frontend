import 'package:cached_network_image/cached_network_image.dart';
import 'package:eduinfo/widgets/nav_bar_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RowNavbarPerson extends StatelessWidget {
  RowNavbarPerson({
    super.key,
    required this.controller,
    required this.imagePressed,
    required this.image,
    required this.haveNotification,
  });
  NavBarController controller;
  Function() imagePressed;
  String image;
  bool haveNotification;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Color.fromARGB(255, 202, 202, 202),
                  width: 0.5)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CupertinoButton(
                  onPressed: () { 
                    controller.changeIndex(0);
                  },
                  child: SvgPicture.asset(
                    'assets/images/home${controller.index==0 ?2:1}.svg', // Az elérési útvonal
                    width: 40,
                    height: 40,
                  ),
                ),
                CupertinoButton(
                  onPressed: () {
                    controller.changeIndex(1);
                  },
                  child: SvgPicture.asset(
                    'assets/images/institutions${controller.index==1 ?2:1}.svg', // Az elérési útvonal
                    width: 35,
                    height: 35,
                  ),
                ),
                CupertinoButton(
                  onPressed: () {
                    controller.changeIndex(2);
                  },
                  child: SvgPicture.asset(
                    'assets/images/message${controller.index==2?(haveNotification)?3:4:(haveNotification)?2:1}.svg', // Az elérési útvonal
                    width: 40,
                    height: 40,
                  ),
                ),
                CupertinoButton(onPressed: imagePressed,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: CachedNetworkImage(
                        imageUrl: image, 
                        width: 35,
                        height: 35,
                        fit: BoxFit.cover,
                        placeholder: (context, url)=>Center(child: SizedBox(width: 25,height: 25,child: CircularProgressIndicator())),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )
                  ),),
              ],
              
            ),
          ));
      }
    );
  }
}