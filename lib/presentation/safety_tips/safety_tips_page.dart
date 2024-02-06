import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
appBar: AppBar(),
body: const SizedBox(),
);
}
}