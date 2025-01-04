import 'package:flutter/material.dart';

class DetailPageImageProvider extends ChangeNotifier{
  int index = 0;
  int get currentindex => index;

  void setindex(int number){
    index = number;
    notifyListeners();
  }
}