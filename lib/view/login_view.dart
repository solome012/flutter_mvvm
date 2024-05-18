import 'package:flutter/material.dart';
import 'package:mvvm_project1/resources/components/round_button.dart';
import 'package:mvvm_project1/utility/routes/routes_name.dart';
import 'package:mvvm_project1/utility/utils.dart';
import 'package:mvvm_project1/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailController.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text("login  screen"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              focusNode: emailFocusNode,
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "Email",
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_sharp),
              ),
              onSubmitted: (value) => Utils.fieldFocusChange(
                context,
                emailFocusNode,
                passwordFocusNode,
              ),
            ),
            ValueListenableBuilder(
                valueListenable: _obsecurePassword,
                builder: (
                  context,
                  value,
                  child,
                ) {
                  return TextField(
                      focusNode: passwordFocusNode,
                      obscureText: _obsecurePassword.value,
                      obscuringCharacter: '#',
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: "password",
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.password_outlined),
                        suffixIcon: InkWell(
                          onTap: () {
                            _obsecurePassword.value = !_obsecurePassword.value;
                          },
                          child: Icon(_obsecurePassword.value
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ));
                }),
            SizedBox(
              height: height * .084,
            ),
            RoundButton(
                loading: authViewModel.loading,
                title: "login",
                onPress: () {
                  if (emailController.text.isEmpty) {
                    Utils.flushBarErrorMessage("Please enter email", context);
                  } else if (passwordController.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        "Please enter password", context);
                  } else if (passwordController.text.length < 6) {
                    Utils.flushBarErrorMessage(
                        "Please Enter 6 digit password", context);
                  } else {
                    // Map data = {
                    //   "email": emailController.text.toString(),
                    //   "password": passwordController.text.toString()
                    // };

                    Map data = {
                      'email': 'eve.holt@reqres.in',
                      'password': 'cityslicka',
                    };
                    authViewModel.loginApi(data, context);
                    debugPrint("api hit");
                  }
                }),
            SizedBox(
              height: height * .02,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routename.signUp);
                },
                child: const Text("Don't have an account ? Sign up"))
          ],
        ),
      ),
    );
  }
}
