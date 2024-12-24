
import 'package:cleanproject/data_layer/repository/Firebase_Auth_Repository.dart';

class LogoutUseCase{

  final FirebaseAuthRepository _repository;

  LogoutUseCase(this._repository);

  Future<void> call ()async{
    return await _repository.signoutfunction();
  }
}