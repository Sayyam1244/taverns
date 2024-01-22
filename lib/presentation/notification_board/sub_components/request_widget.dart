import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:taverns/presentation/notification_board/sub_components/event_request.dart';
import 'package:taverns/widgets/custom_elevated_button.dart';

import '../../../core/app_export.dart';
import '../../../domain/model/event_model.dart';
import '../../../domain/model/general_model.dart';
import '../notification_board_cubit.dart';
import '../notification_board_state.dart';

class RequestWidget extends StatelessWidget {
  const RequestWidget({
    Key? key,
    required this.cubit,
    required this.state,
  }) : super(key: key);
  final NotificationBoardCubit cubit;
  final NotificationBoardState state;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Either<GeneralError, List<EventModel>>>(
      stream: cubit.event.getEventsRequestFromGM(
          userId: cubit.auth.currentUser().uid, getUser: true),
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
              return EventRequest(
                event: data[index],
                cubit: cubit,
              );
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
              margin: EdgeInsets.symmetric(
                  horizontal: SizeUtils.width * .05, vertical: 10.v),
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
