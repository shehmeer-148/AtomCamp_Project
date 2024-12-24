
import 'package:cleanproject/data_layer/repository/Firebase_Auth_Repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginUseCase{

  final FirebaseAuthRepository _repository;

  LoginUseCase(this._repository);

  Future<User?> call (String email, String password)async{
    return await _repository.Loginfunction(email, password);
  }
}