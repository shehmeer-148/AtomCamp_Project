import 'package:cleanproject/domain/entites/Shoedata_Entities.dart';
import 'package:cleanproject/domain/usecases/Get_Shoes_Data_usecase.dart';
import 'package:flutter/material.dart';

class GetShoeDataProvider extends ChangeNotifier{
  final GetShoesDataUseCase _shoesDataUseCase;
  List<ShoeDataEntities>? shoesdata;
  bool isloading = false;

  GetShoeDataProvider(this._shoesDataUseCase);

  List<ShoeDataEntities>? get getshoesdata => shoesdata;

  Future<void> startloading()async{

    isloading = true;
    notifyListeners();
    try{
      shoesdata = await _shoesDataUseCase.executes();
    }catch(e){
      shoesdata=[];
    }
    finally{
      isloading = false;
      notifyListeners();
    }


  }
}