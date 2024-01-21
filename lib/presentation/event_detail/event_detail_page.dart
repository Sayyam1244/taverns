import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/widgets/custom_elevated_button.dart';
import 'package:taverns/widgets/custom_rating_bar.dart';
import 'package:taverns/widgets/custom_text_form_field.dart';
import 'package:taverns/widgets/custome_loading_widget.dart';
import '../../widgets/app_bar/appbar_subtitle_one.dart';
import 'event_detail_cubit.dart';
import 'event_detail_state.dart';

class EventDetailPage extends StatefulWidget {
  final EventDetailCubit cubit;

  const EventDetailPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<EventDetailPage> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetailPage> {
  EventDetailCubit get cubit => widget.cubit;
  double rating = 1;
  TextEditingController reviewController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    cubit.getEvent(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.gray5001,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70.v,
        backgroundColor: theme.colorScheme.background,
        elevation: 0,
        title: AppbarSubtitleOne(text: "Event detail"),
      ),
      body: BlocBuilder<EventDetailCubit, EventDetailState>(
        bloc: cubit,
        builder: (context, state) => state.isLoading
            ? CustomLoadingWidget()
            : ListView(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: AppDecoration.fillOnErrorContainer.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder16,
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 60.adaptSize,
                              width: 60.adaptSize,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: 8.v),
                              decoration: BoxDecoration(
                                image: state.event!.user!.profilePicture != null
                                    ? DecorationImage(
                                        image: NetworkImage(
                                          state.event!.user!.profilePicture!,
                                        ),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: theme.colorScheme.primary,
                                  width: 1,
                                ),
                              ),
                            ),
                            SizedBox(width: 16.h),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.event!.eventName, style: CustomTextStyles.titleMediumSecondaryContainer),
                                  SizedBox(height: 8.v),
                                  Text(state.event!.user!.businessName!, style: CustomTextStyles.titleSmallCircularStdBluegray800),
                                  SizedBox(height: 4.v),
                                  Text(DateFormat('hh:mm:a - dd/MM/yyyy').format((state.event!.eventDatetime)), style: CustomTextStyles.titleSmallMulishGray800),
                                  SizedBox(height: 10.v),
                                  Text(state.event!.note, style: CustomTextStyles.bodySmallCircularStdBluegray40001.copyWith(height: 1.5)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.v),
                        Divider(),
                        eventDetailsinSection(
                          eventType: state.event!.eventType,
                          gameType: state.event!.gameType,
                          gameSystem: state.event!.gameSystem,
                          plan: state.event!.isFree ? 'Free' : 'Paid',
                        ),
                        Divider(),
                        SizedBox(height: 20),
                        if (!state.reviewSubmitted)
                          Column(
                            children: [
                              Form(
                                key: _formKey,
                                child: CustomTextFormField(
                                  controller: reviewController,
                                  contentPadding: EdgeInsets.all(16),
                                  hintText: 'Write a review',
                                  maxLength: 200,
                                  maxLines: 5,
                                  validator: (value) {
                                    if (value == '' || value == null) {
                                      return 'Field is empty';
                                    }
                                  },
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Rating   ',
                                    style: CustomTextStyles.bodySmallMulishBluegray900,
                                  ),
                                  CustomRatingBar(
                                    itemSize: 20.h,
                                    initialRating: rating,
                                    color: theme.colorScheme.primary,
                                    onRatingUpdate: (v) {
                                      rating = v;
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.v),
                              CustomElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    cubit.submitReview(text: reviewController.text.trim(), rating: rating.toInt(), context: context);
                                  }
                                },
                                text: 'Submit',
                              )
                            ],
                          )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

class eventDetailsinSection extends StatelessWidget {
  const eventDetailsinSection({
    Key? key,
    required this.eventType,
    required this.gameType,
    required this.gameSystem,
    required this.plan,
  }) : super(key: key);
  final String eventType;
  final String gameType;
  final String gameSystem;
  final String plan;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.v, left: 10.h, right: 10.h, bottom: 20.v),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Event Type',
                  style: CustomTextStyles.bodySmallSFProBluegray40001,
                ),
                SizedBox(height: 6.v),
                Text(
                  eventType,
                  style: CustomTextStyles.titleSmallProductSansBluegray800,
                ),
                SizedBox(height: 20.v),
                Text(
                  'Game System',
                  style: CustomTextStyles.bodySmallSFProBluegray40001,
                ),
                SizedBox(height: 6.v),
                Text(
                  gameSystem,
                  style: CustomTextStyles.titleSmallProductSansBluegray800,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Game Type',
                  style: CustomTextStyles.bodySmallSFProBluegray40001,
                ),
                SizedBox(height: 6.v),
                Text(
                  gameType,
                  style: CustomTextStyles.titleSmallProductSansBluegray800,
                ),
                SizedBox(height: 20.v),
                Text(
                  'Plan',
                  style: CustomTextStyles.bodySmallSFProBluegray40001,
                ),
                SizedBox(height: 6.v),
                Text(
                  plan,
                  style: CustomTextStyles.titleSmallProductSansBluegray800,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
