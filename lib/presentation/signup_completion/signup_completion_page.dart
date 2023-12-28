import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'signup_completion_cubit.dart';
import 'signup_completion_state.dart';

class SignupCompletionPage extends StatefulWidget {
final SignupCompletionCubit cubit;

const SignupCompletionPage({
Key? key,
required this.cubit,
}) : super(key: key);

@override
State<SignupCompletionPage> createState() => _SignupCompletionState();
}

class _SignupCompletionState extends State<SignupCompletionPage> {

SignupCompletionCubit get cubit => widget.cubit;

@override
void initState() {
super.initState();
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(),
body: const SizedBox(),
);
}
}