import 'package:flutter/material.dart';
import 'package:taverns/presentation/loginAndSignup/login_and_signup_cubit.dart';
import 'package:taverns/presentation/loginAndSignup/login_and_signup_initial_params.dart';
import 'package:taverns/presentation/splash/splash_cubit.dart';
import 'package:taverns/presentation/splash/splash_initial_params.dart';
import 'package:taverns/presentation/splash/splash_navigator.dart';
import 'package:taverns/presentation/splash/splash_page.dart';
import 'package:taverns/presentation/welcome/welcome_cubit.dart';
import 'package:taverns/presentation/welcome/welcome_initial_params.dart';
import 'package:taverns/presentation/welcome/welcome_navigator.dart';
import 'package:taverns/theme/theme_helper.dart';
import 'package:get_it/get_it.dart';

import 'core/utils/size_utils.dart';
import 'navigation/app_navigation.dart';

final getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  getIt.registerSingleton<AppNavigator>(AppNavigator());
  getIt.registerSingleton<SplashNavigator>(SplashNavigator(getIt()));
  getIt.registerSingleton<WelcomeNavigator>(WelcomeNavigator(getIt()));

  getIt.registerFactoryParam<SplashCubit, SplashInitialParams, dynamic>((params, param2) => SplashCubit(params, getIt()));
  getIt.registerFactoryParam<WelcomeCubit,WelcomeInitialParams, dynamic>((params, param2) => WelcomeCubit(params, getIt()));
  getIt.registerFactoryParam<LoginAndSignupCubit, LoginAndSignupInitialParams, dynamic>((params, param2) => LoginAndSignupCubit(params));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: theme,
          title: 'Taverns',
          debugShowCheckedModeBanner: false,
          home: SplashPage(cubit: getIt(param1: SplashInitialParams())),
        );
      },
    );
  }
}
