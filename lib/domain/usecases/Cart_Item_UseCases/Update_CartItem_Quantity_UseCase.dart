import 'package:cleanproject/domain/repository_interface/cart_item_repository_interface.dart';

class UpdateCartItemQuantityUseCase{

  final CartItemInterfaceRepository cartItemInterfaceRepository;
  UpdateCartItemQuantityUseCase(this.cartItemInterfaceRepository);

  Future<int> executes(int id, int quantity)async{
    return await cartItemInterfaceRepository.updateCartItemQuantity(id, quantity);
  }
}