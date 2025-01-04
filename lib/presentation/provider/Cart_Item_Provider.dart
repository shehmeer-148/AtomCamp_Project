

import 'package:cleanproject/domain/usecases/Cart_Item_UseCases/Update_CartItem_Quantity_UseCase.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/entites/Cart_shoe_items_Entities.dart';
import '../../domain/usecases/Cart_Item_UseCases/Add_To_Cart_UseCase.dart';
import '../../domain/usecases/Cart_Item_UseCases/Delete_All_CartItems_UseCase.dart';
import '../../domain/usecases/Cart_Item_UseCases/Delete_CartItem_By_Id_UseCase.dart';
import '../../domain/usecases/Cart_Item_UseCases/Get_From_Cart_UseCase.dart';

class CartItemProvider extends ChangeNotifier{


  AddToCartUseCase addToCartUseCase;
  GetFromCartUseCase getFromCartUseCase;
  DeleteCartItemByIdUseCase deleteCartItemByIdUseCase;
  DeleteAllCartItemsUseCase deleteAllCartItemsUseCase;
  UpdateCartItemQuantityUseCase updateCartItemQuantityUseCase;
  
  CartItemProvider(this.addToCartUseCase, this.getFromCartUseCase, this.deleteCartItemByIdUseCase, this.deleteAllCartItemsUseCase, this.updateCartItemQuantityUseCase);

  String statusMessage = '';
  String get currentStatus => statusMessage;
  bool isloading = false;

  double get calculateSubtotal{
    return cartItemsList.isNotEmpty ?
    cartItemsList.fold(0.00, (sum, item){ return sum + (item.quantity *item.price);}):
    0.00;
  }
  double get calculateShipping{
    return cartItemsList.isNotEmpty ? 40.34 : 0.00;
  }
  double get calculateTotalCost{
    return calculateSubtotal + calculateShipping;
  }

  List<CartShoeItemEntities> cartitems = [];
  List<CartShoeItemEntities> get cartItemsList => cartitems;


  Future<void> addToCart(CartShoeItemEntities cartItems) async {
    try {
      int result = await addToCartUseCase.executes(cartItems);
      if (result > 0) {
        statusMessage = 'Item added successfully!';
        print('Item added successfully!');
      } else {
        statusMessage = 'Failed to add item. Please try again.';
        print('Failed to add item. Please try again.');
      }
    } catch (e) {
      statusMessage = 'An error occurred: $e';
      print('An error occurred: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> getCartItems()async{
    isloading = true;
    notifyListeners();
    try{
      cartitems = await getFromCartUseCase.executes();
    }catch(e){
      cartitems = [];
    }finally {
      isloading = false;
      notifyListeners();
    }

  }
  
  Future<void> deleteAllCartItems()async{
    int result = await deleteAllCartItemsUseCase.executes();
    if(result > 0){
      print("All Items Deleted");
      cartItemsList.clear();
      notifyListeners();
    }
    else {
      print("An Error Occured");
    }
  }
  
  Future<void> deleteCartItemById(int id,)async{
    int result = await deleteCartItemByIdUseCase.executes(id);
    if(result > 0){
      print("All Items Deleted");
      cartItemsList.removeWhere((item){return item.id == id;});
      notifyListeners();
    }
    else {
      print("An Error Occured");
    }

  }

  Future<void> updateCartItemQuantity(int id, int quantityChange) async {
    // Update the quantity in the database
    int result = await updateCartItemQuantityUseCase.executes(id, quantityChange);

    if (result > 0) {
      print("Quantity updated in the database.");

      // Find the item in the local list
      final index = cartItemsList.indexWhere((item) => item.id == id);

      if (index != -1) {
        // Calculate the new quantity
        final newQuantity = cartItemsList[index].quantity + quantityChange;

        // If the new quantity is less than 1, remove the item from the list
        if (newQuantity < 1) {
          cartItemsList.removeAt(index);
          print("Item removed from the cart as quantity became less than 1.");
        } else {
          // Otherwise, update the quantity in the local list
          cartItemsList[index] = cartItemsList[index].copyWith(quantity: newQuantity);
          print("Item quantity updated locally.");
        }

        notifyListeners(); // Notify the UI to rebuild
      }
    } else {
      print("Error: Failed to update quantity in the database.");
    }
  }


}