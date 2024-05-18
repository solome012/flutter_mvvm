import 'package:flutter/material.dart';
import 'package:mvvm_project1/model/user_model.dart';
import 'package:mvvm_project1/utility/routes/routes_name.dart';
import 'package:mvvm_project1/view_model/user_view_model.dart';

class SplashServices {
  Future<UserModel> getUserDate() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    getUserDate().then((value) async {
      if (value.token == 'null' || value.token == '') {
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pushNamed(context, Routename.home);
      } else {
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pushNamed(context, Routename.signUp);
      }
    });
  }
}
