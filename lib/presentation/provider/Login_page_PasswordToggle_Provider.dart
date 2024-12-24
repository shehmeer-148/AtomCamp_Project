import 'package:flutter/material.dart';

class LoginToggleProvider extends ChangeNotifier{
  bool obscure = true;
  bool get isobscure => obscure;

  void toggleobscure(){
    obscure = !obscure;
    notifyListeners();
  }

}