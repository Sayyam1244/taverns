import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'how_to_cubit.dart';
import 'how_to_state.dart';

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
appBar: AppBar(),
body: const SizedBox(),
);
}
}