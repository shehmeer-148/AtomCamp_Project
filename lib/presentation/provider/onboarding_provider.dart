import 'package:flutter/material.dart';

class onboardingprovider extends ChangeNotifier{
  bool lastpage = false;
  bool get islastpage => lastpage;


  void setlastpage(bool value){
    lastpage = value;
    notifyListeners();
  }
}