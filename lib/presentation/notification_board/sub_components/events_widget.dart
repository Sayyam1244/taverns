import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:taverns/presentation/notification_board/sub_components/eventItem2.dart';
import '../../../core/app_export.dart';
import '../../../domain/model/event_model.dart';
import '../../../domain/model/general_model.dart';
import '../notification_board_cubit.dart';
import '../notification_board_state.dart';
import 'manage_item.dart';

class EventsWidget extends StatelessWidget {
  const EventsWidget({
    Key? key,
    required this.cubit,
    required this.state,
  }) : super(key: key);
  final NotificationBoardCubit cubit;
  final NotificationBoardState state;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Either<GeneralError, List<EventModel>>>(
      stream: cubit.event.getEvents(getUser: false, limit: 1000),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<EventModel> data = [];
          snapshot.data?.fold((l) => null, (r) {
            if (cubit.initialParams.userModel!.accountType != 'Tavern')
              r.removeWhere(
                  (element) => element.userId == cubit.auth.currentUser().uid);
            data = r;
          });
          return ListView.separated(
            separatorBuilder: (
              context,
              index,
            ) =>
                SizedBox(width: 16.h),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return EventItem2(
                event: data[index],
                cubit: cubit,
                requestToJoin: true,
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
