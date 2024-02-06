import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/core/utils/flushbar.dart';
import 'package:taverns/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:taverns/widgets/custom_elevated_button.dart';
import 'package:taverns/widgets/custom_text_form_field.dart';
import 'support_cubit.dart';
import 'support_state.dart';

class SupportPage extends StatefulWidget {
  final SupportCubit cubit;

  const SupportPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<SupportPage> createState() => _SupportState();
}

class _SupportState extends State<SupportPage> {
  SupportCubit get cubit => widget.cubit;
  TextEditingController email = TextEditingController();
  TextEditingController message = TextEditingController();

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
        title: AppbarSubtitleOne(text: "Support"),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          CustomTextFormField(
            controller: email,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            hintText: 'Email',
          ),
          SizedBox(height: 10),
          CustomTextFormField(
            controller: message,
            maxLines: 10,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            hintText: 'Message',
          ),
          SizedBox(height: 20),
          CustomElevatedButton(
            text: 'Submit',
            onPressed: () async {
              try {
                await FirebaseFirestore.instance.collection('support').add({
                  'from': email.text.trim(),
                  'message': message.text.trim(),
                  'datetime': FieldValue.serverTimestamp()
                });
                email.clear();
                message.clear();
                FlushbarDialogue().showFlushbar(
                    context: context,
                    body: 'Submitted Successfully',
                    title: 'Support');
              } catch (e) {
                FlushbarDialogue().showErrorFlushbar(
                    context: context,
                    body: 'Error Happened, Try again later',
                    title: 'Error');
              }
            },
          )
        ],
      ),
    );
  }
}
