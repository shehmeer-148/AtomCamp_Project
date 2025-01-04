import '../../entites/Cart_shoe_items_Entities.dart';
import '../../repository_interface/cart_item_repository_interface.dart';

class GetFromCartUseCase{
  CartItemInterfaceRepository cartItemInterfaceRepository;
  GetFromCartUseCase(this.cartItemInterfaceRepository);
  Future<List<CartShoeItemEntities>> executes(){
    return cartItemInterfaceRepository.getCartItems();
  }

}