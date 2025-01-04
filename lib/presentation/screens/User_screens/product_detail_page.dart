import 'package:cleanproject/config/App%20constants/app_colors.dart';
import 'package:cleanproject/config/utils/Scaffold_Messages.dart';
import 'package:cleanproject/domain/entites/Cart_shoe_items_Entities.dart';
import 'package:cleanproject/domain/entites/Shoedata_Entities.dart';
import 'package:cleanproject/presentation/provider/Cart_Item_Provider.dart';
import 'package:cleanproject/presentation/provider/Product_detail_page_image_Provider.dart';
import 'package:cleanproject/presentation/screens/User_screens/mycart_page.dart';
import 'package:cleanproject/presentation/widgets/AppBarAction_Button.dart';
import 'package:cleanproject/presentation/widgets/Appbar_BackButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/utils/ScreenSize_class.dart';

class ProductDetailPage extends StatefulWidget {
  final ShoeDataEntities shoedata;
  const ProductDetailPage({super.key, required this.shoedata});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {


  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to ensure the provider is accessed after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DetailPageImageProvider>(context, listen: false).setindex(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Appcolors.primarycolor,
      appBar: AppBar(
        leading: const AppBarBackButton(),
        actions: [
          AppBarActionButton(icons: Icons.shopping_bag_outlined, onpressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
          })
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
                child: widget.shoedata.image.isNotEmpty ?
                Consumer<DetailPageImageProvider>(
                  builder: (context, value, child){
                    return Image.network(
                      widget.shoedata.images[value.currentindex].trim(),
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress){
                        if(loadingProgress==null) return child;
                        return const Center(child: CircularProgressIndicator(),);

                      },
                      errorBuilder: (context,error, stackTrace){
                        return Image.network('https://via.placeholder.com/150');
                      },
                    );
                  },
                ) :
                Image.network("https://via.placeholder.com/150"),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding:  EdgeInsets.only(top: ScreenSize.screenHeight*0.01,bottom: ScreenSize.screenHeight*0.01,left: ScreenSize.screenWidth*0.04,right: ScreenSize.screenHeight*0.04),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "BEST SELLER",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Appcolors.secondarycolor,
                      ),),
                    const SizedBox(height: 8),
                    Text(
                        widget.shoedata.title.isEmpty ? widget.shoedata.title: "Nike Air Jordan",
                        style:Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(
                        widget.shoedata.price.toString().isNotEmpty ? widget.shoedata.price.toString() : "\$650",
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 8),
                    Text(
                      widget.shoedata.description.isEmpty ? widget.shoedata.description
                          :"Air Jordan is an American brand of basketball shoes athletic, "
                          "casual, and style clothing produced by Nike...",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    // Gallery
                    Text(
                      "Gallery",style: Theme.of(context).textTheme.bodyLarge,),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: ScreenSize.screenWidth* 0.15,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        itemCount: widget.shoedata.images.isNotEmpty ?widget.shoedata.images.length : 0,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index){
                          String imagePath = widget.shoedata.images[index].isNotEmpty
                              ? widget.shoedata.images[index]
                              : "https://via.placeholder.com/150";
                          return InkWell(
                            onTap: (){
                              Provider.of<DetailPageImageProvider>(context,listen: false).setindex(index);
                            },
                            child: _buildGalleryItem(imagePath),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Size Selector
                    Text(
                      "Size",
                      style: Theme.of(context).textTheme.bodyLarge,
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
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Price: ",style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Appcolors.subtitilecolor),),
                              Text(widget.shoedata.price.toString().isNotEmpty ? widget.shoedata.price.toString():"\$630",style: Theme.of(context).textTheme.bodyLarge,),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final cartitems = CartShoeItemEntities(
                                  id: widget.shoedata.id,
                                  name: widget.shoedata.title,
                                  price: widget.shoedata.price,
                                  image: widget.shoedata.image,
                                  quantity: 1,
                              );
                             await Provider.of<CartItemProvider>(context,listen: false).addToCart(cartitems);
                             showMsg();
                            },
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
          )

        ],
      ),
    );
  }

 void showMsg(){
   String msg =  context.read<CartItemProvider>().currentStatus;
   MessageClass(context: context, message:  msg).showMessage();
}

  Widget _buildGalleryItem(String imagePath) {
    return Container(
      width: ScreenSize.screenWidth* 0.15,
      height: ScreenSize.screenWidth* 0.15,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Appcolors.scaffoldcolor,
        borderRadius: BorderRadius.circular(10),

      ),
      child: Center(child: Image.network(
        loadingBuilder: (context, child, loadingprogress){
          if(loadingprogress == null) {
            return child;
          }
          return const Center(child: CircularProgressIndicator(),);

        },
        imagePath.trim(),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.network('https://via.placeholder.com/150');
        },
      )), // Replace with your image path
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
      child: Center(child: Text(size,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: isSelected ? Appcolors.primarycolor: Appcolors.subtitilecolor
      ),)),
    );
  }
}
