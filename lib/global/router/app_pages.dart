import 'package:fitness_99/views/views.export.dart';

class AppPages {
  static const INITIAL = Routes.SplashScreen;
  static final initialBindings = SplashScreenBinding();

  static final routes = [
    GetPage(name: Routes.SplashScreen, page: () => SplashScreenView()),
    GetPage(name: Routes.OnBoardScreen, page: () => OnBoardingView()),
    GetPage(name: Routes.SignupScreen, page: () => SignUpScreenView()),
    GetPage(name: Routes.LoginScreen, page: () => LoginScreenView()),
    GetPage(
        name: Routes.ForgotPasswordScreeen,
        page: () => ForgotPasswordScreeen()),
    GetPage(name: Routes.DashboardScreen, page: () => DashboardView()),
    GetPage(name: Routes.ChatScreen, page: () => ChatScreenView()),
    GetPage(name: Routes.SearchScreen, page: () => SearchScreenView()),
    GetPage(name: Routes.DisplayGroupScreen, page: () => DisplayGroupScreen()),
    GetPage(name: Routes.CreateGroupScreen, page: () => CreateGroupScreen()),
    GetPage(name: Routes.ProfileScreen, page: () => ProfileView()),
    GetPage(name: Routes.EditProfileScreen, page: () => EditProfileScreen()),
    GetPage(name: Routes.PersonalGoalsAdd, page: () => PersonalGoalsAdd()),
    GetPage(
        name: Routes.PersonalGoalsDisplay, page: () => PersonalGoalsDisplay()),
    GetPage(name: Routes.CanDoAdd, page: () => CanDoAdd()),
    GetPage(name: Routes.CanDoDislay, page: () => CanDoDisplay()),
    GetPage(name: Routes.CannotDoAdd, page: () => CannotDoAdd()),
    GetPage(name: Routes.CannotDoDisplay, page: () => CannnotDoDisplay()),
    GetPage(name: Routes.CategoriesScreen, page: () => CategoriesScreen()),
    GetPage(
        name: Routes.PreferenceTimeScreen, page: () => PreferenceTimeScreen()),
    GetPage(name: Routes.PreferenceTimeAdd, page: () => PreferenceTimeAdd()),
    GetPage(name: Routes.InvitationScreen, page: () => InvitationScreen()),
    GetPage(name: Routes.MoreOptionsScreen, page: () => MoreOptionsScreen()),
    GetPage(name: Routes.ProductScreen, page: () => ProductScreen()),
  ];
}

abstract class Routes {
  static const SplashScreen = _Paths.splashScreen;
  static const OnBoardScreen = _Paths.onBoardingScreen;
  static const SignupScreen = _Paths.signUpScreen;
  static const LoginScreen = _Paths.loginScreen;
  static const ForgotPasswordScreeen = _Paths.forgotPasswordScreen;
  static const DashboardScreen = _Paths.dashboardScreen;
  static const ChatScreen = _Paths.chatScreen;
  static const SearchScreen = _Paths.searchSreen;
  static const DisplayGroupScreen = _Paths.displayGroupScreen;
  static const CreateGroupScreen = _Paths.createGroupScreen;
  static const ProfileScreen = _Paths.profileScreen;
  static const EditProfileScreen = _Paths.editProfileScreen;
  static const PersonalGoalsAdd = _Paths.personalGoalsAdd;
  static const PersonalGoalsDisplay = _Paths.personalGoalsDisplay;
  static const CanDoDislay = _Paths.canDoDisplay;
  static const CanDoAdd = _Paths.canDoAdd;
  static const CannotDoAdd = _Paths.cannotDoAdd;
  static const CannotDoDisplay = _Paths.cannotDoDisplay;
  static const CategoriesScreen = _Paths.categoriesScreen;
  static const PreferenceTimeScreen = _Paths.preferenceTimeScreen;
  static const PreferenceTimeAdd = _Paths.preferenceTimeAdd;
  static const InvitationScreen = _Paths.invitationScree;
  static const MoreOptionsScreen = _Paths.moreOptionsScreen;
  static const ProductScreen = _Paths.productScreeen;
}

abstract class _Paths {
  static const splashScreen = '/splashScreen';
  static const onBoardingScreen = '/onBoardScreen';
  static const signUpScreen = '/signUpScreen';
  static const loginScreen = '/loginScreen';
  static const forgotPasswordScreen = '/forgotPasswordScreen';
  static const dashboardScreen = '/dashboardScreen';
  static const chatScreen = '/chatScreen';
  static const searchSreen = '/searchScreen';
  static const displayGroupScreen = '/displayGroupScreen';
  static const createGroupScreen = '/createGroupScreen';
  static const profileScreen = '/profileScreen';
  static const editProfileScreen = '/editProfileScreen';
  static const personalGoalsAdd = '/personalGoalsAdd';
  static const personalGoalsDisplay = '/personalGoalsDisplay';
  static const canDoDisplay = '/canDoDisplay';
  static const canDoAdd = '/canDoAdd';
  static const cannotDoDisplay = '/cannotDoDisplay';
  static const cannotDoAdd = '/cannotDoAdd';
  static const categoriesScreen = '/categoriesScreen';
  static const preferenceTimeScreen = '/preferenceTimeScreen';
  static const preferenceTimeAdd = '/preferenceTimeAdd';
  static const invitationScree = '/invitationScreen';
  static const moreOptionsScreen = '/moreOptionsScreen';
  static const productScreeen = '/productScreen';
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
