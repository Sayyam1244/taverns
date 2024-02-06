import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/theme/theme_helper.dart';
import 'package:taverns/widgets/app_bar/appbar_subtitle_one.dart';
import 'safety_tips_cubit.dart';
import 'safety_tips_state.dart';

class SafetyTipsPage extends StatefulWidget {
  final SafetyTipsCubit cubit;

  const SafetyTipsPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<SafetyTipsPage> createState() => _SafetyTipsState();
}

class _SafetyTipsState extends State<SafetyTipsPage> {
  SafetyTipsCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70.v,
        backgroundColor: theme.colorScheme.background,
        elevation: 0,
        title: AppbarSubtitleOne(text: "Safety Tips"),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          Text(
            '''The primary point of the App is safety for everyone involved. 
The features are to ensure that people continue to use the app and are incentivized to use it for it’s ability to aid in keeping people safe.This will be done by connecting players and GM’s together with a PUBLIC place that they may play. (It focuses mostly on people who have never met and are meeting to play for the first time.)
I want to avoid the mistreatment, and harm to players and GM’s meeting for the first time by giving a suite of safety minded features. A check in feature will be used to give last known location at the time an event starts regardless of if the person clicks “Check-In or Not Attending” this is in the event the person becomes the subject of a police investigation.This feature will also allow people to rate GM’s and Taverns by having co-located GPS they will be allowed to rate events and GM’s asking for Pay-To-Play Game running services.''',
            style: CustomTextStyles.titlelarge.copyWith(
              color: appTheme.blueGray900,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
