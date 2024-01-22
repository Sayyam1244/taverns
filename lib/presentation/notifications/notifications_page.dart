import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' as either;
import 'package:taverns/core/app_export.dart';
import 'package:taverns/presentation/notifications/sub_components/notification_item.dart';
import '../../domain/model/general_model.dart';
import '../../domain/model/notification_model.dart';
import '../../widgets/app_bar/appbar_subtitle_one.dart';
import '../../widgets/custome_loading_widget.dart';
import '../tavern_dasboard/widgets/notificaiton_board.dart';
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
    cubit.navigator.context = context;
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
        body:
            StreamBuilder<either.Either<GeneralError, List<NotificationModel>>>(
          stream: cubit.notification.getNotifications(
              userId: cubit.auth.currentUser().uid, limit: 1000),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<NotificationModel> data = [];
              snapshot.data!.fold((l) => null, (r) => data = r);
              if (data.isEmpty) {
                return Center(
                  child: Text(
                    'No Notification yet!',
                    style: CustomTextStyles.titleSmallMulishGray800,
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return ListView(
                children: data
                    .map((e) => GestureDetector(
                        onTap: () {
                          cubit.navigateToEventDetailScreen(eventId: e.eventId);
                        },
                        child: NotificationItem(notification: e)))
                    .toList(),
              );
            } else {
              return Center(child: CustomLoadingWidget());
            }
          },
        ),
      ),
    );
  }
}
