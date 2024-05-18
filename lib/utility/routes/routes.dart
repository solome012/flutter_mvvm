import 'package:flutter/material.dart';
import 'package:mvvm_project1/utility/routes/routes_name.dart';
import 'package:mvvm_project1/view/home_screen.dart';
import 'package:mvvm_project1/view/login_view.dart';
import 'package:mvvm_project1/view/signup_view.dart';
import 'package:mvvm_project1/view/splashview.dart';

class Routes {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routename.splash:
        return MaterialPageRoute(builder: (BuildContext context) {
          return const SplashView();
        });

      case Routename.home:
        return MaterialPageRoute(builder: (BuildContext context) {
          return const HomeView();
        });

      case Routename.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginView());

      case Routename.signUp:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignupView());
      default:
        return MaterialPageRoute(builder: (BuildContext context) {
          return const Scaffold(
            body: Center(
              child: Text(" No route Defined"),
            ),
          );
        });
    }
  }
}
