import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:taverns/widgets/custom_elevated_button.dart';

import '../../../core/app_export.dart';
import '../../../domain/model/event_model.dart';
import '../../../domain/model/general_model.dart';
import '../notification_board_cubit.dart';
import '../notification_board_state.dart';
import 'manage_item.dart';

class ManageWidget extends StatelessWidget {
  const ManageWidget({
    Key? key,
    required this.cubit,
    required this.state,
  }) : super(key: key);
  final NotificationBoardCubit cubit;
  final NotificationBoardState state;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Either<GeneralError, List<EventModel>>>(
      stream: cubit.event.getEvents(getUser: false, limit: 1000, userId: cubit.auth.currentUser().uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<EventModel> data = [];
          snapshot.data?.fold((l) => null, (r) => data = r);
          return ListView.separated(
            separatorBuilder: (
              context,
              index,
            ) =>
                SizedBox(width: 16.h),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ManageItem(event: data[index], cubit: cubit);
            },
          );
        }
        return ListView.separated(
          separatorBuilder: (
            context,
            index,
          ) =>
              SizedBox(width: 16.h),
          itemCount: 2,
          itemBuilder: (context, index) {
            return Container(
              height: 250,
              margin: EdgeInsets.symmetric(horizontal: SizeUtils.width * .05, vertical: 10.v),
              decoration: BoxDecoration(
                color: theme.colorScheme.background,
                borderRadius: BorderRadius.circular(
                  12,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
