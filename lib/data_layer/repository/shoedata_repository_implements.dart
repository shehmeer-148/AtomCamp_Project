import 'package:cleanproject/data_layer/data_source/Remote_Data_Sources/shoe_class_service.dart';
import 'package:cleanproject/data_layer/model/shoe_data_model.dart';
import 'package:cleanproject/domain/repository_interface/shoedata_repository_interface.dart';

import '../../domain/entites/Shoedata_Entities.dart';

class ShoeDataImplementRepository implements ShoeDataInterfaceRepository{

  final ShoeService _shoeService;
  ShoeDataImplementRepository(this._shoeService);

  @override
  Future<List<ShoeDataEntities>?> getShoeData() async{
    List<ShoeDataModel>? modeldata = await _shoeService.fetchShoeData();
    // Convert model data to entities
    return modeldata?.map((item) => item.toEntities()).toList();
  }
}
