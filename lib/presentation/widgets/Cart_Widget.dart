import 'package:cleanproject/config/App%20constants/app_colors.dart';
import 'package:cleanproject/domain/entites/Cart_shoe_items_Entities.dart';
import 'package:cleanproject/presentation/provider/Cart_Item_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {
  final CartShoeItemEntities cartItem;
  const CartItemWidget({super.key, required this.cartItem});

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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                child: Image(image: NetworkImage(cartItem.image),loadingBuilder: (context,child, loadingProgress){
                  if(loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator(),);
                },),

              ),
              const SizedBox(width: 16),
              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                     Text(cartItem.name,style: TextTheme.of(context).displayMedium?.copyWith(color: Appcolors.titlecolor),),
                     Text("\$${cartItem.price}"),
                    const SizedBox(height: 20,),
                    Consumer<CartItemProvider>(
                      builder: (context, provider,child){
                        return  Row(
                          spacing: 10,
                          children: [
                            InkWell(
                              onTap: (){
                                provider.updateCartItemQuantity(cartItem.id, -1);
                              },
                              child: Container(
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
                            ),
                            Text(cartItem.quantity.toString()),
                            InkWell(
                              onTap: (){
                                provider.updateCartItemQuantity(cartItem.id, 1);
                              },
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                padding: const EdgeInsets.all(2,),
                                decoration: const BoxDecoration(
                                  color: Appcolors.secondarycolor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.add_outlined,size: 18,color: Appcolors.primarycolor,),
                              ),
                            )

                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Delete Button
              IconButton(
                onPressed: () {
                  Provider.of<CartItemProvider>(context,listen: false).deleteCartItemById(cartItem.id);
                },
                icon: const Icon(Icons.delete_outline, color: Appcolors.subtitilecolor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
