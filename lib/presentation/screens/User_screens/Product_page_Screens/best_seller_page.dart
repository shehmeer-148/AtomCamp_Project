import 'package:cleanproject/presentation/provider/getShoeData_Provider.dart';
import 'package:cleanproject/presentation/widgets/AppBarAction_Button.dart';
import 'package:cleanproject/presentation/widgets/Appbar_BackButton.dart';
import 'package:cleanproject/presentation/widgets/product_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/App constants/app_colors.dart';
import '../../../../config/utils/ScreenSize_class.dart';

class BestSellerPage extends StatefulWidget {
  const BestSellerPage({super.key});

  @override
  State<BestSellerPage> createState() => _BestSellerPageState();
}

class _BestSellerPageState extends State<BestSellerPage> {
  @override
  Widget build(BuildContext context) {
    final shoeData = Provider.of<GetShoeDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Best Sellers"),
        leading: const AppBarBackButton(),

        actions: [
          AppBarActionButton(icons: Icons.filter_list_rounded, onpressed: (){},pad: const EdgeInsets.only(top: 10,bottom: 10),),
          AppBarActionButton(icons: Icons.search, onpressed: (){},),
        ],
      ),
    
      body: _buildBody(shoeData),
    );
    
}

  Widget _buildBody(GetShoeDataProvider? shoeData) {
    if (shoeData == null) {
      return const Center(child: Text("Data Not Available (Null value is coming)"));
    }
    if (shoeData.isloading) {
      return Padding(
        padding: EdgeInsets.only(
          top: ScreenSize.screenHeight * 0.01,
          bottom: ScreenSize.screenHeight * 0,
          left: ScreenSize.screenWidth * 0.04,
          right: ScreenSize.screenHeight * 0.04,
        ),
        child: GridView.builder(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemCount: 6, // Show placeholders for 6 items during loading
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 15,
            childAspectRatio: 1 / 1.4,
          ),
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: ScreenSize.screenHeight * 0.6,
                decoration: BoxDecoration(
                  color: Appcolors.primarycolor.withOpacity(0.5), // Placeholder color
                  borderRadius: BorderRadius.circular(15),
                ),
                child:const Center(child: CircularProgressIndicator(color: Appcolors.secondarycolor),),
              ),
            );
          },
        ),
      );
    }

    if (shoeData.getshoesdata == null || shoeData.getshoesdata!.isEmpty) {
      return const Center(child: Text("Currently No Product Available"));
    }
    return ProductPageWidget(shoedata: shoeData.getshoesdata!);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetShoeDataProvider>(context, listen: false).startloading();
    });
  }
}
