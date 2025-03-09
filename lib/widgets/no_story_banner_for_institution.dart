import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoStoryBannerForInstitution extends StatelessWidget {
  NoStoryBannerForInstitution({
    super.key,
    required this.child,
    required this.storiesLength,
  });
  Widget child;
  int storiesLength;

  @override
  Widget build(BuildContext context) {
    return Container(
     child:  (storiesLength==0)?
       Center(
         child: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
            SvgPicture.asset(
              'assets/images/no_news.svg', // Az elérési útvonal
            ),
            Text("Üres hírfolyam",  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text("Úgy tűnik, üres a hírfolyamod. Készíts bejegyzéseket és mi eljuttatjuk a követőidnek", textAlign: TextAlign.center,style: TextStyle(color: Colors.grey, fontSize: 16),),
            ),
           ],
         ),
       )
       : child,
    );
  }
}
