
import 'package:flutter/material.dart';

class SignupToogleProvider extends ChangeNotifier{
  bool _obscure = true;

  bool get isobscure => _obscure;

  void toggleobscure(){
    _obscure = !_obscure;
    notifyListeners();
  }

}