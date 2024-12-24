import 'package:cleanproject/config/utils/ScreenSize_class.dart';
import 'package:cleanproject/presentation/widgets/Appbar_BackButton.dart';
import 'package:cleanproject/presentation/widgets/Notification_widget.dart';
import 'package:flutter/material.dart';

import '../../../config/App constants/app_colors.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        leading: const AppBarBackButton(),
        actions: [

          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(onPressed: (){}, child: Text("Clear all",style: TextTheme.of(context).bodyMedium?.copyWith(color: Appcolors.secondarycolor),)),
          ),
        ],
      ),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Today",style: TextTheme.of(context).bodyLarge,),
              const SizedBox(height: 10,),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index){
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10,top: 5),
                    child: const NotificationWidget(
                        image: Image(image: AssetImage("images/onboardingpics/sneaker6.png"),fit: BoxFit.contain,),
                        price: 200.2,
                        msg: "We Have New Products With Offers"
                    ),
                  );
                },
              ),
              const SizedBox(height: 10,),
              Text("Yesterday",style: TextTheme.of(context).bodyLarge,),
              const SizedBox(height: 10,),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index){
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10,top: 5),
                    child: const NotificationWidget(
                        image: Image(image: AssetImage("images/onboardingpics/sneaker4.png"),fit: BoxFit.contain,),
                        price: 200.2,
                        msg: "We Have New Products With Offers"
                    ),
                  );
                },
              ),
              const SizedBox(height: 10,),
              Text("Older",style: TextTheme.of(context).bodyLarge,),
              const SizedBox(height: 10,),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index){
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10,top: 5),
                    child: const NotificationWidget(
                        image: Image(image: AssetImage("images/onboardingpics/sneaker5.png"),fit: BoxFit.contain,),
                        price: 200.2,
                        msg: "We Have New Products With Offers"
                    ),
                  );
                },
              ),
            ],

          ),
        ),
      ),
    );
  }
}
