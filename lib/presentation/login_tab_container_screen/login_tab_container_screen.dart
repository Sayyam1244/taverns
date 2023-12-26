import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/presentation/login_page/login_page.dart';
import 'package:taverns/presentation/signup_completion_page/signup_completion_page.dart';

class LoginTabContainerScreen extends StatefulWidget {
  const LoginTabContainerScreen({Key? key})
      : super(
          key: key,
        );

  @override
  LoginTabContainerScreenState createState() => LoginTabContainerScreenState();
}

class LoginTabContainerScreenState extends State<LoginTabContainerScreen>
    with TickerProviderStateMixin {
  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 54.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Tavern".toUpperCase(),
                    style: CustomTextStyles.headlineLargeCairoOnPrimary,
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgVectorPrimary,
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
              SizedBox(height: 54.v),
              _buildTabview(context),
              SizedBox(
                height: 551.v,
                child: TabBarView(
                  controller: tabviewController,
                  children: [
                    LoginPage(),
                    SignupCompletionPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildTabview(BuildContext context) {
    return Container(
      height: 48.v,
      width: 327.h,
      decoration: BoxDecoration(
        color: appTheme.yellow50,
        borderRadius: BorderRadius.circular(
          12.h,
        ),
      ),
      child: TabBar(
        controller: tabviewController,
        labelPadding: EdgeInsets.zero,
        labelColor: theme.colorScheme.onErrorContainer.withOpacity(1),
        labelStyle: TextStyle(
          fontSize: 14.fSize,
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelColor: appTheme.gray60001,
        unselectedLabelStyle: TextStyle(
          fontSize: 14.fSize,
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w600,
        ),
        indicatorPadding: EdgeInsets.all(
          6.0.h,
        ),
        indicator: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(
            12.h,
          ),
        ),
        tabs: [
          Tab(
            child: SizedBox(
              width: 33.h,
              child: Text(
                "Login",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Tab(
            child: SizedBox(
              width: 41.h,
              child: Text(
                "Signup",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
