
import 'package:cleanproject/data_layer/repository/Firebase_Auth_Repository.dart';

class PasswordResetUseCase{

  final FirebaseAuthRepository _repository;

  PasswordResetUseCase(this._repository);

  Future<void> call (String email)async{
    return await _repository.recoverpasswordfunction(email);
  }
}