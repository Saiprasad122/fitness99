import 'package:fitness_99/views/auth_screen/login_view.dart';
import 'package:fitness_99/views/auth_screen/on_boarding_view.dart';
import 'package:fitness_99/views/auth_screen/sign_up_view.dart';
import 'package:fitness_99/views/auth_screen/splash_sceen.dart';
import 'package:fitness_99/views/chat_screen/chat_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static const INITIAL = Routes.SplashScreen;

  static final routes = [
    GetPage(name: Routes.SplashScreen, page: () => SplashScreenView()),
    GetPage(name: Routes.OnBoardScreen, page: () => OnBoardingView()),
    GetPage(name: Routes.SignupScreen, page: () => SignUpScreenView()),
    GetPage(name: Routes.LoginScreen, page: () => LoginScreenView()),
    GetPage(name: Routes.ChatScreen, page: () => ChatScreenView())
  ];
}

abstract class Routes {
  static const SplashScreen = _Paths.splashScreen;
  static const OnBoardScreen = _Paths.onBoardingScreen;
  static const SignupScreen = _Paths.signUpScreen;
  static const LoginScreen = _Paths.loginScreen;
  static const ChatScreen = _Paths.chatScreen;
}

abstract class _Paths {
  static const splashScreen = '/splashScreen';
  static const onBoardingScreen = '/onBoardScreen';
  static const signUpScreen = '/signUpScreen';
  static const loginScreen = '/loginScreen';
  static const chatScreen = '/chatScreen';
}

// Route<T> getRoute<T>(Widget page) {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => page,
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       final tween = Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
//           .chain(CurveTween(curve: Curves.easeOutQuart));
//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }
