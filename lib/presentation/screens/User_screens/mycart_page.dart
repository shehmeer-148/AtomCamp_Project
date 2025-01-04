import 'package:cleanproject/presentation/provider/Cart_Item_Provider.dart';
import 'package:cleanproject/presentation/widgets/AppBarAction_Button.dart';
import 'package:cleanproject/presentation/widgets/Appbar_BackButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/App constants/app_colors.dart';
import '../../widgets/Cart_Widget.dart';
import 'check_out_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CartItemProvider>(context, listen: false).getCartItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        leading: const AppBarBackButton(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
                onPressed: () {
                  final provider =
                      Provider.of<CartItemProvider>(context, listen: false);
                  provider.deleteAllCartItems();
                },
                child: Text(
                  "Clear all",
                  style: TextTheme.of(context)
                      .bodyMedium
                      ?.copyWith(color: Appcolors.secondarycolor),
                )),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<CartItemProvider>(
              builder: (context, provider, child) {
                if (provider.isloading) {
                  // Show loading indicator while data is being fetched
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (provider.cartItemsList.isEmpty) {
                  // Show message when there are no items in the cart
                  return const Center(
                    child: Text(
                      'Your cart is empty!',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }
                // Display cart items
                return ListView.builder(
                  itemCount: provider.cartItemsList.length,
                  itemBuilder: (context, index) {
                    return CartItemWidget(
                      cartItem: provider.cartItemsList[index],
                    );
                  },
                );
              },
            ),
          ),

          // Footer
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
                    Consumer<CartItemProvider>(
                      builder: (context, provider, child) {
                        return Text("\$${provider.calculateSubtotal.toStringAsFixed(2)}");
                      },
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Shipping"),
                    Consumer<CartItemProvider>(
                      builder: (context, provider, child) {
                        return Text("\$${provider.calculateShipping.toStringAsFixed(2)}");
                      },
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Cost",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Consumer<CartItemProvider>(
                      builder: (context, provider, child) {
                        return Text(
                          "\$${provider.calculateTotalCost.toStringAsFixed(2)}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        );
                      },
                    )
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckOutPage()));
                  },
                  child: const Text(
                    "Checkout",
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
