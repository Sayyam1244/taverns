import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:taverns/widgets/custome_loading_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'how_to_cubit.dart';

class HowToPage extends StatefulWidget {
  final HowToCubit cubit;

  const HowToPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<HowToPage> createState() => _HowToState();
}

class _HowToState extends State<HowToPage> {
  HowToCubit get cubit => widget.cubit;

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
        title: AppbarSubtitleOne(text: "How to"),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('app').doc('app').get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            DocumentSnapshot ss = snapshot.data as DocumentSnapshot;
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: [
                GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse(ss['YouTube']));
                  },
                  child: Text(
                    'YouTube Videos covering how to play specific them',
                    style: CustomTextStyles.titlelarge.copyWith(
                      color: appTheme.blue700,
                      decoration: TextDecoration.underline,
                      decorationColor: appTheme.blue700,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  '''YouTube Videos covering how to play specific themFree How-To guides on how to play the games and the rules behind them all.
I want to avoid the mistreatment, and harm to players and GM’s meeting for the first time by giving a suite of safety minded features. A check in feature will be used to give last known location at the time an event starts regardless of if the person clicks “Check-In or Not Attending” this is in the event the person becomes the subject of a police investigation.This feature will also allow people to rate GM’s and Taverns by having co-located GPS they will be allowed to rate events and GM’s asking for Pay-To-Play Game running services.''',
                  style: CustomTextStyles.titlelarge.copyWith(
                    color: appTheme.blueGray900,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                )
              ],
            );
          } else {
            return CustomLoadingWidget();
          }
        },
      ),
    );
  }
}
