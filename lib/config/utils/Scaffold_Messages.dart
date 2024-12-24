import 'package:flutter/material.dart';

class MessageClass {
  final BuildContext context;
  final String message;

  MessageClass({required this.context, required this.message});

   void showMessage(){
    ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(
       duration: Duration(seconds: 2),
        elevation: 10,
        behavior: SnackBarBehavior.floating, // Makes the SnackBar float,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)), // Makes the borders rounded
        ),
        content: Center(
          child: Text(
            message,
            textAlign: TextAlign.left,

          ),
        ),

      )
    );
  }
}