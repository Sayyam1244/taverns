import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/presentation/notifications/sub_components/notification_item.dart';
import '../../widgets/app_bar/appbar_subtitle_one.dart';
import '../../widgets/custome_loading_widget.dart';
import 'notifications_cubit.dart';
import 'notifications_state.dart';

class NotificationsPage extends StatefulWidget {
  final NotificationsCubit cubit;

  const NotificationsPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsState();
}

class _NotificationsState extends State<NotificationsPage> {
  NotificationsCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray5001,
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 70.v,
          backgroundColor: theme.colorScheme.background,
          elevation: 0,
          title: AppbarSubtitleOne(text: "Notifications"),
        ),
        body: BlocBuilder<NotificationsCubit, NotificationsState>(
          bloc: cubit,
          builder: (context, state) => state.isLoading
              ? CustomLoadingWidget()
              : ListView(
                  children: state.notifications
                      .map((e) => NotificationItem(notification: e))
                      .toList(),
                ),
        ),
      ),
    );
  }
}
