import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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