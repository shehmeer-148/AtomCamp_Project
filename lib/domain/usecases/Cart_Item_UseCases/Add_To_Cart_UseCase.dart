import '../../entites/Cart_shoe_items_Entities.dart';
import '../../repository_interface/cart_item_repository_interface.dart';

class AddToCartUseCase {
  CartItemInterfaceRepository cartItemInterfaceRepository;

  AddToCartUseCase(this.cartItemInterfaceRepository);

  Future<int> executes(CartShoeItemEntities cartItems){
    return cartItemInterfaceRepository.addToCart(cartItems);
  }
}