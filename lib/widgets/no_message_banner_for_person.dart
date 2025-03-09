import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoMessageBannerForPerson extends StatelessWidget {
  NoMessageBannerForPerson({
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
              'assets/images/no_message2.svg', // Az elérési útvonal
            ),
            Text("Nincs elküldött üzeneted",  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text("Ha kérdésed merülne fel valamely intézmény felé, keresd ki, és írd meg az üzeneted. Mi segítünk eljuttatni a leveled.", textAlign: TextAlign.center,style: TextStyle(color: Colors.grey, fontSize: 16),),
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
