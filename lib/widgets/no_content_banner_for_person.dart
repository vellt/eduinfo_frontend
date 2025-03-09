import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoContentBannerForPerson extends StatelessWidget {
  NoContentBannerForPerson({
    super.key,
    required this.child,
    required this.contentLength,
    this.showImage=true
  });
  Widget child;
  int contentLength;
  bool showImage;

  @override
  Widget build(BuildContext context) {
    return (contentLength==0)?
    Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(showImage==true) SvgPicture.asset(
            'assets/images/no_content.svg', // Az elérési útvonal
          ),
          if(showImage==false) SizedBox(height: 100,),
          if(showImage==true)Text("Üres hírfolyam ",  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),),
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text("Úgy tűnik üres a hírfolyamod. Nézz vissza később vagy kövess új intézményeket.", textAlign: TextAlign.center,style: TextStyle(color: Colors.grey, fontSize: 16),),
          ),
        ],
      ),
    )
    : child;
    
  }
}
