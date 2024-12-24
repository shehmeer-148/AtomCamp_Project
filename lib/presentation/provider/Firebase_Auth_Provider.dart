import 'package:cleanproject/domain/usecases/Firebase_Auth_usecase/password_reset_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/Firebase_Auth_usecase/login_usecase.dart';
import '../../domain/usecases/Firebase_Auth_usecase/logout_usecase.dart';
import '../../domain/usecases/Firebase_Auth_usecase/signup_usecase.dart';

class FirebaseAuthProvider extends ChangeNotifier {
  final SignupUseCase _signUpUseCase;
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final PasswordResetUseCase _passwordResetUseCase;

  User? _user;
  User? get user => _user;
  bool issignup = false;
  bool islogin = false;
  bool issignout = false;
  bool isemailsent = false;

  FirebaseAuthProvider(this._signUpUseCase, this._loginUseCase, this._logoutUseCase, this._passwordResetUseCase);

  Future<void> signUp(String email, String password) async {
    try {
     final result = await _signUpUseCase(email,password);
     if(result!= null){
       issignup  = true;
     }
     else{
       issignup = false;
     }
     _user = result;
      notifyListeners();
    } catch (e) {
      throw Exception("Sign-up failed: $e");
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final result = await _loginUseCase(email, password);
      if (result!=null){
        islogin = true;
      }
      else{
        islogin = false;
      }
      notifyListeners();
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  Future<void> passwordrecover(String email) async {
    try {
      await _passwordResetUseCase(email);
      isemailsent = true;
      notifyListeners();
    } catch (e) {
      isemailsent = false;
      throw Exception("Login failed: $e");
    }
  }

  Future<void> signout() async {
    await _logoutUseCase.call();
    _user = null;
    issignout = true;
    notifyListeners();
  }
}
