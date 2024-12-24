import 'package:flutter/material.dart';

class AppBarBackButton extends StatelessWidget{

  const AppBarBackButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.arrow_back_ios_new_sharp,size: 18,),
      ),
    );

  }

}