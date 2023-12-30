import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:taverns/widgets/custom_switch.dart';
import 'package:taverns/widgets/custom_toggle_switch_with_text.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle_two.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import 'notification_settings_cubit.dart';
import 'notification_settings_state.dart';

class NotificationSettingsPage extends StatefulWidget {
  final NotificationSettingsCubit cubit;

  const NotificationSettingsPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettingsPage> {
  NotificationSettingsCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          height: 70.h,
          // leading: AppbarLeadingImage(imagePath: ImageConstant.imgArrowLeft, margin: EdgeInsets.only(top: 20, bottom: 20), onTap: () {}),
          centerTitle: true,
          title: AppbarSubtitleOne(text: "Notifications Board"),
         
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            BlocBuilder<NotificationSettingsCubit, NotificationSettingsState>(
              bloc: cubit,
              builder: (ctx, state) => Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 5.v),
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage(ImageConstant.imgGroup2), fit: BoxFit.cover)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 75.v),
                      CustomToggleButtonWithPrefixText(
                        text: 'Likes and Reviews',
                        isSelected: state.likeReviews,
                        onChange: (v) {
                          cubit.toggleLikeReview();
                        },
                      ),
                      SizedBox(height: 20.v),
                      Divider(),
                      SizedBox(height: 24.v),
                      CustomToggleButtonWithPrefixText(
                        text: 'Events Near Me  ',
                        isSelected: state.eventsNearMe,
                        onChange: (v) {
                          cubit.toggleEventsNearMe();
                        },
                      ),
                      SizedBox(height: 20.v),
                      Divider(),
                      SizedBox(height: 25.v),
                      CustomToggleButtonWithPrefixText(
                        text: 'Time Slot Requests',
                        isSelected: state.timeSlots,
                        onChange: (v) {
                          cubit.toggleTimeSLot();
                        },
                      ),
                      SizedBox(height: 20.v),
                      Divider(),
                      SizedBox(height: 18.v),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
         bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 20.v),
          child: CustomElevatedButton(
            text: "Next",
            onPressed: () {
              cubit.saveNotificationSettings(context);
            },
          ),
        ),
      ),
    );
  }
}
