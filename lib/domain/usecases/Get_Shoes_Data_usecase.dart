import 'package:cleanproject/data_layer/model/shoe_data_model.dart';
import 'package:cleanproject/domain/entites/Shoedata_Entities.dart';
import 'package:cleanproject/domain/repository_interface/shoedata_repository_interface.dart';

class GetShoesDataUseCase{

  final ShoeDataInterfaceRepository _interfaceRepository;

  GetShoesDataUseCase(this._interfaceRepository);

  Future<List<ShoeDataEntities>?> executes()async {
    return  await _interfaceRepository.getShoeData();
  }
}