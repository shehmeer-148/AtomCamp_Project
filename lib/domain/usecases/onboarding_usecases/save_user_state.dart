
import 'package:cleanproject/data_layer/data_source/local_databases/shared_prefferences.dart';

class SaveUserStateUseCase{

  final SharedPrefferenceHelper _helper;

  SaveUserStateUseCase(this._helper);

  Future<void> call(bool value)async{
    await _helper.saveisfirsttime(value);
  }
}