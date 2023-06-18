import 'package:complete_advance_course/presentation/forget_password/forget_password.dart';
import 'package:complete_advance_course/presentation/login/login.dart';
import 'package:complete_advance_course/presentation/main/main_view.dart';
import 'package:complete_advance_course/presentation/onboarding/onboarding.dart';
import 'package:complete_advance_course/presentation/register/register.dart';
import 'package:complete_advance_course/presentation/resources/app_string.dart';
import 'package:complete_advance_course/presentation/splash/splash.dart';
import 'package:complete_advance_course/presentation/store_details/store_details..dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onboarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgetPasswordRoute = "/forgetPassowrd";
  static const String mainRoute = "/main";
  static const String storeDetails = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgetPassword());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetails:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                  title: const Text(AppString.noRouteFound), centerTitle: true),
              body: const Center(
                child: Text(AppString.noRouteFound),
              ),
            ));
  }
}
