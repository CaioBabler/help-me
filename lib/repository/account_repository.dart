import 'package:firebase_auth/firebase_auth.dart';
import 'package:help_me/view_model/login_view_model.dart';
import 'package:help_me/view_model/singup_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountRepository {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseFirestore db = FirebaseFirestore.instance;

  createUserWithEmail(SingupViewModel singupViewModel) {
    try {
      _firebaseAuth
          .createUserWithEmailAndPassword(
              email: singupViewModel.email, password: singupViewModel.password)
          .then((value) {
        db.collection("user").doc(value.user.uid).set(singupViewModel.toJson());
      });

      return "sucess";
    } catch (e) {
      return "error";
    }
  }

  authUserWithEmail(LoginViewModel loginViewModel) async {
    var response;
    await _firebaseAuth
        .signInWithEmailAndPassword(
            email: loginViewModel.email, password: loginViewModel.password)
        .then((value) => response = "sucess")
        .catchError((onError) => response = "error");
    return response;
  }

  verifyUserAuth() async {
    User user = _firebaseAuth.currentUser;
    return user;
  }

  singOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }
}
