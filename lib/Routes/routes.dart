import '../libraries.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case RouteName.loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginPage());

      case RouteName.signupScreen:
        return MaterialPageRoute(builder: (context) => const SignupPage());

      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomePage());

      case RouteName.createScreen:
        return MaterialPageRoute(
            builder: (context) => const CreateReminderPage());

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('No Route Defined'),
            ),
          ),
        );
    }
  }
}
