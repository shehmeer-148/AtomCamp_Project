import 'package:flutter/material.dart';

class ScreenSize{

  // static late double _height;
  // static late double _width;
  //
  // double get height => _height;
  // double get width => _width;
  //
  //
  // static void init(BuildContext context) {
  //   _height = MediaQuery.sizeOf(context).height;
  //   _width = MediaQuery.sizeOf(context).width;
  // }

  static late double screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {

    screenWidth = MediaQuery.sizeOf(context).width;
    screenHeight = MediaQuery.sizeOf(context).height;
  }
}