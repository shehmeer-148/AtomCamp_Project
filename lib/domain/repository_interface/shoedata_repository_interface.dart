import 'package:cleanproject/domain/entites/Shoedata_Entities.dart';

abstract class ShoeDataInterfaceRepository{

  Future<List<ShoeDataEntities>?> getShoeData();
}