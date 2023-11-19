import 'package:firebase_auth/firebase_auth.dart';
import '../libraries.dart';

class AuthService {
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return true;
    } on FirebaseAuthException catch (err) {
      toastMessage(message: err.toString(), color: AppColors.alertColor);
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return true;
    } on FirebaseAuthException catch (err) {
      toastMessage(message: err.toString(), color: AppColors.alertColor);
    }
  }

  Future signOut() async {
    try {
      FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (err) {
      toastMessage(message: err.toString(), color: AppColors.alertColor);
    }
  }
}
