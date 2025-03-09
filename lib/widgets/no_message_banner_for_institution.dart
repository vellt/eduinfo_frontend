import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoMessageBannerForInstitution extends StatelessWidget {
  NoMessageBannerForInstitution({
    super.key,
    required this.children,
    required this.messageLength,
  });
  List<Widget> children;
  int messageLength;

  @override
  Widget build(BuildContext context) {
    return (messageLength==0)?
    Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/images/no_message.svg', // Az elérési útvonal
            ),
            Text("Nincs üzenet",  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text("Amint érkezik leveled, mi azon leszünk, hogy minél hamarabb eljuttassuk hozzád.", textAlign: TextAlign.center,style: TextStyle(color: Colors.grey, fontSize: 16),),
            ),
          ],
        ),
      ),
    )
    : Expanded(
      child: Column(
        children: children,
      ),
    );
  }
}
