import '../../repository_interface/cart_item_repository_interface.dart';

class DeleteAllCartItemsUseCase{
  CartItemInterfaceRepository cartItemInterfaceRepository;


  DeleteAllCartItemsUseCase(this.cartItemInterfaceRepository);

  Future<int> executes()async{
    return cartItemInterfaceRepository.deleteAllCartItems();
  }
}