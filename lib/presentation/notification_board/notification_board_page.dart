import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/presentation/notification_board/sub_components/manage_widget.dart';
import 'package:taverns/presentation/notification_board/sub_components/request_widget.dart';
import 'package:taverns/theme/theme_helper.dart';
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
        RequestWidget(
          cubit: cubit,
          state: state,
        ),
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
        title:
            Text('Notification Board', style: CustomTextStyles.titleMedium16),
      ),
      body: BlocBuilder<NotificationBoardCubit, NotificationBoardState>(
        buildWhen: (previous, current) {
          if (previous.isPostUploading != current.isPostUploading ||
              previous.eventDatetime != current.eventDatetime ||
              previous.index != current.index) {
            return true;
          }
          return false;
        },
        bloc: cubit,
        builder: (context, state) => Column(
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
            Expanded(child: tabs(cubit, state)[state.index])
          ],
        ),
      ),
    );
  }
}
