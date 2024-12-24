import 'dart:io';

import 'package:cleanproject/config/utils/ScreenSize_class.dart';
import 'package:cleanproject/presentation/screens/User_screens/account&setting_page.dart';
import 'package:cleanproject/presentation/screens/User_screens/favourite_page.dart';
import 'package:cleanproject/presentation/screens/User_screens/home_page.dart';
import 'package:cleanproject/presentation/screens/User_screens/mycart_page.dart';
import 'package:cleanproject/presentation/screens/User_screens/notification_page.dart';
import 'package:cleanproject/presentation/screens/User_screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/App constants/app_colors.dart';
import '../../../config/utils/Scaffold_Messages.dart';
import '../../provider/Firebase_Auth_Provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  File? imagepath;
  String? username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light
          ),
        ),
        backgroundColor: Appcolors.menubackgrouncolor,
        body: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [

              Padding(
                padding: const EdgeInsets.only(left: 10,bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    CircleAvatar(
                     // backgroundColor: Appcolors.scaffoldcolor,
                      radius: 35,
                      backgroundImage: imagepath != null
                          ? FileImage(imagepath!)
                          : const AssetImage("images/profileimage2.png") as ImageProvider<Object>,

                     // child: Image(image: AssetImage("images/onboardingpics/sneaker1.png"),fit: BoxFit.contain,),
                    ),
                    const SizedBox(height: 15,),
                    Text("Hey, 👋",style: TextTheme.of(context).displayMedium?.copyWith(color: Appcolors.subtitilecolor),),
                    FittedBox(child: Text(username !=null ? username! : "Alison Baker",style: TextTheme.of(context).displayMedium?.copyWith(fontSize: ScreenSize.screenWidth * 0.06),)),
                    const Divider(),
                  ],
                ),
              ),

              ListTile(
                title:  Text('Profile',style: TextTheme.of(context).displayMedium,),
                leading: const Icon(Icons.person_2_outlined,color: Appcolors.subtitilecolor,),
                onTap: () {
                  ZoomDrawer.of(context)?.close();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
                },
              ),
              ListTile(
                  title:  Text('Home Page',style: TextTheme.of(context).displayMedium,),
                  leading: const Icon(Icons.home_outlined,color: Appcolors.subtitilecolor,),
                  onTap: () {
                    ZoomDrawer.of(context)?.close();
                  }
              ),
              ListTile(
                title: Text('My Cart',style: TextTheme.of(context).displayMedium,),
                leading: const Icon(Icons.shopping_cart_outlined,color: Appcolors.subtitilecolor,),
                onTap: (){
                  ZoomDrawer.of(context)?.close();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));

                },
              ),
              ListTile(
                  title:  Text('Favourite',style: TextTheme.of(context).displayMedium,),
                  leading: const Icon(Icons.favorite_outline,color: Appcolors.subtitilecolor,),
                  onTap: () {
                    ZoomDrawer.of(context)?.close();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FavouritePage()));}
              ),
              ListTile(
                title:  Text('Orders',style: TextTheme.of(context).displayMedium,),
                leading: const Icon(Icons.local_shipping_outlined,color: Appcolors.subtitilecolor,),
                onTap: (){
                  ZoomDrawer.of(context)?.close();
                },
              ),
              ListTile(
                  title:  Text('Notifications',style: TextTheme.of(context).displayMedium,),
                  leading: const Icon(Icons.notifications_outlined,color: Appcolors.subtitilecolor,),
                  onTap: () {
                    ZoomDrawer.of(context)?.close();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationPage()));}
              ),
              ListTile(
                title:  FittedBox(child: Text('Accounts&Setting',style: TextTheme.of(context).displayMedium,)),
                leading: const Icon(Icons.settings_outlined,color: Appcolors.subtitilecolor,),
                onTap: () {
                  ZoomDrawer.of(context)?.close();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountAndSettingPage()));
                },
              ),
              ListTile(
                title:  Text('SignOut',style: TextTheme.of(context).displayMedium,),
                leading: const Icon(Icons.logout,color: Appcolors.subtitilecolor,),
                onTap: () {
                  ZoomDrawer.of(context)?.close();
                  //    FirebaseAuth.instance.signOut();
                },
              ),
            ],
          ),
        )
    );
  }

  @override
  void initState() {
    super.initState();
    loadImage$name();
  }

  void signout() {
    context.read<FirebaseAuthProvider>().signout();
    if(Provider.of<FirebaseAuthProvider>(context,listen: false).issignout){
      MessageClass(context: context,message: "Logout From Devise").showMessage();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    }
    else{
      MessageClass(context: context,message: "Failed! \n Try Again ").showMessage();
    }
  }
  void loadImage$name() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? imagePath = preferences.getString("ImagePath");
    if (imagePath != null) {
      setState(() {
        imagepath = File(imagePath);
      });
    }
    String? name = preferences.getString("UserName");
    if (name != null) {
      setState(() {
        username = name;
      });
    }
  }
}

