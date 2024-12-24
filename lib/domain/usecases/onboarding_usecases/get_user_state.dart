
import '../../../data_layer/data_source/local_databases/shared_prefferences.dart';

class GetUserStateUseCase{

  final SharedPrefferenceHelper _helper;

  GetUserStateUseCase(this._helper);

   Future<bool> call()async{
     return await _helper.getisfirsttime();
   }
}