import 'package:cleanproject/data_layer/data_source/Remote_Data_Sources/Firebase_Auth_Services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepository{

  FirebaseAuthServices _firebaseAuthServices;

  FirebaseAuthRepository(this._firebaseAuthServices);

  Future<User?> Signupfunction(String email,String password)async{
    return _firebaseAuthServices.firebaseSignup(email, password);
  }
  Future<User?> Loginfunction(String email, String password)async{
    return _firebaseAuthServices.firebaseLogin(email, password);
  }
  Future<void> recoverpasswordfunction(String email)async{
    return _firebaseAuthServices.firebaseRecoverpassword(email);
  }
  Future<void> signoutfunction()async{
    return _firebaseAuthServices.firebaseLogout();
  }
}