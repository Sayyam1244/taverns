import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/presentation/tavern_dasboard/screens/more_page.dart';
import 'package:taverns/presentation/tavern_dasboard/screens/tavern_home.dart';
import 'package:taverns/presentation/tavern_dasboard/tavern_dashboard_state.dart';
import 'package:taverns/presentation/tavern_dasboard/widgets/notificaiton_board.dart';
import 'package:taverns/presentation/tavern_dasboard/widgets/tavern_appbar.dart';
import 'package:taverns/presentation/tavern_dasboard/widgets/tavern_profile_widget.dart';
import 'package:taverns/widgets/custom_elevated_button.dart';
import 'package:taverns/widgets/custom_search_view.dart';
import '../../core/app_export.dart';
import 'tavern_dashboard_cubit.dart';
import 'widgets/eventcard_item_widget.dart';

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
        TavernHome(
          cubit: cubit,
          state: state,
        ),
        Text('calender'),
        Text('message'),
        MorePage()
      ];
  @override
  void initState() {
    cubit.navigator.context = context;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<TavernDashboardCubit, TavernDashboardState>(
        bloc: cubit,
        builder: (context, state) => Scaffold(
          backgroundColor: appTheme.gray5001,
          resizeToAvoidBottomInset: false,
          appBar: state.currentIndex == 0 ? tavernAppBar(context) : null,
          body: screens(cubit, state)[state.currentIndex],
          bottomNavigationBar:
              BlocBuilder<TavernDashboardCubit, TavernDashboardState>(
            bloc: cubit,
            builder: (context, state) => Container(
              height: 70,
              decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.errorContainer)),
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
