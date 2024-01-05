import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/presentation/notification_board/sub_components/manage_widget.dart';
import 'package:taverns/theme/theme_helper.dart';
import 'package:taverns/widgets/app_bar/custom_app_bar.dart';
import 'package:taverns/widgets/custom_elevated_button.dart';
import 'package:taverns/widgets/custom_text_form_field.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'notification_board_cubit.dart';
import 'notification_board_state.dart';
import 'sub_components/post_widget.dart';

class NotificationBoardPage extends StatefulWidget {
  final NotificationBoardCubit cubit;

  const NotificationBoardPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<NotificationBoardPage> createState() => _NotificationBoardState();
}

class _NotificationBoardState extends State<NotificationBoardPage> {
  NotificationBoardCubit get cubit => widget.cubit;
  List<Widget> tabs(
          NotificationBoardCubit cubit, NotificationBoardState state) =>
      [
        PostWidget(
          cubit: cubit,
          state: state,
        ),
        ManageWidget(
          cubit: cubit,
          state: state,
        ),
        Text('g'),
      ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.gray5001,
      appBar: AppBar(
        toolbarHeight: 70.v,
        backgroundColor: theme.colorScheme.background,
        elevation: 0,
        title: Text(
          'Notification Board',
          style: theme.textTheme.titleLarge!.copyWith(fontSize: 16),
        ),
      ),
      body: BlocBuilder<NotificationBoardCubit, NotificationBoardState>(
        bloc: cubit,
        builder: (context, state) => ListView(
          children: [
            SizedBox(height: 20),
            Center(
              child: ToggleSwitch(
                customWidths: [
                  SizeUtils.width * .3,
                  SizeUtils.width * .3,
                  SizeUtils.width * .3,
                ],
                cornerRadius: 12,
                initialLabelIndex: state.index,
                totalSwitches: 3,
                activeBgColor: [theme.colorScheme.primary],
                inactiveBgColor: PrimaryColors().yellow50,
                labels: ['Post', 'Manage', 'Request'],
                onToggle: (index) {
                  cubit.changeIndex(index!);
                },
              ),
            ),
            tabs(cubit, state)[state.index]
          ],
        ),
      ),
    );
  }
}

class CustomDropdownWidget extends StatelessWidget {
  const CustomDropdownWidget({
    Key? key,
    required this.hinttext,
    required this.list,
  }) : super(key: key);
  final String hinttext;
  final List<String> list;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: appTheme.yellow50,
        borderRadius: BorderRadius.circular(16.h),
      ),
      alignment: Alignment.centerLeft,
      child: DropdownButton<String>(
        underline: Container(),
        isExpanded: true,
        dropdownColor: theme.colorScheme.primary,
        style: CustomTextStyles.titleSmallMulishBluegray700,
        items: list
            .map(
              (e) => DropdownMenuItem<String>(
                child: Text(e),
                value: e,
              ),
            )
            .toList(),
        onChanged: (v) {},
        hint: Text(hinttext),
      ),
    );
  }
}

class CustomIconDualTextButton extends StatelessWidget {
  const CustomIconDualTextButton({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
  }) : super(key: key);
  final String title;
  final String value;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: appTheme.yellow50,
        borderRadius: BorderRadius.circular(16.h),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: theme.colorScheme.primary,
          ),
          SizedBox(width: 10.h),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: CustomTextStyles.bodySmallSFProBluegray40001,
              ),
              SizedBox(height: 4.v),
              Text(
                value,
                style: CustomTextStyles.titleSmallProductSansBluegray800,
              ),
            ],
          ),
          SizedBox(width: 4.h),
        ],
      ),
    );
  }
}
