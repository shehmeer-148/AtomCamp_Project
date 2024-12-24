import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices{

  final FirebaseAuth _firebaseAuth;

  FirebaseAuthServices(this._firebaseAuth);

  Future<User?> firebaseLogin(String email, String password)async{
    try{
      UserCredential userCredential =  await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      print(userCredential.user);
      return userCredential.user;
    }catch(e){
     // throw Exception("Failed to login: $e");
      return null;
    }
  }
  Future<User?> firebaseSignup(String email, String password)async{
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      print(userCredential.user.toString());
      print(userCredential.user?.email);
      return userCredential.user;
    }catch(e){
      print("message ${e.toString()} recieved");
      throw Exception("Sign-up failed: $e");

      return null;
    }
  }
  Future<void> firebaseRecoverpassword(String email)async{
    try{ await _firebaseAuth.sendPasswordResetEmail(email: email);}
        catch(e){
      return;
        }
  }
  Future<void> firebaseLogout()async{
    try{
      await _firebaseAuth.signOut();
    }catch(e){
      print(e.toString());
      return;
    }
  }
}


//      with out dependency Injection///

// import 'package:firebase_auth/firebase_auth.dart';
//
//
// class FirebaseAuthServices{
//
//   Future<User?> firebasesignup(String email, String password)async{
//     UserCredential userCredential =  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
//     print(userCredential.user);
//     return userCredential.user;
//   }
// }