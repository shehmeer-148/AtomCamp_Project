import 'package:cleanproject/presentation/provider/Cart_Item_Provider.dart';
import 'package:cleanproject/presentation/widgets/Appbar_BackButton.dart';
import 'package:cleanproject/presentation/widgets/Custom_Dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/App constants/app_colors.dart';
import '../../widgets/check_out_widget.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key,});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        leading:const AppBarBackButton(),
      ),
      body: Column(
        children: [
          // Cart Items
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:10,vertical: 5),
              child: Card(
                color: Appcolors.primarycolor,
                child: SingleChildScrollView(
                  child: CheckOutWidget(),
                )
              ),
            ),
          ),
          // Footer
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  offset: Offset(0, -1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   const Text("Subtotal"),
                   Text("\$${Provider.of<CartItemProvider>(context).calculateSubtotal}"),
                  ],
                ),
                const SizedBox(height: 8),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   const Text("Shipping"),
                    Text("\$${Provider.of<CartItemProvider>(context).calculateShipping}"),
                  ],
                ),
                const SizedBox(height: 8),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  const  Text(
                      "Total Cost",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "\$${Provider.of<CartItemProvider>(context).calculateTotalCost}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    CustomDialog.show(
                        context: context,
                        title: "Your Payment Is Successful ",
                        buttonText: "Back To Shopping",
                        image: true
                    );
                  },
                  child: const Text(
                    "Payment",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
