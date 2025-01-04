import '../entites/Cart_shoe_items_Entities.dart';

abstract class CartItemInterfaceRepository{

  Future<int> addToCart(CartShoeItemEntities cartItems);
  Future<List<CartShoeItemEntities>> getCartItems();
  Future<int> deleteCartItemById(int id);
  Future<int> deleteAllCartItems();
  Future<int> updateCartItemQuantity(int id, int quantity);
}