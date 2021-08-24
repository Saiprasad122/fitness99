import 'package:fitness_99/views/chat_screen/chat_screen.dart';
import 'package:fitness_99/views/dashboard.dart';
import 'package:fitness_99/views/views.export.dart';
import 'package:get/get.dart';

class AppPages {
  static const INITIAL = Routes.SplashScreen;

  static final routes = [
    GetPage(
      name: Routes.SplashScreen,
      page: () => SplashScreenView(),
    ),
    GetPage(name: Routes.OnBoardScreen, page: () => OnBoardingView()),
    GetPage(name: Routes.SignupScreen, page: () => SignUpScreenView()),
    GetPage(name: Routes.LoginScreen, page: () => LoginScreenView()),
    GetPage(name: Routes.ChatScreen, page: () => ChatScreenView()),
    GetPage(name: Routes.ProfileScreen, page: () => ProfileView()),
    GetPage(name: Routes.DashboardScreen, page: () => DashboardView()),
  ];
}

abstract class Routes {
  static const SplashScreen = _Paths.splashScreen;
  static const OnBoardScreen = _Paths.onBoardingScreen;
  static const SignupScreen = _Paths.signUpScreen;
  static const LoginScreen = _Paths.loginScreen;
  static const ChatScreen = _Paths.chatScreen;
  static const ProfileScreen = _Paths.profileScreen;
  static const DashboardScreen = _Paths.dashboardScreen;
}

abstract class _Paths {
  static const splashScreen = '/splashScreen';
  static const onBoardingScreen = '/onBoardScreen';
  static const signUpScreen = '/signUpScreen';
  static const loginScreen = '/loginScreen';
  static const chatScreen = '/chatScreen';
  static const profileScreen = '/profileScreen';
  static const dashboardScreen = '/dashboardScreen';
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
