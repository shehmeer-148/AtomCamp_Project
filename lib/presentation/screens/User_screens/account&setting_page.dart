import 'package:cleanproject/presentation/widgets/AppBarAction_Button.dart';
import 'package:cleanproject/presentation/widgets/Appbar_BackButton.dart';
import 'package:flutter/material.dart';

import '../../../config/App constants/app_colors.dart';

class AccountAndSettingPage extends StatefulWidget {
  const AccountAndSettingPage({super.key});

  @override
  State<AccountAndSettingPage> createState() => _AccountAndSettingPageState();
}

class _AccountAndSettingPageState extends State<AccountAndSettingPage> {
  bool isToggled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account & Settings"),
        leading: const AppBarBackButton(),
      ),
     body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 15),
      child: ListView(
        children: [
          Text("Account",style: TextTheme.of(context).bodyLarge,),
          Card(
            color: Colors.white,
            child:  ListTile(
              contentPadding: EdgeInsets.only(right: 5,left: 10),
              trailing: Myicon(onpressed: (){}),
              leading: Icon(Icons.notifications_outlined,color: Appcolors.subtitilecolor),
              title: Text("Notifications Setting",style: TextTheme.of(context).bodyMedium,),
            ),
          ),
          Card(
            color: Colors.white,
            child:  ListTile(
              contentPadding: EdgeInsets.only(right: 5,left: 10),
              trailing: Myicon(onpressed: (){}),
              leading: Icon(Icons.shopping_cart_outlined,color: Appcolors.subtitilecolor),
              title: Text("Shipping Address",style: TextTheme.of(context).bodyMedium,),
            ),
          ),
          Card(
            color: Colors.white,
            child:  ListTile(
              contentPadding: EdgeInsets.only(right: 5,left: 10),
              trailing: Myicon(onpressed: (){}),
              leading: Icon(Icons.wallet_outlined,color: Appcolors.subtitilecolor),
              title: Text("Payment Info",style: TextTheme.of(context).bodyMedium,),
            ),
          ),
          Card(
            color: Colors.white,
            child:  ListTile(
              contentPadding: EdgeInsets.only(right: 5,left: 10),
              trailing: Myicon(onpressed: (){}),
              leading: Icon(Icons.delete_outline,color: Appcolors.subtitilecolor,),
              title: Text("Delete Account",style: TextTheme.of(context).bodyMedium,),
            ),
          ),

          SizedBox(height: 10,),
          Text("Settings",style: TextTheme.of(context).bodyLarge,),
          Card(
            color: Colors.white,
            child:  ListTile(
              contentPadding: EdgeInsets.only(right: 5,left: 20),
              trailing: MyToggleButton(
                isToggled: isToggled,
                onToggle: (newState) {
                  setState(() {
                    isToggled = newState; // Update the state
                  });
                  print('Toggle state: $isToggled');
                },
              ),
              title: Text("Enable FaceId For LogIn",style: TextTheme.of(context).bodyMedium,),
            ),
          ),
          Card(
            color: Colors.white,
            child:  ListTile(
              contentPadding: EdgeInsets.only(right: 5,left: 20),
              trailing: MyToggleButton(
                isToggled: isToggled,
                onToggle: (newState) {
                  setState(() {
                    isToggled = newState; // Update the state
                  });
                  print('Toggle state: $isToggled');
                },
              ),
              title: Text("Enable Push Notification",style: TextTheme.of(context).bodyMedium,),
            ),
          ),
          Card(
            color: Colors.white,
            child:  ListTile(
              contentPadding: EdgeInsets.only(right: 5,left: 20),
              trailing: MyToggleButton(
                isToggled: isToggled,
                onToggle: (newState) {
                  setState(() {
                    isToggled = newState; // Update the state
                  });
                  print('Toggle state: $isToggled');
                },
              ),
              title: Text("Enable Location Service",style: TextTheme.of(context).bodyMedium,),
            ),
          ),
          Card(
            color: Colors.white,
            child:  ListTile(
              contentPadding: EdgeInsets.only(right: 5,left: 20),
              trailing: MyToggleButton(
                isToggled: isToggled,
                onToggle: (newState) {
                  setState(() {
                    isToggled = newState; // Update the state
                  });
                  print('Toggle state: $isToggled');
                },
              ),
              title: Text("Enable Dark Mode",style: TextTheme.of(context).bodyMedium,),
            ),
          ),



        ],
      ),
    ),
    );
  }
  Widget Myicon({required VoidCallback onpressed}){
    return IconButton(onPressed: onpressed, icon: Icon(Icons.arrow_forward_ios_outlined),);
  }
  Widget MyToggleButton({required bool isToggled,required ValueChanged<bool> onToggle,}) {
    return IconButton(
      onPressed: () {
        // Toggle the state
        onToggle(!isToggled);
      },
      icon: Icon(
        isToggled ? Icons.toggle_on : Icons.toggle_off, // Toggle icon
        size: 40, // Icon size
        color: isToggled ? Appcolors.secondarycolor : Appcolors.subtitilecolor, // Icon color
      ),
    );
  }
}


