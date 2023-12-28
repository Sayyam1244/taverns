import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:taverns/presentation/forgot_password_screen/forgot_password_cubit.dart';
import 'package:taverns/presentation/forgot_password_screen/forgot_password_initial_params.dart';
import 'package:taverns/presentation/forgot_password_screen/forgot_password_navigator.dart';
import 'package:taverns/presentation/login_and_signup/login_and_signup_cubit.dart';
import 'package:taverns/presentation/login_and_signup/login_and_signup_initial_params.dart';
import 'package:taverns/presentation/login_and_signup/login_and_signup_navigator.dart';
import 'package:taverns/presentation/sign_up_select_role_screen/signup_select_role_cubit.dart';
import 'package:taverns/presentation/sign_up_select_role_screen/signup_select_role_initial_params.dart';
import 'package:taverns/presentation/sign_up_select_role_screen/signup_select_role_navigator.dart';
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
import 'firebase_options.dart';
import 'navigation/app_navigation.dart';

final getIt = GetIt.instance;

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MyApp());
  getIt.registerSingleton<AppNavigator>(AppNavigator());
  getIt.registerSingleton<SplashNavigator>(SplashNavigator(getIt()));
  getIt.registerSingleton<WelcomeNavigator>(WelcomeNavigator(getIt()));
  getIt.registerSingleton<LoginAndSignupNavigator>(LoginAndSignupNavigator(getIt()));
  getIt.registerSingleton<ForgotPasswordNavigator>(ForgotPasswordNavigator(getIt()));
  getIt.registerSingleton<SignupSelectRoleNavigator>(SignupSelectRoleNavigator(getIt()));

  getIt.registerFactoryParam<SplashCubit, SplashInitialParams, dynamic>(
      (params, param2) => SplashCubit(params, getIt()));
  getIt.registerFactoryParam<WelcomeCubit, WelcomeInitialParams, dynamic>(
      (params, param2) => WelcomeCubit(params, getIt()));
  getIt.registerFactoryParam<LoginAndSignupCubit, LoginAndSignupInitialParams,
      dynamic>((params, param2) => LoginAndSignupCubit(params,getIt()));
  getIt.registerFactoryParam<ForgotPasswordCubit, ForgotPasswordInitialParams,
      dynamic>((params, param2) =>ForgotPasswordCubit(params,getIt()));
  getIt.registerFactoryParam<SignupSelectRoleCubit, SignupSelectRoleInitialParams,
      dynamic>((params, param2) =>SignupSelectRoleCubit(params,getIt()));
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
