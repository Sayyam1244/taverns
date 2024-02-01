import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/presentation/tavern_dasboard/screens/calender.dart';
import 'package:taverns/presentation/tavern_dasboard/screens/chats.dart';
import 'package:taverns/presentation/tavern_dasboard/screens/more_page.dart';
import 'package:taverns/presentation/tavern_dasboard/screens/home.dart';
import 'package:taverns/presentation/tavern_dasboard/tavern_dashboard_state.dart';
import 'package:taverns/presentation/tavern_dasboard/widgets/tavern_appbar.dart';
import 'package:taverns/widgets/custome_loading_widget.dart';
import '../../core/app_export.dart';
import 'tavern_dashboard_cubit.dart';

class TavernDashboardPage extends StatefulWidget {
  final TavernDashboardCubit cubit;

  const TavernDashboardPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<TavernDashboardPage> createState() => _TavernDashboardState();
}

class _TavernDashboardState extends State<TavernDashboardPage> {
  TavernDashboardCubit get cubit => widget.cubit;
  List<Widget> screens(
    TavernDashboardCubit cubit,
    TavernDashboardState state,
  ) =>
      [
        Home(cubit: cubit, state: state),
        CalenderScreen(cubit: cubit),
        Chats(cubit: cubit),
        MorePage(cubit: cubit, state: state)
      ];

  @override
  void initState() {
    cubit.navigator.context = context;
    cubit.getUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<TavernDashboardCubit, TavernDashboardState>(
        buildWhen: (previous, current) {
          log('getUserData');

          if (previous.currentIndex != current.currentIndex ||
              previous.isloading != current.isloading) {
            return true;
          }
          return false;
        },
        bloc: cubit,
        builder: (context, state) => Scaffold(
          backgroundColor: appTheme.gray5001,
          resizeToAvoidBottomInset: false,
          appBar: state.currentIndex == 0
              ? tavernAppBar(context, () {
                  cubit.navigateToNotifications();
                })
              : null,
          body: state.isloading
              ? CustomLoadingWidget()
              : screens(cubit, state)[state.currentIndex],
          bottomNavigationBar:
              BlocBuilder<TavernDashboardCubit, TavernDashboardState>(
            buildWhen: (previous, current) =>
                previous.currentIndex != current.currentIndex,
            bloc: cubit,
            builder: (context, state) => Container(
              height: 70,
              child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  unselectedItemColor: theme.colorScheme.errorContainer,
                  selectedLabelStyle: CustomTextStyles.bottomBarSelected,
                  unselectedLabelStyle: CustomTextStyles.bottomBarUnselected,
                  showUnselectedLabels: true,
                  showSelectedLabels: true,
                  iconSize: 18,
                  onTap: (value) {
                    cubit.update(value);
                  },
                  selectedItemColor: theme.colorScheme.primary,
                  currentIndex: state.currentIndex,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.calendar_month), label: 'Calender'),
                    BottomNavigationBarItem(
                        icon: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(Icons.comment_outlined),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 12, left: 20),
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            )
                          ],
                        ),
                        label: 'Message'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.more_horiz), label: 'More'),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
