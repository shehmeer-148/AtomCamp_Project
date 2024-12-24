
import 'package:cleanproject/data_layer/repository/Firebase_Auth_Repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupUseCase{
  final FirebaseAuthRepository _repository;
  SignupUseCase(this._repository);
  Future<User?> call (String email, String password)async{
    return await _repository.Signupfunction(email, password);
  }
}