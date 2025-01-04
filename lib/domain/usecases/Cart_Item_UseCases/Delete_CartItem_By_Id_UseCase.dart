import '../../repository_interface/cart_item_repository_interface.dart';

class DeleteCartItemByIdUseCase {

  CartItemInterfaceRepository cartItemInterfaceRepository;

  DeleteCartItemByIdUseCase(this.cartItemInterfaceRepository);

  Future<int> executes(int id)async{
    return await cartItemInterfaceRepository.deleteCartItemById(id);
  }
}