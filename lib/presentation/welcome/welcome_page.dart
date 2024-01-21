import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import 'widgets/welcome_item.dart';
import 'welcome_cubit.dart';
import 'welcome_state.dart';

class WelcomePage extends StatefulWidget {
  final WelcomeCubit cubit;

  const WelcomePage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomeState();
}

class _WelcomeState extends State<WelcomePage> {
  WelcomeCubit get cubit => widget.cubit;

  @override
  void initState() {
    cubit.navigator.context = context;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Text(
                "Welcome to",
                style: theme.textTheme.headlineSmall,
              ),
              Text(
                "Tavern".toUpperCase(),
                style: CustomTextStyles.headlineLargeCairoPrimary,
              ),
              SizedBox(height: 40.v),
              WelcomeItem(
                imagePath: ImageConstant.welcomeToTavern,
                title: 'Welcome to Tavern',
                body:
                    'Your gateway to safe and enjoyable tabletop gaming experiences',
              ),
              WelcomeItem(
                imagePath: ImageConstant.safetyFirst,
                title: 'Safety First',
                body:
                    'Enjoy gaming in a secure environment. Learn our safety guidelines',
              ),
              WelcomeItem(
                imagePath: ImageConstant.discoverTaverns,
                title: 'Discover Taverns and GMs',
                body:
                    'Connect with local Taverns and experienced Game Masters.',
              ),
              Spacer(),
              CustomElevatedButton(
                onPressed: () {
                  cubit.openLoginAndSignup();
                },
                text: "Get Started",
                margin: EdgeInsets.symmetric(horizontal: 24.h),
              ),
              SizedBox(height: 25.v),
              Text(
                "Already a member",
                style: CustomTextStyles.titleMediumGray60001,
              ),
              SizedBox(height: 46.v),
            ],
          ),
        ),
      ),
    );
  }
}
