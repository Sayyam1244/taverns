import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';
import 'splash_cubit.dart';

class SplashPage extends StatefulWidget {
  final SplashCubit cubit;

  const SplashPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashState();
}

class _SplashState extends State<SplashPage> {
  SplashCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.navigateToWelcome();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 37.h, vertical: 50.v),
          child: Column(
            children: [
              Spacer(flex: 52),
              SizedBox(
                height: 298.v,
                width: 300.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Tavern".toUpperCase(),
                            style: CustomTextStyles.headlineLargeCairoOnErrorContainer,
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgVector,
                            height: 4.adaptSize,
                            width: 4.adaptSize,
                            margin: EdgeInsets.only(
                              left: 4.h,
                              top: 36.v,
                              bottom: 19.v,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Opacity(
                      opacity: 0.4,
                      child: CustomImageView(
                        imagePath: ImageConstant.logoCircle,
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(flex: 47),
              Text(
                "Loading...".toUpperCase(),
                style: CustomTextStyles.bodySmallwithLetterSpacing,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
