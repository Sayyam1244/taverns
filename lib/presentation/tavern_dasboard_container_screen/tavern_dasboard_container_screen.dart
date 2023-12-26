// import 'package:flutter/material.dart';
// import 'package:taverns/core/app_export.dart';
// import 'package:taverns/presentation/more_page/more_page.dart';
// import 'package:taverns/presentation/tavern_dasboard_page/tavern_dasboard_page.dart';
// import 'package:taverns/widgets/custom_bottom_bar.dart';

// // ignore_for_file: must_be_immutable
// class TavernDasboardContainerScreen extends StatelessWidget {
//   TavernDasboardContainerScreen({Key? key}) : super(key: key);

//   GlobalKey<NavigatorState> navigatorKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             backgroundColor: appTheme.gray5001,
//             body: Navigator(
//                 key: navigatorKey,
//                 initialRoute: AppRoutes.tavernDasboardPage,
//                 onGenerateRoute: (routeSetting) => PageRouteBuilder(pageBuilder: (ctx, ani, ani1) => getCurrentPage(routeSetting.name!), transitionDuration: Duration(seconds: 0))),
//             bottomNavigationBar: _buildBottomBar(context)));
//   }

//   /// Section Widget
//   Widget _buildBottomBar(BuildContext context) {
//     return CustomBottomBar(onChanged: (BottomBarEnum type) {
//       Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
//     });
//   }

//   ///Handling route based on bottom click actions
//   String getCurrentRoute(BottomBarEnum type) {
//     switch (type) {
//       case BottomBarEnum.Home:
//         return "/";
//       case BottomBarEnum.Calendar:
//         return "/";
//       case BottomBarEnum.Message:
//         return AppRoutes.tavernDasboardPage;
//       case BottomBarEnum.More:
//         return AppRoutes.morePage;
//       default:
//         return "/";
//     }
//   }

//   ///Handling page based on route
//   Widget getCurrentPage(String currentRoute) {
//     switch (currentRoute) {
//       case AppRoutes.tavernDasboardPage:
//         return TavernDasboardPage();
//       case AppRoutes.morePage:
//         return MorePage();
//       default:
//         return DefaultWidget();
//     }
//   }
// }
