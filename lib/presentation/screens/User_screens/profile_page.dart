import 'dart:io';

import 'package:cleanproject/config/utils/ScreenSize_class.dart';
import 'package:cleanproject/presentation/widgets/AppBarAction_Button.dart';
import 'package:cleanproject/presentation/widgets/Appbar_BackButton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/App constants/app_colors.dart';
import '../../widgets/custom_text_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _namecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        leading: const AppBarBackButton(),
        actions: [
          AppBarActionButton(icons: Icons.done, onpressed: (){updatefnc(imagepath?.path);},customcolor: Appcolors.secondarycolor,),
        ],
      ),
      body:Padding(
        padding:  EdgeInsets.only(top: ScreenSize.screenHeight*0.05,left: ScreenSize.screenWidth*0.1,right: ScreenSize.screenWidth*0.1,bottom: ScreenSize.screenHeight*0.03),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              Column(
                children: [
                  Center(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(14),
                            child: CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 60,
                            backgroundImage: imagepath != null
                                ? FileImage(imagepath!)
                                : const AssetImage("images/profileimage2.png") as ImageProvider<Object>,
                          ),
                        ),
                        Card(
                          elevation: 5,
                          shape: const CircleBorder(),
                          margin: EdgeInsets.zero,
                          child: Container(
                              height: ScreenSize.screenHeight * 0.035,
                              width: ScreenSize.screenHeight * 0.035,
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Appcolors.secondarycolor,
                              ),

                              child: FittedBox(child: Center(child: InkWell(onTap: pickImage,child: const Icon(Icons.camera_alt_outlined,color: Colors.white,))))),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Center(child: username!=null ? Text(username!):Text("Alison Becker")),
                ],
              ),
              SizedBox(height: 15,),

              Text("Full Name",style: TextTheme.of(context).labelMedium,),
              CustomTextField(
                controller: _namecontroller,
                isobscure: false,
                hinttext: "Alison Baker",
                keyboardtype: TextInputType.name,
                icon: Icons.person,
              ),
              const SizedBox(height: 5,),
              Text("Email Address",style: TextTheme.of(context).labelMedium,),
              const CustomTextField(
                isobscure: false,
                hinttext: "alisonbaker@gmail.com",
                keyboardtype: TextInputType.emailAddress,
                icon: Icons.mail,
              ),
              const SizedBox(height: 5,),
              Text("Password",style: TextTheme.of(context).labelMedium,),
              const CustomTextField(
                isobscure: true,
                // we also use unicode for dots if keyboard dont have the buttons like
                hinttext: "\u2022\u2022\u2022\u2022\u2022\u2022\u2022\u2022",
                //hinttext: "●●●●●●●●",
                keyboardtype: TextInputType.visiblePassword,

                icon: Icons.visibility_off,
              )



            ],
          ),
        ),
      ),
    );
  }
  File? imagepath;
  late String? username;

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  void loadImage() async {
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

  void updatefnc(String? path) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("ImagePath", path ?? "");
    preferences.setString("UserName", _namecontroller.text);
  }

  Future<void> pickImage() async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;

      final imageFile = File(pickedImage.path);
      setState(() {
        imagepath = imageFile;
      });

      updatefnc(imageFile.path);
    } catch (e) {
      print('Permission denied by user $e');
    }
  }
}
