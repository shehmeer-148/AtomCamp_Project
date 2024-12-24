import 'package:cleanproject/config/App%20constants/app_colors.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 5,
        color: Appcolors.primarycolor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              // Product Image
              Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Appcolors.scaffoldcolor,
                ),
                child: const Image(image: AssetImage(
                    "images/onboardingpics/sneaker1.png"),),

              ),
              const SizedBox(width: 16),
              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                     Text("Nike Club Max",style:
                      TextTheme.of(context).displayMedium?.copyWith(color: Appcolors.titlecolor),),
                    const Text("\$64.95"),
                    const SizedBox(height: 20,),
                    Row(
                      spacing: 10,
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          clipBehavior: Clip.antiAlias,
                          padding: const EdgeInsets.only(left: 2,right: 2,),
                          decoration: const BoxDecoration(
                            color: Appcolors.scaffoldcolor,
                            shape: BoxShape.circle,
                          ),
                          child: const Align(alignment:Alignment.topCenter,child: Icon(Icons.minimize_outlined,size: 18,)),
                        ),
                        const Text("1"),
                        Container(
                          clipBehavior: Clip.antiAlias,
                          padding: const EdgeInsets.all(2,),
                          decoration: const BoxDecoration(
                            color: Appcolors.secondarycolor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add_outlined,size: 18,color: Appcolors.primarycolor,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Delete Button
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete_outline, color: Appcolors.subtitilecolor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
