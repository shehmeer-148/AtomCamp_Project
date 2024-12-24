import 'package:cleanproject/config/App%20constants/app_colors.dart';
import 'package:cleanproject/presentation/widgets/AppBarAction_Button.dart';
import 'package:cleanproject/presentation/widgets/Appbar_BackButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../config/utils/ScreenSize_class.dart';

class ProductDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Appcolors.primarycolor,
      appBar: AppBar(
        leading: const AppBarBackButton(),
        actions: [
          AppBarActionButton(icons: Icons.shopping_bag_outlined, onpressed: (){})
        ],
        title: const Text(
          "Men's Shoes",
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            color: Appcolors.scaffoldcolor,
            height: ScreenSize.screenHeight * 0.45,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(10),
                color: Appcolors.scaffoldcolor,
                height: ScreenSize.screenHeight * 0.35,
                child: Image.asset(
                  'images/onboardingpics/sneaker1.png', // Replace with your image asset path
                  height: 200,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Flexible(
            child: SizedBox(
              height: ScreenSize.screenHeight*0.52,
              child: Padding(
                padding:  EdgeInsets.only(top: ScreenSize.screenHeight*0.01,bottom: ScreenSize.screenHeight*0,left: ScreenSize.screenWidth*0.04,right: ScreenSize.screenHeight*0.04),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    height: ScreenSize.screenHeight *0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "BEST SELLER",
                          style: TextTheme.of(context).bodyMedium?.copyWith(color: Appcolors.secondarycolor,
                          ),),
                        const SizedBox(height: 8),
                        Text(
                            "Nike Air Jordan",
                            style:TextTheme.of(context).titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(
                            "\$967.800",
                            style: TextTheme.of(context).bodyLarge),
                        const SizedBox(height: 8),
                        const Text(
                          "Air Jordan is an American brand of basketball shoes athletic, "
                              "casual, and style clothing produced by Nike...",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        // Gallery
                         Text(
                          "Gallery",style: TextTheme.of(context).bodyLarge,
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: ScreenSize.screenWidth* 0.15,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              _buildGalleryItem('images/onboardingpics/sneaker1.png'),
                              _buildGalleryItem('images/onboardingpics/sneaker1.png'),
                              _buildGalleryItem('images/onboardingpics/sneaker1.png'),
                              _buildGalleryItem('images/onboardingpics/sneaker1.png'),
                              _buildGalleryItem('images/onboardingpics/sneaker1.png'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Size Selector
                         Text(
                          "Size",
                            style: TextTheme.of(context).bodyLarge,
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              _buildSizeButton(context,"38"),
                              _buildSizeButton(context,"39"),
                              _buildSizeButton(context,"40", isSelected: true),
                              _buildSizeButton(context,"41"),
                              _buildSizeButton(context,"42"),
                              _buildSizeButton(context,"43"),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        // Price and Add to Cart
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               Column(mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Price: ",style: TextTheme.of(context).bodyMedium?.copyWith(color: Appcolors.subtitilecolor),),
                                   Text("\$849.69",style: TextTheme.of(context).bodyLarge,),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text(
                                  "Add To Cart",
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )

        ],
      ),
    );
  }

  Widget _buildGalleryItem(String imagePath) {
    return Container(
      width: ScreenSize.screenWidth* 0.15,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Appcolors.scaffoldcolor,
          borderRadius: BorderRadius.circular(10),

      ),
      child: Center(child: Image.asset(imagePath)), // Replace with your image path
    );
  }

  Widget _buildSizeButton(BuildContext context,String size, {bool isSelected = false}) {
    return Container(

      width: ScreenSize.screenWidth* 0.15,
      margin: const EdgeInsets.only(right: 10),
      decoration:  BoxDecoration(
        color: isSelected ? Appcolors.secondarycolor : Appcolors.scaffoldcolor,
        shape: BoxShape.circle
      ),
      child: Center(child: Text(size,style: TextTheme.of(context).bodyMedium?.copyWith(
        color: isSelected ? Appcolors.primarycolor: Appcolors.subtitilecolor
      ),)),
    );
  }
}
