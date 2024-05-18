import 'package:flutter/material.dart';
import 'package:mvvm_project1/utility/routes/routes.dart';
import 'package:mvvm_project1/utility/routes/routes_name.dart';
import 'package:mvvm_project1/view_model/auth_view_model.dart';
import 'package:mvvm_project1/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AuthViewModel(),
          ),
          ChangeNotifierProvider(create: (_) {
            return UserViewModel();
          })
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: Routename.splash,
          onGenerateRoute: Routes.generateRoute,
        ));
  }
}
