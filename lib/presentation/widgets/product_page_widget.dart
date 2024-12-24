
import 'dart:math';

import 'package:cleanproject/domain/entites/Shoedata_Entities.dart';
import 'package:flutter/material.dart';

import '../../config/App constants/app_colors.dart';
import '../../config/utils/ScreenSize_class.dart';

class ProductPageWidget extends StatelessWidget{

  final List<ShoeDataEntities>? shoedata;
  const ProductPageWidget({super.key,required this.shoedata});

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    Random random1 = Random();
    // Function to generate a random color
    Color getRandomColor(Random random) {
      return Color.fromARGB(
        255,
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
      );
    }

    return Padding(
      padding:  EdgeInsets.only(top: ScreenSize.screenHeight*0.01,bottom: ScreenSize.screenHeight*0,left: ScreenSize.screenWidth*0.04,right: ScreenSize.screenHeight*0.04),
      child: shoedata! != null && shoedata!.isNotEmpty ?
      GridView.builder(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemCount: shoedata?.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 15,
          childAspectRatio: 1/1.4,
        ),
        itemBuilder: (context, index){
          final shoe = shoedata?[index];
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
                  Flexible(
                    child: Center(
                      child: shoe?.image != null && shoe!.image.isNotEmpty
                          ? Image.network(
                        shoe!.image.trim(),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network('https://via.placeholder.com/150');
                        },
                      )
                          : Image.network('https://via.placeholder.com/150'),
                    ),
                  ),

                  const SizedBox(height: 5,),
                  Text("Best Seller",
                      style: TextTheme.of(context).bodyMedium?.copyWith(color: Appcolors.secondarycolor,)
                  ),
                  FittedBox(child:  Text(shoe!.title,
                    style:TextTheme.of(context).titleMedium?.copyWith(fontWeight: FontWeight.normal),),),
                  Row(
                    spacing: 8,
                    children: [
                      Text(shoe.price.toString(),style: TextTheme.of(context).bodyMedium,),
                      const Spacer(flex: 2,),
                      CircleAvatar(
                        radius: 7,
                        backgroundColor: getRandomColor(random),
                      ),
                      CircleAvatar(
                        radius: 7,
                        backgroundColor:getRandomColor(random1),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          );
        },
      ):
      const Center(child: Text("No Data Available"),),
    );
  }
}