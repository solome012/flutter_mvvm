import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_project1/model/user_model.dart';
import 'package:mvvm_project1/repository/auth_repository.dart';
import 'package:mvvm_project1/utility/routes/routes_name.dart';
import 'package:mvvm_project1/utility/utils.dart';
import 'package:mvvm_project1/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  final _myrepo = AuthRespository();
  bool _loading = false;
  bool get loading => _loading;

  bool _signupLoading = false;
  bool get signupLoading => _signupLoading;

  setSignUpLoading(bool value) {
    _signupLoading = value;
    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myrepo.loginApi(data).then((value) {
      Utils.flushBarErrorMessage("login successful", context);
      setLoading(false);
      final userPreferences =
          Provider.of<UserViewModel>(context, listen: false);
      userPreferences.saveUser(UserModel(token: value['token'].toString()));
      Navigator.pushNamed(context, Routename.home);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError(
      (error, stackTrace) {
        setSignUpLoading(false);
        Utils.flushBarErrorMessage(error.toString(), context);
        if (kDebugMode) {
          print(error.toString());
        }
      },
    );
  }

  //sign up api  view model
  Future<void> signupApi(dynamic data, BuildContext context) async {
    setSignUpLoading(true);

    _myrepo.signupApi(data).then((value) {
      Utils.flushBarErrorMessage("sign up  successful", context);
      setSignUpLoading(false);
      Navigator.pushNamed(context, Routename.home);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError(
      (error, stackTrace) {
        setSignUpLoading(false);
        Utils.flushBarErrorMessage(error.toString(), context);
        if (kDebugMode) {
          print(error.toString());
        }
      },
    );
  }
}
