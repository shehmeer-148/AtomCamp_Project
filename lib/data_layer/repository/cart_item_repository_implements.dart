import 'package:cleanproject/data_layer/data_source/local_databases/sqflite_database.dart';
import 'package:cleanproject/data_layer/model/cart_shoe_item_model.dart';
import 'package:cleanproject/domain/repository_interface/cart_item_repository_interface.dart';

import '../../domain/entites/Cart_shoe_items_Entities.dart';

class CartItemImplementRepository implements CartItemInterfaceRepository{
  CartDatabaseHelper cartDatabaseHelper;
  CartItemImplementRepository(this.cartDatabaseHelper);

  @override
  Future<int> addToCart(CartShoeItemEntities cartItems) async {
    final items = CartShoeItemModel(
        id: cartItems.id,
        name: cartItems.name,
        price: cartItems.price,
        image: cartItems.image,
        quantity: cartItems.quantity,
    );
   return await cartDatabaseHelper.addCartItem(items);
  }

  @override
  Future<List<CartShoeItemEntities>> getCartItems() async{
    final modeldata = await cartDatabaseHelper.getCartItems();
    return modeldata.map((item)=>item.toEntities()).toList();
  }

  @override
  Future<int> deleteAllCartItems()async {
    return await cartDatabaseHelper.deleteCartItems();
  }

  @override
  Future<int> deleteCartItemById(int id)async {
    return await cartDatabaseHelper.deleteCartItemsByID(id);
  }

  @override
  Future<int> updateCartItemQuantity(int id, int quantity)async {
    return await cartDatabaseHelper.updateCartItemQuantityById(id, quantity);
  }



}