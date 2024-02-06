import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'faqs_cubit.dart';
import 'faqs_state.dart';

class FaqsPage extends StatefulWidget {
  final FaqsCubit cubit;

  const FaqsPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<FaqsPage> createState() => _FaqsState();
}

class _FaqsState extends State<FaqsPage> {
  FaqsCubit get cubit => widget.cubit;

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
