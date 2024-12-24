
import 'package:cleanproject/presentation/screens/User_screens/main_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import '../../../config/App constants/app_colors.dart';
import '../../../config/utils/ScreenSize_class.dart';
import 'SideBar_Menu_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: const MenuScreen(),
      mainScreen: const MainHomePage(),

      borderRadius: 30,
      slideWidth: ScreenSize.screenWidth * 0.7,
      angle: -10,
      menuBackgroundColor: Appcolors.menubackgrouncolor,
      mainScreenScale: 0.3,
      slideHeight: 50,
      openCurve: Curves.linearToEaseOut,
      closeCurve: Curves.linear,
    );
  }
}
