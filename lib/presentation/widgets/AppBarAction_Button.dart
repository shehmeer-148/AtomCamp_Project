import 'package:flutter/material.dart';

class AppBarActionButton extends StatelessWidget {
  final IconData icons;
  final Color? customcolor;
  final VoidCallback onpressed;
  final EdgeInsets? pad;


  const AppBarActionButton({ required this.icons, required this.onpressed, this.pad, this.customcolor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: pad ?? const EdgeInsets.only(right: 10,bottom: 10,top: 10,),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Center(child: IconButton(onPressed: onpressed, icon: Icon(icons,size: 18,),color: customcolor != null ? customcolor:Colors.black,)),
    );
  }
}



