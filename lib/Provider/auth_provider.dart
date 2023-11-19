import '../libraries.dart';

class AuthProvider extends ChangeNotifier {
  AuthService authService = AuthService();

  signInUser(String email, String password) async {
    await authService.signInWithEmailAndPassword(email, password).then((value) {
      toastMessage(message: 'Welcome $email!', color: AppColors.successColor);
    });
    notifyListeners();
  }

  signUpUser(String email, String password) async {
    await authService.registerWithEmailAndPassword(email, password).then(
      (value) {
        toastMessage(message: 'Welcome $email!', color: AppColors.successColor);
      },
    );
    notifyListeners();
  }

  signOutUser(BuildContext context) async {
    await authService.signOut().whenComplete(() {
      toastMessage(message: 'See you soon!', color: AppColors.successColor);
      Navigator.pushNamedAndRemoveUntil(
          context, RouteName.loginScreen, (route) => false);
    });
  }
}
