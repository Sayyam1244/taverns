import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'notification_board_cubit.dart';
import 'notification_board_state.dart';

class NotificationBoardPage extends StatefulWidget {
final NotificationBoardCubit cubit;

const NotificationBoardPage({
Key? key,
required this.cubit,
}) : super(key: key);

@override
State<NotificationBoardPage> createState() => _NotificationBoardState();
}

class _NotificationBoardState extends State<NotificationBoardPage> {

NotificationBoardCubit get cubit => widget.cubit;

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