import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoEventBannerForInstitution extends StatelessWidget {
  NoEventBannerForInstitution({
    super.key,
    required this.child,
    required this.eventLength,
  });
  Widget child;
  int eventLength;

  @override
  Widget build(BuildContext context) {
    return Container(
     child:  (eventLength==0)?
       Center(
         child: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
            SvgPicture.asset(
              'assets/images/no_event.svg', // Az elérési útvonal
            ),
            Text("Nincs esemény ",  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text("Úgy tűnik, jelenleg nincs eseményed. Igyekezz minél több eseményt megosztani, ahol megjelenik az intézményed", textAlign: TextAlign.center,style: TextStyle(color: Colors.grey, fontSize: 16),),
            ),
           ],
         ),
       )
       : child,
    );
  }
}