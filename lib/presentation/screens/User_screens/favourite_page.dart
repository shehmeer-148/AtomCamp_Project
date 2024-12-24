import 'dart:math';

import 'package:cleanproject/presentation/widgets/AppBarAction_Button.dart';
import 'package:cleanproject/presentation/widgets/Appbar_BackButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../config/App constants/app_colors.dart';
import '../../../config/utils/ScreenSize_class.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {

Random random = Random();
Random random1 = Random();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourite"),
        leading: const AppBarBackButton(),
        actions: [
          AppBarActionButton(icons: Icons.favorite_border, onpressed: (){}),
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.only(top: ScreenSize.screenHeight*0.01,bottom: ScreenSize.screenHeight*0,left: ScreenSize.screenWidth*0.04,right: ScreenSize.screenHeight*0.04),
        child: GridView.builder(
          scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemCount: 10,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 15,
                childAspectRatio: 1/1.4,
            ),
            itemBuilder: (context, index){
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                elevation: 5,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  height: ScreenSize.screenHeight * 0.6,
                  decoration: BoxDecoration(
                    color: Appcolors.primarycolor,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: ScreenSize.screenHeight * 0.03,
                        width: ScreenSize.screenHeight * 0.03,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Appcolors.scaffoldcolor,
                        ),
                        child: const Icon(Icons.favorite_outline,size: 15,color: Colors.red,),
                      ),
                      const Flexible(child: Center(child: Image(image: AssetImage("images/onboardingpics/sneaker1.png"),)),),
                      SizedBox(height: 5,),
                       Text("Best Seller",
                         style: TextTheme.of(context).bodyMedium?.copyWith(color: Appcolors.secondarycolor,)
                         ),
                      FittedBox(child:  Text("Nike Air Jordan",
                          style:TextTheme.of(context).titleMedium?.copyWith(fontWeight: FontWeight.normal),),),
                      Row(
                        spacing: 8,
                        children: [
                          Text("\$380",style: TextTheme.of(context).bodyMedium,),
                          const Spacer(flex: 2,),
                          CircleAvatar(
                            radius: 7,
                            backgroundColor: getRandomColor(random1),
                          ),
                          CircleAvatar(
                            radius: 7,
                            backgroundColor:getRandomColor(random),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              );
            },
        ),
      ),
    );
  }
  // Function to generate a random color
  Color getRandomColor(Random random) {
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

}
