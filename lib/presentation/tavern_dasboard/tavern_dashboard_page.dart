import 'package:flutter/material.dart';
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
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray5001,
        resizeToAvoidBottomInset: false,
        appBar: tavernAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 2.v),
            child: Padding(
              padding: EdgeInsets.only(
                left: 2.h,
                bottom: 5.v,
              ),
              child: Column(
                children: [
                  TavernProfileWidget(),
                  SizedBox(height: 24.v),
                  NotificationBoardWidget(),
                  SizedBox(height: 24.v),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: CustomSearchView(
                      controller: searchController,
                      hintText: "Find Event",
                    ),
                  ),
                  SizedBox(height: 26.v),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Upcoming Events',
                          style: CustomTextStyles.titleMediumCircularStdBluegray800.copyWith(
                            color: appTheme.blueGray800,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 2.v,
                            bottom: 4.v,
                          ),
                          child: Text(
                            'See All',
                            style: CustomTextStyles.labelLargePrimary.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.v),
                  SizedBox(
                    height: 130.v,
                    child: ListView.separated(
                      padding: EdgeInsets.only(left: 13.h),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (
                        context,
                        index,
                      ) {
                        return SizedBox(
                          width: 16.h,
                        );
                      },
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return EventcardItemWidget();
                      },
                    ),
                  ),
                  SizedBox(height: 24.v),
                  CustomElevatedButton(
                    text: "Safety Tips",
                    margin: EdgeInsets.only(
                      left: 22.h,
                      right: 24.h,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 70,
          decoration: BoxDecoration(border: Border.all(color: theme.colorScheme.errorContainer)),
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: theme.colorScheme.errorContainer,
              selectedLabelStyle: CustomTextStyles.bottomBarSelected,
              unselectedLabelStyle: CustomTextStyles.bottomBarUnselected,
              showUnselectedLabels: true,
              showSelectedLabels: true,
              iconSize: 22,
              selectedItemColor: theme.colorScheme.primary,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Calender'),
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
                BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
              ]),
        ),
      ),
    );
  }
}
