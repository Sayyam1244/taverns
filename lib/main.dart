import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:taverns/data/event_helper.dart';
import 'package:taverns/data/place_search.dart';
import 'package:taverns/domain/repository/events_repository.dart';
import 'package:taverns/domain/repository/places_repository.dart';
import 'package:taverns/presentation/chat/chat_cubit.dart';
import 'package:taverns/presentation/chat/chat_initial_params.dart';
import 'package:taverns/presentation/edit_location_map/edit_location_on_map_cubit.dart';
import 'package:taverns/presentation/edit_location_map/edit_location_on_map_initial_params.dart';
import 'package:taverns/presentation/edit_location_map/edit_location_on_map_navigator.dart';
import 'package:taverns/presentation/edit_profile/edit_profile_cubit.dart';
import 'package:taverns/presentation/edit_profile/edit_profile_initial_params.dart';
import 'package:taverns/presentation/edit_profile/edit_profile_navigator.dart';
import 'package:taverns/presentation/email_verification/email_verification_cubit.dart';
import 'package:taverns/presentation/email_verification/email_verification_initial_params.dart';
import 'package:taverns/presentation/email_verification/email_verification_navigator.dart';
import 'package:taverns/presentation/enable_location/enable_location_cubit.dart';
import 'package:taverns/presentation/enable_location/enable_location_initial_params.dart';
import 'package:taverns/presentation/enable_location/enable_location_navigator.dart';
import 'package:taverns/presentation/enable_location/enable_location_page.dart';
import 'package:taverns/presentation/event_detail/event_detail_cubit.dart';
import 'package:taverns/presentation/event_detail/event_detail_initial_params.dart';
import 'package:taverns/presentation/event_detail/event_detail_navigator.dart';
import 'package:taverns/presentation/forgot_password_screen/forgot_password_cubit.dart';
import 'package:taverns/presentation/forgot_password_screen/forgot_password_initial_params.dart';
import 'package:taverns/presentation/forgot_password_screen/forgot_password_navigator.dart';
import 'package:taverns/presentation/login_and_signup/login_and_signup_cubit.dart';
import 'package:taverns/presentation/login_and_signup/login_and_signup_initial_params.dart';
import 'package:taverns/presentation/login_and_signup/login_and_signup_navigator.dart';
import 'package:taverns/presentation/notification_board/notification_board_cubit.dart';
import 'package:taverns/presentation/notification_board/notification_board_initial_params.dart';
import 'package:taverns/presentation/notification_board/notification_board_navigator.dart';
import 'package:taverns/presentation/notifications_email_screen/notification_settings_cubit.dart';
import 'package:taverns/presentation/notifications_email_screen/notification_settings_initial_params.dart';
import 'package:taverns/presentation/notifications_email_screen/notification_settings_navigator.dart';
import 'package:taverns/presentation/search_event/search_event_cubit.dart';
import 'package:taverns/presentation/search_event/search_event_initial_params.dart';
import 'package:taverns/presentation/search_user/search_user_cubit.dart';
import 'package:taverns/presentation/search_user/search_user_initial_params.dart';
import 'package:taverns/presentation/sign_up_select_role_screen/signup_select_role_cubit.dart';
import 'package:taverns/presentation/sign_up_select_role_screen/signup_select_role_initial_params.dart';
import 'package:taverns/presentation/sign_up_select_role_screen/signup_select_role_navigator.dart';
import 'package:taverns/presentation/sign_up_successful/signup_success_full_cubit.dart';
import 'package:taverns/presentation/sign_up_successful/signup_success_full_initial_params.dart';
import 'package:taverns/presentation/sign_up_successful/signup_success_full_navigator.dart';
import 'package:taverns/presentation/signup_completion/signup_completion_cubit.dart';
import 'package:taverns/presentation/signup_completion/signup_completion_initial_params.dart';
import 'package:taverns/presentation/signup_completion/signup_completion_navigator.dart';
import 'package:taverns/presentation/splash/splash_cubit.dart';
import 'package:taverns/presentation/splash/splash_initial_params.dart';
import 'package:taverns/presentation/splash/splash_navigator.dart';
import 'package:taverns/presentation/splash/splash_page.dart';
import 'package:taverns/presentation/tavern_dasboard/tavern_dashboard_cubit.dart';
import 'package:taverns/presentation/tavern_dasboard/tavern_dashboard_initial_params.dart';
import 'package:taverns/presentation/tavern_dasboard/tavern_dashboard_navigator.dart';
import 'package:taverns/presentation/tavern_dasboard/tavern_dashboard_page.dart';
import 'package:taverns/presentation/tavern_profile/tavern_profile_cubit.dart';
import 'package:taverns/presentation/tavern_profile/tavern_profile_initial_params.dart';
import 'package:taverns/presentation/tavern_profile/tavern_profile_navigator.dart';
import 'package:taverns/presentation/welcome/welcome_cubit.dart';
import 'package:taverns/presentation/welcome/welcome_initial_params.dart';
import 'package:taverns/presentation/welcome/welcome_navigator.dart';
import 'package:taverns/theme/theme_helper.dart';
import 'package:get_it/get_it.dart';

import 'core/utils/size_utils.dart';
import 'data/auth.dart';
import 'data/location_helper.dart';
import 'data/user.dart';
import 'domain/repository/auth_repository.dart';
import 'domain/repository/location_repository.dart';
import 'domain/repository/user_repository.dart';
import 'firebase_options.dart';
import 'navigation/app_navigation.dart';

final getIt = GetIt.instance;

void main() async {
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
  getIt.registerSingleton<SignupCompletionNavigator>(SignupCompletionNavigator(getIt()));
  getIt.registerSingleton<EnableLocationNavigator>(EnableLocationNavigator(getIt()));
  getIt.registerSingleton<NotificationSettingsNavigator>(NotificationSettingsNavigator(getIt()));
  getIt.registerSingleton<SignupSuccessFullNavigator>(SignupSuccessFullNavigator(getIt()));
  getIt.registerSingleton<TavernDashboardNavigator>(TavernDashboardNavigator(getIt()));
  getIt.registerSingleton<EmailVerificationNavigator>(EmailVerificationNavigator(getIt()));
  getIt.registerSingleton<NotificationBoardNavigator>(NotificationBoardNavigator(getIt()));
  getIt.registerSingleton<TavernProfileNavigator>(TavernProfileNavigator(getIt()));
  getIt.registerSingleton<EditProfileNavigator>(EditProfileNavigator(getIt()));
  getIt.registerSingleton<EditLocationOnMapNavigator>(EditLocationOnMapNavigator(getIt()));

  getIt.registerSingleton<AuthRepository>(Auth());
  getIt.registerSingleton<UserRepository>(User());
  getIt.registerSingleton<LocationRepository>(LocationHelper());
  getIt.registerSingleton<EventRepository>(EventHelper());
  getIt.registerSingleton<PlacesRepository>(PlaceSearch('AIzaSyAz7vjzXAVIh7DBoS61XrYFtn8V8bcOs-c'));

  getIt.registerFactoryParam<SplashCubit, SplashInitialParams, dynamic>((params, param2) => SplashCubit(params, getIt()));
  getIt.registerFactoryParam<WelcomeCubit, WelcomeInitialParams, dynamic>((params, param2) => WelcomeCubit(params, getIt()));
  getIt.registerFactoryParam<LoginAndSignupCubit, LoginAndSignupInitialParams, dynamic>((params, param2) => LoginAndSignupCubit(params, getIt(), getIt()));
  getIt.registerFactoryParam<ForgotPasswordCubit, ForgotPasswordInitialParams, dynamic>((params, param2) => ForgotPasswordCubit(params, getIt(), getIt()));
  getIt.registerFactoryParam<SignupSelectRoleCubit, SignupSelectRoleInitialParams, dynamic>((params, param2) => SignupSelectRoleCubit(params, getIt(), getIt(), getIt()));
  getIt.registerFactoryParam<SignupCompletionCubit, SignupCompletionInitialParams, dynamic>((params, param2) => SignupCompletionCubit(params, getIt(), getIt(), getIt()));
  getIt.registerFactoryParam<EnableLocationCubit, EnableLocationInitialParams, dynamic>((params, param2) => EnableLocationCubit(params, getIt(), getIt(), getIt(), getIt()));
  getIt.registerFactoryParam<NotificationSettingsCubit, NotificationSettingsInitialParams, dynamic>(
      (params, param2) => NotificationSettingsCubit(params, getIt(), getIt(), getIt()));
  getIt.registerFactoryParam<SignupSuccessFullCubit, SignupSuccessFullInitialParams, dynamic>((params, param2) => SignupSuccessFullCubit(params, getIt()));
  getIt.registerFactoryParam<TavernDashboardCubit, TavernDashboardInitialParams, dynamic>((params, param2) => TavernDashboardCubit(params, getIt(), getIt(), getIt(), getIt()));
  getIt.registerFactoryParam<EmailVerificationCubit, EmailVerificationInitialParams, dynamic>((params, param2) => EmailVerificationCubit(params, getIt(), getIt()));
  getIt.registerFactoryParam<NotificationBoardCubit, NotificationBoardInitialParams, dynamic>(
      (params, param2) => NotificationBoardCubit(params, getIt(), getIt(), getIt(), getIt()));
  getIt.registerFactoryParam<TavernProfileCubit, TavernProfileInitialParams, dynamic>((params, param2) => TavernProfileCubit(params, getIt(), getIt()));
  getIt.registerFactoryParam<SearchEventCubit, SearchEventInitialParams, dynamic>((params, param2) => SearchEventCubit(params));
  getIt.registerFactoryParam<ChatCubit, ChatInitialParams, dynamic>((params, param2) => ChatCubit(params));
  getIt.registerFactoryParam<SearchUserCubit, SearchUserInitialParams, dynamic>((params, param2) => SearchUserCubit(params));
  getIt.registerFactoryParam<EditProfileCubit, EditProfileInitialParams, dynamic>((params, param2) => EditProfileCubit(params, getIt(), getIt()));
  getIt.registerFactoryParam<EditLocationOnMapCubit, EditLocationOnMapInitialParams, dynamic>((params, param2) => EditLocationOnMapCubit(params, getIt(), getIt()));
  getIt.registerFactoryParam<EventDetailCubit, EventDetailInitialParams, dynamic>((params, param2) => EventDetailCubit(params, getIt(), getIt()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
            theme: theme.copyWith(appBarTheme: Theme.of(context).appBarTheme.copyWith(iconTheme: IconThemeData(size: 14))),
            title: 'Taverns',
            debugShowCheckedModeBanner: false,
            home: TavernDashboardPage(
              cubit: getIt(
                param1: TavernDashboardInitialParams(),
              ),
            )
            // // EnableLocationPage(
            // //     cubit: getIt(param1: EnableLocationInitialParams()))
            // SplashPage(cubit: getIt(param1: SplashInitialParams())),
            );
      },
    );
  }
}
