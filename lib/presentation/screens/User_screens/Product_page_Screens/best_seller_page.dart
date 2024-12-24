import 'package:cleanproject/presentation/provider/getShoeData_Provider.dart';
import 'package:cleanproject/presentation/widgets/AppBarAction_Button.dart';
import 'package:cleanproject/presentation/widgets/Appbar_BackButton.dart';
import 'package:cleanproject/presentation/widgets/product_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      body: shoeData.isloading ? const Center(child: CircularProgressIndicator(),):
          ProductPageWidget(shoedata: shoeData.shoesdata),
    );
  }
}
