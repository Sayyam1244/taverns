import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';

class LoginSignupTabview extends StatelessWidget {
  const LoginSignupTabview({
    Key? key,
    required this.tabviewController,
  }) : super(key: key);

  final TabController tabviewController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.v,
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
              child: Text(
                "Login",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Tab(
            child: SizedBox(
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
